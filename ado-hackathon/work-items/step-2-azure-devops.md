# Step 2: Configure Azure DevOps for AI Agent Deployment 🔧

Now that Azure resources are ready, let's configure Azure DevOps to deploy agents!

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

#### Option 2: Service Principal with Secret (Manual) - Cross-Tenant

Use this if:
- ✅ Azure DevOps organization is in a **different tenant** than Azure resources
- ✅ You don't have Owner role to create automatic connections
- ✅ Your tenant has policies restricting automatic app registration

**Prerequisites - Get your Service Principal details from Step 1:**
- Application (client) ID
- Client Secret (starts with something like `PbZ8Q~...`)
- Tenant ID
- Subscription ID

**Steps:**
1. In Azure DevOps, go to **Project Settings** (bottom-left)
2. Under **Pipelines**, select **Service connections**
3. Click **New service connection**
4. Select **Azure Resource Manager** → **Next**
5. Select **App registration or managed identity (manual)**
6. Select **Credentials** for authentication type
7. **Fill in the details:**
   - **Environment:** Azure Cloud
   - **Scope Level:** Subscription
   - **Subscription ID:** Your subscription ID from Step 1
   - **Subscription Name:** Your subscription display name
   - **Service Principal Id (Application ID):** Your Application (client) ID
   - **Service principal key (Client Secret):** Your client secret
   - **Tenant ID:** Your tenant ID
   - **Service connection name:** (See names below)
   - **Description:** (Optional)
   - **Security:** Do NOT check "Grant access permission to all pipelines" ❌
8. Click **Verify** to test the connection
   - ✅ If verification succeeds, you'll see a green checkmark
   - ❌ If it fails, double-check all IDs match exactly
9. Click **Save**

⚠️ **Important:** Track your secret expiration date! Set a reminder to rotate before it expires.

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

💡 **Tip:** You can reuse the same service principal/app registration for all 3 connections - just create 3 service connections with different names pointing to the same credentials.


---

### 2. Create Variable Groups

Variable groups store configuration values that your pipelines can reference. This keeps credentials and settings centralized and reusable.

**Steps:**
1. In Azure DevOps, select **Pipelines** → **Library** from the left menu
2. Click **+ Variable group**

#### Create Dev Variable Group:

**Variable group name:** `agent-dev-vars`

**Add these variables:**
1. Click **+ Add** to add each variable:

```
AZURE_AI_PROJECT_DEV = https://your-ai-project.services.ai.azure.com/api/projects/your-project
AZURE_OPENAI_ENDPOINT_DEV = https://openai-aiagent-dev.openai.azure.com/
AZURE_OPENAI_KEY_DEV = [your-dev-openai-key] (🔒 lock it)
AZURE_OPENAI_API_VERSION_DEV = 2025-01-01-preview
AZURE_OPENAI_DEPLOYMENT_DEV = gpt-4o
AZURE_AI_MODEL_DEPLOYMENT_NAME = gpt-4o
AZURE_SUBSCRIPTION_ID = [your-subscription-id]
AZURE_TENANT_ID = [your-tenant-id]
AZURE_CLIENT_ID = [your-service-principal-client-id]
```

⚠️ **CRITICAL VARIABLES - The pipeline will fail without these:**
- `AZURE_AI_PROJECT_DEV` - Full Azure AI Project endpoint URL (format: `https://<account>.services.ai.azure.com/api/projects/<project>`)
- `AZURE_AI_MODEL_DEPLOYMENT_NAME` - The model deployment name in your Azure OpenAI (e.g., `gpt-4o`, `gpt-4.1`)

2. For `AZURE_OPENAI_KEY_DEV`, click the **🔒 lock icon** to make it secret (value will be hidden)

**To get your OpenAI Key:**
1. Go to Azure Portal → Your OpenAI resource (e.g., `openai-aiagent-dev`)
2. Click **Keys and Endpoint** in the left menu
3. Copy **KEY 1**
4. Paste into Azure DevOps variable group and click lock icon 🔒

3. Click **Save**

#### Create Test Variable Group:

**Variable group name:** `agent-test-vars`

Add the same variables but with `_TEST` suffix and test environment resource URLs:

```
AZURE_AI_PROJECT_TEST = https://your-ai-project.services.ai.azure.com/api/projects/your-project-test
AZURE_OPENAI_ENDPOINT_TEST = https://openai-aiagent-test.openai.azure.com/
AZURE_OPENAI_KEY_TEST = [your-test-openai-key] (🔒 lock it)
AZURE_OPENAI_API_VERSION_TEST = 2025-01-01-preview
AZURE_OPENAI_DEPLOYMENT_TEST = gpt-4o
AZURE_AI_MODEL_DEPLOYMENT_NAME = gpt-4o
AZURE_SUBSCRIPTION_ID = [your-subscription-id]
AZURE_TENANT_ID = [your-tenant-id]
AZURE_CLIENT_ID = [your-service-principal-client-id]
```

#### Create Prod Variable Group:

**Variable group name:** `agent-prod-vars`

Add the same variables but with `_PROD` suffix and prod environment resource URLs:

```
AZURE_AI_PROJECT_PROD = https://your-ai-project.services.ai.azure.com/api/projects/your-project-prod
AZURE_OPENAI_ENDPOINT_PROD = https://openai-aiagent-prod.openai.azure.com/
AZURE_OPENAI_KEY_PROD = [your-prod-openai-key] (🔒 lock it)
AZURE_OPENAI_API_VERSION_PROD = 2025-01-01-preview
AZURE_OPENAI_DEPLOYMENT_PROD = gpt-4o
AZURE_AI_MODEL_DEPLOYMENT_NAME = gpt-4o
AZURE_SUBSCRIPTION_ID = [your-subscription-id]
AZURE_TENANT_ID = [your-tenant-id]
AZURE_CLIENT_ID = [your-service-principal-client-id]
```

💡 **Tip:** You can get all OpenAI endpoints and keys from the `terraform output` command or from `azure-resources.md` file.

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

**Authentication Method:** [Workload Identity Federation / Service Principal with Secret]
**Created on:** [date]

## Variable Groups
- ✅ agent-dev-vars (7 variables, 1 secret)
- ✅ agent-test-vars (7 variables, 1 secret)
- ✅ agent-prod-vars (7 variables, 1 secret)

## Environments
- ✅ dev (no approvals)
- ✅ test (requires 1 approval)
- ✅ production (requires 2 approvals)

Configuration completed on: [date]
```

Save this file to your repository root.

---

## ✅ Completion Criteria

To complete this step and unlock Step 3:
1. ✅ Create the `azure-devops-config.md` file with your configuration details
2. ✅ Commit and push to main branch

```bash
git add azure-devops-config.md
git commit -m "Step 2: Complete Azure DevOps configuration"
git push origin main
```

The hackathon facilitator will detect your push and automatically create Step 3!

---

## 🔍 Verification Checklist

Before moving to Step 3, verify:
- [ ] 3 service connections created and **Verify** button shows success ✅
- [ ] 3 variable groups created with all required variables
- [ ] OpenAI keys are marked as **secret** (🔒 lock icon shows)
- [ ] All endpoints use correct format:
  - AI Project: `https://aiagent-{env}.api.azureml.ms`
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
  - Double-check Application ID, Secret, Tenant ID, and Subscription ID match exactly
  - Ensure service principal has **Contributor** role on subscription
  - Check that secret hasn't expired
- **Cross-tenant scenario:** Must use "App registration or managed identity (manual)" option
- **"Access Denied" error:** Service principal needs proper RBAC role assignment in Azure Portal

**Variable Groups:**
- **Variable group not found in pipeline:** Check exact naming (case-sensitive: `agent-dev-vars`)
- **Can't access Library:** Need **Project Administrator** or **Library Administrator** role
- **Secret values not working:** Ensure you clicked the 🔒 lock icon after entering the value
- **Wrong endpoint format:** 
  - ✅ Correct: `https://openai-aiagent-dev.openai.azure.com/`
  - ❌ Wrong: `https://openai-aiagent-dev.openai.azure.com` (missing trailing slash)

**Environments:**
- **Can't create environment:** Need **Environment Creator** role
- **Can't add approvals:** Need **Environment Administrator** role
- **Approvals not triggering:** Ensure pipeline references environment in deployment job (not regular job)

**Security Notes:**
- ⚠️ Service principal secrets expire (check expiration date and set calendar reminder)
- 🔄 Rotate secrets before expiration (Microsoft recommends 30-90 days)
- ⭐ Consider migrating to Workload Identity Federation (no secret rotation needed)
- 🔒 Never commit secrets to your repository
- 📝 Use Azure Key Vault for production secrets (advanced setup)


---

## ⏭️ What's Next?

After pushing your `azure-devops-config.md` file, the hackathon facilitator will automatically:
1. ✅ Detect your completion
2. ✅ Close this work item (Step 2)
3. ✅ Create **Step 3: Create Agent Creation Pipeline**

Get ready to create your first CI/CD pipeline that will build and deploy AI agents! 🚀

**What you'll learn in Step 3:**
- YAML pipeline syntax
- Multi-stage pipelines
- Using variable groups and service connections
- Artifact publishing
- Deployment jobs

