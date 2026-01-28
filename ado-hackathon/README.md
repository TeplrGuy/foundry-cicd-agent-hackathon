# Azure DevOps AI Agent Deployment Hackathon

An interactive, self-paced hackathon for learning AI agent deployment and evaluation using Azure DevOps CI/CD pipelines.

> **🚀 New to the hackathon?** Start with the **[Quick Start Guide →](./QUICKSTART.md)** (5 minutes setup!)

## ✨ What's New - Simplified Setup!

**We've dramatically simplified the hackathon setup:**

- **Before:** Create multiple separate pipelines (confusing and error-prone)
- **Now:** Create just **ONE** facilitator pipeline (simple and reliable!)

The new hackathon facilitator pipeline automatically monitors your progress and creates work items as you complete steps. No more worrying about which pipelines to create!

## 🎯 What You'll Learn

This hackathon teaches you how to deploy, test, and secure AI agents using Azure DevOps CI/CD:

### Core Skills

1. **🔧 Azure AI Infrastructure** - Set up Azure AI Projects and OpenAI resources
2. **⚙️ CI/CD Configuration** - Configure Azure DevOps for AI agent deployment
3. **🤖 AI Agent Deployment** - Deploy agents using the `/cicd/createagentpipeline.yml`
4. **🧪 Agent Evaluation** - Test agents using the `/cicd/agentconsumptionpipeline.yml`
5. **🔒 Security Testing** - Review red team security vulnerability assessments
6. **🚀 Multi-Environment Deployment** - Deploy across dev → test → prod
7. **📊 Quality Assurance** - Evaluate agent performance and quality metrics

### What Makes This Unique

- 🎮 **Interactive Learning**: GitHub Skills-style experience in Azure DevOps
- 🤖 **Real AI Agents**: Deploy actual AI agents to Azure AI Foundry
- 🔄 **Production Pipelines**: Use real-world CI/CD templates from `/cicd`
- 🔒 **Security First**: Red team testing and vulnerability assessment
- 📊 **Quality Focused**: Agent evaluation with metrics and benchmarks

## 🚀 How It Works

This hackathon uses Azure DevOps pipelines and work items to guide you through building a complete AI agent deployment solution:

1. **One-Time Setup**: Create the hackathon facilitator pipeline and run it once
2. **Automated Monitoring**: The facilitator watches for step completion
3. **Work Item Progression**: New work items are created automatically with next instructions
4. **Hands-On Learning**: Deploy real AI agents across environments
5. **Interactive Feedback**: Get immediate feedback as you progress

### The Magic: Hackathon Facilitator Pipeline

The facilitator pipeline (`hackathon-facilitator.yml`):
- ✅ **Initializes** the hackathon on first run (creates Epic + Step 1)
- ✅ **Triggers automatically** on every push to main
- ✅ **Detects** when you complete each step
- ✅ **Closes** completed step work items
- ✅ **Creates** next step work items with instructions
- ✅ **Handles all 7 steps** from one place

## 📋 Prerequisites

- **Azure DevOps** organization and project
- **Azure subscription** with permissions to create resources
- **Azure AI** access for creating AI Projects and OpenAI resources
- **Basic knowledge** of YAML, Git, and Azure DevOps
- **Python 3.9+** installed locally (for testing)

> **Note:** The hackathon automatically detects your Azure DevOps project's process template and creates compatible work items. It supports:
> - **Agile** process (creates "User Story" work items)
> - **Scrum** process (creates "Product Backlog Item" work items)  
> - **Basic** process (creates "Issue" work items)
> - **CMMI** process (creates "Requirement" work items)

## 🏁 Getting Started (5 Minutes!)

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

> **💡 Why just one pipeline?** The facilitator handles everything: initialization, progress detection, and work item creation. No need for multiple pipelines anymore!

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
2. Find **"Step 1: Setup Azure AI Resources"** work item
3. Read the instructions carefully
4. Complete the step
5. **Commit and push your changes**
6. **Facilitator automatically triggers** and creates Step 2!
7. Repeat for all 7 steps

## 📚 Repository Structure

```
foundrycicdbasic/
├── cicd/                              # ⭐ Production pipelines
│   ├── README.md                      # Pipeline documentation
│   ├── createagentpipeline.yml        # AI agent deployment pipeline
│   └── agentconsumptionpipeline.yml   # Agent evaluation pipeline
├── ado-hackathon/
│   ├── README.md                      # This file
│   ├── QUICKSTART.md                  # Quick start guide (recommended!)
│   ├── pipelines/
│   │   └── hackathon-facilitator.yml  # ⭐ The ONE pipeline you need
│   └── work-items/                    # Instructions for each step
│       ├── step-1-azure-resources.md
│       ├── step-2-azure-devops.md
│       ├── step-3-create-agent-pipeline.md
│       ├── step-4-deploy-agents.md
│       ├── step-5-create-testing-pipeline.md
│       ├── step-6-run-evaluation.md
│       └── step-7-security-redteam.md
├── agenteval.py                       # Agent evaluation script
├── redteam.py                         # Security red team testing
├── createagent.py                     # Agent creation helper
└── requirements.txt                   # Python dependencies
```

## 🎓 Step-by-Step Journey

### Step 1: Setup Azure AI Resources 🔧

**Goal:** Create Azure AI infrastructure for agent deployment

**What you'll do:**
- Create 3 resource groups (dev, test, prod)
- Set up Azure AI Projects in each environment
- Create Azure OpenAI resources
- Note endpoint URLs for later use

**Completion:** Azure AI resources created and documented

---

### Step 2: Configure Azure DevOps ⚙️

**Goal:** Set up Azure DevOps for AI agent deployment

**What you'll do:**
- Create service connections to Azure
- Set up variable groups with AI project endpoints
- Configure pipeline permissions
- Store OpenAI connection strings

**Completion:** Azure DevOps configured with service connections

---

### Step 3: Create Agent Deployment Pipeline 🤖

**Goal:** Set up pipeline to deploy AI agents

**What you'll do:**
- Reference `/cicd/createagentpipeline.yml`
- Understand agent deployment workflow
- Configure pipeline variables
- Learn about agent creation process

**Key Pipeline:** `/cicd/createagentpipeline.yml`
- Deploys AI agents to Azure AI Foundry
- Handles multi-environment deployment
- Creates agents in dev, test, and prod

**Completion:** Agent deployment pipeline configured

---

### Step 4: Deploy AI Agents to Environments 🚀

**Goal:** Deploy agents across all environments

**What you'll do:**
- Run agent deployment pipeline
- Deploy to dev environment
- Promote to test environment
- Deploy to production environment
- Verify agents in Azure AI Foundry

**Completion:** Agents deployed to all 3 environments

---

### Step 5: Create Agent Testing Pipeline 🧪

**Goal:** Set up evaluation pipeline for testing agents

**What you'll do:**
- Reference `/cicd/agentconsumptionpipeline.yml`
- Understand agent evaluation workflow
- Configure evaluation parameters
- Set up quality metrics

**Key Pipeline:** `/cicd/agentconsumptionpipeline.yml`
- Tests deployed AI agents
- Runs agent evaluation
- Executes red team security tests
- Publishes test results as artifacts

**Completion:** Evaluation pipeline configured

---

### Step 6: Run Agent Evaluation 📊

**Goal:** Evaluate agent performance and quality

**What you'll do:**
- Run agent evaluation pipeline
- Review evaluation metrics
- Analyze agent responses
- Check quality scores
- Download evaluation artifacts

**Metrics evaluated:**
- Response quality
- Accuracy
- Latency
- Token usage
- User satisfaction simulation

**Completion:** Evaluation completed with metrics reviewed

---

### Step 7: Review Security Red Team Results 🔒

**Goal:** Assess AI agent security vulnerabilities

**What you'll do:**
- Download red team results artifact
- Review security test findings
- Understand vulnerability types
- Learn mitigation strategies
- Document security posture

**Security tests:**
- Prompt injection attempts
- Jailbreak attempts
- Data leakage tests
- Harmful content generation
- Context manipulation

**Completion:** Security assessment reviewed and documented

---

## 🔄 How the Facilitator Works

### First Run (Initialization)

```
User runs facilitator pipeline (manual)
  ↓
Facilitator checks: Is Epic created?
  ↓ No
Creates Epic: "🚀 Azure DevOps AI Agent Deployment Hackathon"
  ↓
Creates Step 1 work item with instructions
  ↓
User starts working on Step 1
```

### Subsequent Runs (Automatic Progression)

```
User completes Step 1 (creates Azure AI resources)
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
- Complete Step 1 fully: Create all Azure AI Projects
- Complete Step 2 fully: Set up service connections and variables
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
- Ensure agents are deployed first (Step 4)
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

When you complete all 7 steps:
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

- **[QUICKSTART.md](QUICKSTART.md)** - Quick start guide (recommended for beginners)
- **[Work Item Files](work-items/)** - Detailed instructions for each step
- **[/cicd Pipelines](../cicd/)** - Production-ready pipeline templates

## 🤝 Contributing

Found an issue or have a suggestion? Please open an issue or submit a pull request!

## 📄 License

This project is licensed under the MIT License.

---

**Ready to start?** Head to the **[Quick Start Guide](./QUICKSTART.md)** and begin your AI agent deployment journey! 🚀
