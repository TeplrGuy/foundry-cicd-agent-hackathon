# Azure DevOps AI Agent Deployment Hackathon

An interactive, self-paced hackathon for learning AI agent deployment and evaluation using Azure DevOps CI/CD pipelines.

## ✨ Simplified Setup

Create just **ONE** facilitator pipeline that automatically monitors your progress and creates work items as you complete steps!

## 🎯 What You'll Learn

This hackathon teaches you how to deploy, test, and secure AI agents using Azure DevOps CI/CD:

### Core Skills

1. **⚙️ CI/CD Configuration** - Configure Azure DevOps for AI agent deployment
2. **🤖 AI Agent Deployment** - Deploy agents using the `/cicd/createagentpipeline.yml`
3. **🚀 Multi-Environment Deployment** - Deploy across dev → test → prod
4. **🧪 Agent Evaluation** - Test agents using the `/cicd/agentconsumptionpipeline.yml`
5. **📊 Quality Assurance** - Evaluate agent performance and quality metrics
6. **🔒 Security Testing** - Review red team security vulnerability assessments

### What Makes This Unique

- 🎮 **Interactive Learning**: GitHub Skills-style experience in Azure DevOps
- 🤖 **Real AI Agents**: Deploy actual AI agents to Azure AI Foundry
- 🔄 **Production Pipelines**: Use real-world CI/CD templates from `/cicd`
- 🔒 **Security First**: Red team testing and vulnerability assessment
- 📊 **Quality Focused**: Agent evaluation with metrics and benchmarks

## 🚀 How It Works

This hackathon uses Azure DevOps pipelines and work items to guide you through building a complete AI agent deployment solution:

1. **Prerequisites**: Deploy Azure AI resources using Terraform (one-time setup)
2. **One-Time Setup**: Create the hackathon facilitator pipeline and run it once
3. **Automated Monitoring**: The facilitator watches for step completion
4. **Work Item Progression**: New work items are created automatically with next instructions
5. **Hands-On Learning**: Deploy real AI agents across environments

### The Magic: Hackathon Facilitator Pipeline

The facilitator pipeline (`hackathon-facilitator.yml`):
- ✅ **Initializes** the hackathon on first run (creates Epic + Step 1)
- ✅ **Triggers automatically** on every push to main
- ✅ **Detects** when you complete each step
- ✅ **Closes** completed step work items
- ✅ **Creates** next step work items with instructions
- ✅ **Handles all 6 steps** from one place

## 📋 Prerequisites

Before starting the hackathon, you must complete these setup steps:

### Required Tools
- **Azure CLI** installed and authenticated (`az login`)
- **Terraform** installed (`terraform --version`)
- **Azure subscription** with permissions to create resources
- **Azure DevOps** organization and project
- **Python 3.9+** installed locally (for testing)
- **Basic knowledge** of YAML, Git, and Azure DevOps

### 🔧 Deploy Azure AI Resources (REQUIRED - Do This First!)

Before starting the hackathon, deploy the Azure AI infrastructure using Terraform:

```bash
# Navigate to terraform directory
cd terraform

# Run the deployment script (recommended)
./deploy.sh

# Or manually:
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your subscription ID
terraform init
terraform plan
terraform apply
```

This creates **21 Azure resources** across 3 environments (dev, test, prod):
- Azure AI Foundry (with GPT-4o model)
- Resource Groups
- Storage Accounts
- Key Vaults
- Application Insights
- Log Analytics Workspaces

**After deployment:**
1. **Copy the terraform output** - It contains all the environment variables you'll need for Azure DevOps variable groups
2. **Get OpenAI keys** from Azure Portal (Keys and Endpoint page for each AI Services resource)
3. The `azure-resources.md` file is auto-generated with your deployment details

⏱️ **Time:** 10-15 minutes

> **Note:** The hackathon automatically detects your Azure DevOps project's process template and creates compatible work items. It supports:
> - **Agile** process (creates "User Story" work items)
> - **Scrum** process (creates "Product Backlog Item" work items)  
> - **Basic** process (creates "Issue" work items)
> - **CMMI** process (creates "Requirement" work items)

## 🏁 Getting Started

### Step 1: Import this Repository to Azure DevOps

1. Go to your Azure DevOps organization
2. Create a new project or use an existing one
3. Navigate to **Repos** → **Files**
4. Click **Import** or **Import repository**
5. Use this repository URL: `https://github.com/TeplrGuy/foundrycicdbasic`
6. Click **Import**

⏱️ **Time:** 2 minutes

### Step 2: Create the Facilitator Pipeline (ONE Pipeline!)

**Create just ONE pipeline - the hackathon facilitator:**

1. Go to **Pipelines** → **Pipelines**
2. Click **New pipeline**
3. Select **Azure Repos Git**
4. Select your repository
5. Choose **Existing Azure Pipelines YAML file**
6. Path: `/ado-hackathon/pipelines/hackathon-facilitator.yml`
7. Click **Save**

⏱️ **Time:** 2 minutes

> **💡 Why just one pipeline?** The facilitator handles everything: initialization, progress detection, and work item creation.

### Step 3: Run the Facilitator Pipeline

Run it once to initialize the hackathon:

1. Go to **Pipelines** → **Pipelines**
2. Find the **hackathon-facilitator** pipeline
3. Click **Run pipeline**
4. Click **Run**
5. Wait for it to complete (creates Epic and Step 1 work items)

⏱️ **Time:** 1 minute

### Step 4: Follow the Work Items

Once initialized:
1. Go to **Boards** → **Work Items**
2. Find **"Step 1: Configure Azure DevOps for AI Agent Deployment"** work item
3. Read the instructions carefully
4. Complete the step
5. **Commit and push your changes**
6. **Facilitator automatically triggers** and creates Step 2!
7. Repeat for all 6 steps

## 📚 Repository Structure

```
foundrycicdbasic/
├── cicd/                              # ⭐ Production pipelines
│   ├── README.md                      # Pipeline documentation
│   ├── createagentpipeline.yml        # AI agent deployment pipeline
│   └── agentconsumptionpipeline.yml   # Agent evaluation pipeline
├── terraform/                         # 📋 Infrastructure as Code (prerequisites)
│   ├── main.tf                        # Azure resource definitions
│   ├── variables.tf                   # Configuration variables
│   ├── outputs.tf                     # Environment variable outputs
│   └── deploy.sh                      # One-click deployment script
├── ado-hackathon/
│   ├── README.md                      # This file
│   ├── pipelines/
│   │   └── hackathon-facilitator.yml  # ⭐ The ONE pipeline you need
│   └── work-items/                    # Instructions for each step
│       ├── step-1-azure-devops.md
│       ├── step-2-create-agent-pipeline.md
│       ├── step-3-deploy-agents.md
│       ├── step-4-create-testing-pipeline.md
│       ├── step-5-run-evaluation.md
│       └── step-6-security-redteam.md
├── agenteval.py                       # Agent evaluation script
├── redteam.py                         # Security red team testing
├── createagent.py                     # Agent creation helper
└── requirements.txt                   # Python dependencies
```

## 🎓 Step-by-Step Journey

The hackathon facilitator automatically creates work items with detailed instructions. If you need to follow steps manually, use these links:

| Step | Title | Description |
|------|-------|-------------|
| **Prerequisites** | [Deploy Azure AI Resources](../terraform/README.md) | Run Terraform to create Azure AI infrastructure |
| **Step 1** | [Configure Azure DevOps](work-items/step-1-azure-devops.md) | Set up service connections, variable groups, and environments |
| **Step 2** | [Create Agent Pipeline](work-items/step-2-create-agent-pipeline.md) | Build your first CI/CD pipeline for agent deployment |
| **Step 3** | [Deploy Agents](work-items/step-3-deploy-agents.md) | Run pipeline and deploy agents to dev/test/prod |
| **Step 4** | [Create Testing Pipeline](work-items/step-4-create-testing-pipeline.md) | Build evaluation and security testing pipeline |
| **Step 5** | [Run Evaluation](work-items/step-5-run-evaluation.md) | Execute agent quality evaluation and review metrics |
| **Step 6** | [Security Red Team](work-items/step-6-security-redteam.md) | Review security vulnerabilities and complete hackathon |

---

## 🔄 How the Facilitator Works

### First Run (Initialization)

```
User runs facilitator pipeline (manual)
  ↓
Facilitator checks: Is Epic created?
  ↓ No
Creates Epic: "🤖 AI Agent Deployment Hackathon"
  ↓
Creates Step 1 work item with instructions
  ↓
User starts working on Step 1
```

### Subsequent Runs (Automatic Progression)

```
User completes Step 1 (configures Azure DevOps)
  ↓
User pushes to main branch
  ↓
Facilitator triggers automatically
  ↓
Checks: Which step is open?
  ↓
Found: Step 1 is open
  ↓
Checks: Step completion criteria met?
  ↓ Yes!
Closes Step 1 work item
  ↓
Creates Step 2 work item with instructions
  ↓
User continues to Step 2
```

### Step Detection Strategy

The facilitator monitors work items and progression through the hackathon steps. Each step work item contains detailed instructions, and the facilitator advances you to the next step based on your progress.

## 🐛 Troubleshooting

### Nothing happens after I complete a step

**Most Common Issue:** Facilitator pipeline didn't trigger after your push

**Solutions:**

1. **Check if pipeline ran:**
   - Go to **Pipelines** → **Pipelines**
   - Find **hackathon-facilitator** pipeline
   - Check recent runs
   - Look at logs for any errors

2. **Manually trigger:**
   - Click **Run pipeline** on the facilitator
   - It will detect your progress and create next work item

3. **Verify you pushed to main:**
   ```bash
   git status
   git log --oneline -1
   git remote -v
   ```

### Pipeline fails with work item errors

**Issue:** "No suitable work item type found" or similar errors

**Solution:**
- The facilitator tries multiple work item types automatically
- Check you have permission to create work items
- Verify your project has compatible work item types (User Story, Issue, etc.)
- Check **Project Settings** → **Boards** → **Process**

### Azure AI resources not found

**Issue:** Pipelines fail because AI endpoints aren't configured

**Solution:**
- Complete Prerequisites: Deploy Azure AI resources using Terraform
- Complete Step 1 fully: Set up service connections and variables
- Verify endpoints in Azure AI Foundry
- Check variable groups exist in Azure DevOps

### Agent deployment fails

**Issue:** `/cicd/createagentpipeline.yml` fails to deploy agents

**Solution:**
- Check service connection is valid
- Verify AI project endpoints are correct
- Ensure OpenAI resources are created
- Check pipeline variables are set correctly
- Review pipeline logs for specific errors

### Evaluation pipeline fails

**Issue:** `/cicd/agentconsumptionpipeline.yml` fails

**Solution:**
- Ensure agents are deployed first (Step 3)
- Check agent names match configuration
- Verify test environment is accessible
- Review Python dependencies in requirements.txt

### How do I know what step I'm on?

**Check:**
- **Boards** → **Work Items** → Look for open work items
- Or run the facilitator pipeline manually - it will show your current step in the logs

### I want to start over

**Solution:**
1. Close all open work items manually (Go to Boards → Work Items)
2. Run the facilitator pipeline again
3. It will detect no Epic exists and reinitialize

## 🎉 Completion

When you complete all 6 steps:
- The facilitator will show a celebration message
- Your Epic will be updated with completion status
- You'll have a complete AI agent deployment pipeline!

**Skills you'll have mastered:**
- ✅ Azure AI infrastructure setup
- ✅ Azure DevOps CI/CD pipeline creation
- ✅ AI agent deployment to Azure AI Foundry
- ✅ Multi-environment deployment strategies (dev → test → prod)
- ✅ Agent evaluation and quality assurance
- ✅ Security testing and vulnerability assessment
- ✅ DevSecOps best practices for AI agents

## 📖 Additional Documentation

- **[Work Item Files](work-items/)** - Detailed instructions for each step
- **[/cicd Pipelines](../cicd/)** - Production-ready pipeline templates
- **[/terraform](../terraform/)** - Infrastructure as Code for Azure resources

## 🤝 Contributing

Found an issue or have a suggestion? Please open an issue or submit a pull request!

## 📄 License

This project is licensed under the MIT License.

---

**Ready to start?** Run the Terraform scripts in `/terraform`, then create the facilitator pipeline and begin your AI agent deployment journey! 🚀
