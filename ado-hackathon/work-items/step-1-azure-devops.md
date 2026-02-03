# Step 1: Configure Azure DevOps for AI Agent Deployment 🔧

Now that Azure resources are ready (from the prerequisites), let's configure Azure DevOps to deploy agents!

## 🎯 Goal
Set up service connections, variable groups, and environments in Azure DevOps for the CI/CD pipelines.

## 📋 What You'll Configure
- 3 Service Connections (dev, test, prod)
- 3 Variable Groups with deployment credentials
- 3 Environments with approval gates

## 🔨 Tasks

### 1. Create Service Connections

Service connections authenticate Azure DevOps to your Azure subscription. **Microsoft recommends using Workload Identity Federation** for better security, but secrets are still supported for specific scenarios.

#### 🎓 Learning Note: Federation vs Secrets

**Workload Identity Federation (Recommended):**
- ✅ **No secrets to manage** - No passwords or keys to rotate
- ✅ **More secure** - Uses OpenID Connect (OIDC) tokens instead of long-lived secrets
- ✅ **Automatic** - Azure DevOps can set this up for you if you have Owner role
- ⚠️ **Limitation** - Requires both Azure DevOps and Azure resources in the same tenant

**Service Principal with Secret:**
- ⚠️ **Requires secret rotation** - Secrets expire and must be manually renewed (30-365 days)
- ⚠️ **Security risk** - Secrets can be exposed if not properly managed
- ✅ **Works cross-tenant** - Use when Azure DevOps is in a different tenant than Azure resources
- ✅ **Manual control** - Useful when tenant policies restrict automatic app creation

---

#### Option 1: Workload Identity Federation (Automatic) - RECOMMENDED ⭐

Use this if:
- ✅ You have Owner role on your Azure subscription
- ✅ Azure DevOps and Azure resources are in the **same tenant**
- ✅ You want the most secure option with no secrets to manage

**Steps:**
1. In Azure DevOps, go to **Project Settings** (bottom-left)
2. Under **Pipelines**, select **Service connections**
3. Click **New service connection**
4. Select **Azure Resource Manager** → **Next**
5. Select **App registration (automatic)** with credential **Workload Identity federation**
6. Select **Scope Level**: **Subscription**
   - **Subscription:** Select your Azure subscription
   - **Resource group:** Leave empty for subscription-level access
7. **Service connection name:** (See names below)
8. **Description:** (Optional, e.g., "Dev environment for AI agent deployment")
9. **Security:** Do NOT check "Grant access permission to all pipelines" ❌
   - Instead, authorize each pipeline individually (more secure)
10. Click **Save**

---

#### Option 2: Manual Setup (Cross-Tenant or Restricted Permissions)

Use this only if:
- ✅ Azure DevOps organization is in a **different tenant** than Azure resources
- ✅ You don't have Owner role to create automatic connections
- ✅ Your tenant has policies restricting automatic app registration

**Steps:**
1. In Azure DevOps, go to **Project Settings** (bottom-left)
2. Under **Pipelines**, select **Service connections**
3. Click **New service connection**
4. Select **Azure Resource Manager** → **Next**
5. Select **App registration or managed identity (manual)**
6. Select **Workload identity federation** for authentication type
7. Follow the instructions to create a federated credential in Azure AD
8. Click **Save**

> 💡 **Note:** For cross-tenant scenarios, you may need to manually create an App Registration in Azure AD first. Consult your Azure administrator.

---

**Create 3 connections (use the same method for all 3):**

#### Dev Connection:
- Service connection name: `AZURE_SERVICE_CONNECTION_DEV`
- Description: "Dev environment for AI agent deployment"

#### Test Connection:
- Service connection name: `AZURE_SERVICE_CONNECTION_TEST`
- Description: "Test environment for AI agent deployment"

#### Prod Connection:
- Service connection name: `AZURE_SERVICE_CONNECTION_PROD`
- Description: "Production environment for AI agent deployment"

💡 **Tip:** You can use the same service connection for all environments if your subscription is the same, but separate connections provide better isolation.


---

### 2. Create Variable Groups

Variable groups store configuration values that your pipelines can reference. This keeps credentials and settings centralized and reusable.

**📋 Get Values from Terraform Output:**
Run `terraform output` in the `/terraform` folder to get all the environment variable values you need!

**Steps:**
1. In Azure DevOps, select **Pipelines** → **Library** from the left menu
2. Click **+ Variable group**

#### Create Dev Variable Group:

**Variable group name:** `agent-dev-vars`

**Add these variables:**
1. Click **+ Add** to add each variable:

```
AZURE_AI_PROJECT_ENDPOINT_DEV = [from terraform output: ai_project_endpoints.dev]
AZURE_OPENAI_ENDPOINT_DEV = [from terraform output: openai_endpoints.dev]
AZURE_OPENAI_KEY_DEV = [get from Azure Portal] (🔒 lock it)
AZURE_OPENAI_API_VERSION_DEV = 2025-01-01-preview
AZURE_OPENAI_DEPLOYMENT_DEV = gpt-4o
AZURE_AI_MODEL_DEPLOYMENT_NAME = gpt-4o
```

⚠️ **CRITICAL VARIABLES - The pipeline will fail without these:**
- `AZURE_AI_PROJECT_ENDPOINT_DEV` - Full Azure AI Project endpoint URL (from terraform output)
- `AZURE_AI_MODEL_DEPLOYMENT_NAME` - The model deployment name in your Azure OpenAI (e.g., `gpt-4o`)

2. For `AZURE_OPENAI_KEY_DEV`, click the **🔒 lock icon** to make it secret (value will be hidden)

**To get your OpenAI Key:**
1. Go to Azure Portal → Your AI Services resource (e.g., `aiagent-xxx-dev-aifoundry`)
2. Click **Keys and Endpoint** in the left menu
3. Copy **KEY 1**
4. Paste into Azure DevOps variable group and click lock icon 🔒

3. Click **Save**

#### Create Test Variable Group:

**Variable group name:** `agent-test-vars`

Add the same variables but with `_TEST` suffix and test environment values:

```
AZURE_AI_PROJECT_ENDPOINT_TEST = [from terraform output: ai_project_endpoints.test]
AZURE_OPENAI_ENDPOINT_TEST = [from terraform output: openai_endpoints.test]
AZURE_OPENAI_KEY_TEST = [get from Azure Portal] (🔒 lock it)
AZURE_OPENAI_API_VERSION_TEST = 2025-01-01-preview
AZURE_OPENAI_DEPLOYMENT_TEST = gpt-4o
AZURE_AI_MODEL_DEPLOYMENT_NAME = gpt-4o
```

#### Create Prod Variable Group:

**Variable group name:** `agent-prod-vars`

Add the same variables but with `_PROD` suffix and prod environment values:

```
AZURE_AI_PROJECT_ENDPOINT_PROD = [from terraform output: ai_project_endpoints.prod]
AZURE_OPENAI_ENDPOINT_PROD = [from terraform output: openai_endpoints.prod]
AZURE_OPENAI_KEY_PROD = [get from Azure Portal] (🔒 lock it)
AZURE_OPENAI_API_VERSION_PROD = 2025-01-01-preview
AZURE_OPENAI_DEPLOYMENT_PROD = gpt-4o
AZURE_AI_MODEL_DEPLOYMENT_NAME = gpt-4o
```

💡 **Tip:** Run `terraform output azure_devops_setup_instructions` for a complete list of values to copy!

---

### 3. Create Environments

Environments enable deployment tracking, history, and approval gates. They represent logical deployment targets (Dev, Test, Production).

**Steps:**
1. In Azure DevOps, select **Pipelines** → **Environments** from the left menu
2. Click **Create environment** or **New environment**

#### Dev Environment:

1. **Name:** `dev`
2. **Description:** "Development environment for AI agents"
3. **Resource:** Select **None** (we're not adding specific resources)
4. Click **Create**

✅ No approvals needed for dev - developers should be able to deploy quickly!

---

#### Test Environment:

1. **Name:** `test`
2. **Description:** "Test environment for AI agents"
3. **Resource:** Select **None**
4. Click **Create**

**Add Approvals:**
1. After creation, click on the **test** environment
2. Click the **⋮** (three dots in top right) → **Approvals and checks**
3. Click **+** → **Approvals**
4. **Approvers:** Add yourself or team members (e.g., QA team)
5. **Instructions for approver:** "Review test deployment logs before approving"
6. **Advanced:**
   - **Timeout:** 30 days (how long to wait before auto-rejecting)
   - **Minimum number of approvers:** 1
7. Click **Create**

---

#### Production Environment:

1. **Name:** `production`
2. **Description:** "Production environment for AI agents"
3. **Resource:** Select **None**
4. Click **Create**

**Add Approvals (More Strict):**
1. After creation, click on the **production** environment
2. Click **⋮** → **Approvals and checks**
3. Click **+** → **Approvals**
4. **Approvers:** Add required approvers (e.g., tech lead, manager, release manager)
5. **Instructions for approver:** "Review production deployment checklist:
   - ✅ Test environment validation passed
   - ✅ All tests green
   - ✅ Performance metrics acceptable
   - ✅ Security scan completed"
6. **Advanced:**
   - **Timeout:** 7 days
   - **Minimum number of approvers:** 2 (require multiple sign-offs for prod)
7. Click **Create**

💡 **Best Practice:** Production should have the strictest controls - multiple approvers, business hours checks, and change management integration.

---

### 4. Document Your Configuration

Create a file `azure-devops-config.md` in your repository root to track what you configured:


```markdown
# Azure DevOps Configuration

## Service Connections
- ✅ AZURE_SERVICE_CONNECTION_DEV
- ✅ AZURE_SERVICE_CONNECTION_TEST
- ✅ AZURE_SERVICE_CONNECTION_PROD

**Authentication Method:** Workload Identity Federation (Recommended)
**Created on:** [date]

## Variable Groups
- ✅ agent-dev-vars (6 variables, 1 secret)
- ✅ agent-test-vars (6 variables, 1 secret)
- ✅ agent-prod-vars (6 variables, 1 secret)

## Environments
- ✅ dev (no approvals)
- ✅ test (requires 1 approval)
- ✅ production (requires 2 approvals)

Configuration completed on: [date]
```

Save this file to your repository root.

---

## ✅ Completion Criteria

To complete this step and unlock Step 2:
1. ✅ Create the `azure-devops-config.md` file with your configuration details
2. ✅ Commit and push to main branch

```bash
git add azure-devops-config.md
git commit -m "Step 1: Complete Azure DevOps configuration"
git push origin main
```

The hackathon facilitator will detect your push and automatically create Step 2!

---

## 🔍 Verification Checklist

Before moving to Step 2, verify:
- [ ] 3 service connections created and **Verify** button shows success ✅
- [ ] 3 variable groups created with all required variables
- [ ] OpenAI keys are marked as **secret** (🔒 lock icon shows)
- [ ] All endpoints use correct format (from terraform output):
  - AI Project Endpoint: `https://<prefix>-<env>.services.ai.azure.com/api/projects/<project-name>`
  - OpenAI: `https://openai-aiagent-{env}.openai.azure.com/` (with trailing slash!)
- [ ] 3 environments created (dev, test, production)
- [ ] Test environment has approvals configured
- [ ] Production environment has approvals configured
- [ ] `azure-devops-config.md` file created and pushed

---

## 📚 Resources

- [Service Connections Documentation](https://learn.microsoft.com/azure/devops/pipelines/library/service-endpoints)
- [Connect to Azure with Workload Identity](https://learn.microsoft.com/en-us/azure/devops/pipelines/library/connect-to-azure?view=azure-devops)
- [Manual Workload Identity Setup](https://learn.microsoft.com/en-us/azure/devops/pipelines/release/configure-workload-identity?view=azure-devops)
- [Service Principal with Secret (Special Cases)](https://learn.microsoft.com/en-us/azure/devops/pipelines/library/azure-resource-manager-alternate-approaches?view=azure-devops)
- [Variable Groups Documentation](https://learn.microsoft.com/azure/devops/pipelines/library/variable-groups)
- [Environments and Approvals](https://learn.microsoft.com/en-us/azure/devops/pipelines/process/environments?view=azure-devops)
- [Define Approvals and Checks](https://learn.microsoft.com/en-us/azure/devops/pipelines/process/approvals?view=azure-devops)

---

## 🆘 Need Help?

**Common Issues:**

**Service Connections:**
- **Can't create service connection:** Ensure you have **Project Administrator** role
- **Verification fails:** 
  - Ensure you have Owner or Contributor role on the Azure subscription
  - Check that Azure DevOps and Azure are in the same tenant (for automatic setup)
- **Cross-tenant scenario:** Must use "App registration or managed identity (manual)" option
- **"Access Denied" error:** Ensure your Azure account has proper RBAC role assignment

**Variable Groups:**
- **Variable group not found in pipeline:** Check exact naming (case-sensitive: `agent-dev-vars`)
- **Can't access Library:** Need **Project Administrator** or **Library Administrator** role
- **Secret values not working:** Ensure you clicked the 🔒 lock icon after entering the value
- **Wrong endpoint format:** Use values exactly as shown in terraform output

**Environments:**
- **Can't create environment:** Need **Environment Creator** role
- **Can't add approvals:** Need **Environment Administrator** role
- **Approvals not triggering:** Ensure pipeline references environment in deployment job (not regular job)

**Security Notes:**
- ⭐ Workload Identity Federation is recommended (no secrets to manage!)
- 🔒 Never commit secrets to your repository
- 📝 OpenAI keys should always be marked as secret in variable groups


---

## ⏭️ What's Next?

After pushing your `azure-devops-config.md` file, the hackathon facilitator will automatically:
1. ✅ Detect your completion
2. ✅ Close this work item (Step 1)
3. ✅ Create **Step 2: Create Agent Creation Pipeline**

Get ready to create your first CI/CD pipeline that will build and deploy AI agents! 🚀

**What you'll learn in Step 2:**
- YAML pipeline syntax
- Multi-stage pipelines
- Using variable groups and service connections
- Artifact publishing
- Deployment jobs

