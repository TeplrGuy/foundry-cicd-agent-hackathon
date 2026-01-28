# 🤖 Azure DevOps CI/CD Hackathon: AI Agent Deployment

Welcome to the **Azure DevOps CI/CD Hackathon**! In this hands-on workshop, you'll learn how to build production-grade CI/CD pipelines to deploy, test, and secure AI agents using Azure DevOps and Azure AI Foundry.

## 🎯 What You'll Learn

By the end of this hackathon, you will have:

1. **Built Azure Infrastructure** - Deploy Azure AI Foundry resources using Terraform
2. **Mastered Azure DevOps Pipelines** - Create multi-stage YAML pipelines from scratch
3. **Deployed AI Agents** - Deploy agents across Dev → Test → Production environments
4. **Implemented Testing Pipelines** - Build evaluation and security testing pipelines
5. **Practiced DevSecOps** - Run red team security assessments on AI agents

## 🚀 Getting Started

### Prerequisites

Before starting, ensure you have:

- [ ] **Azure Subscription** with permissions to create resources
- [ ] **Azure DevOps Organization** and Project
- [ ] **Terraform** installed ([Download](https://www.terraform.io/downloads))
- [ ] **Azure CLI** installed and authenticated ([Download](https://docs.microsoft.com/cli/azure/install-azure-cli))
- [ ] **Python 3.11+** installed
- [ ] **Git** installed

### Quick Start

1. **Fork/Import this repository** to your Azure DevOps project
2. **Run Terraform** to create Azure AI infrastructure
3. **Create the hackathon facilitator pipeline** 
4. **Follow the work items** created automatically in Azure Boards

## 📁 Repository Structure

```
foundry-cicd-agent-hackathon/
├── ado-hackathon/              # 🎓 Hackathon materials
│   ├── README.md               # Hackathon overview
│   ├── QUICKSTART.md           # Quick start guide
│   ├── pipelines/              # Facilitator pipeline
│   │   └── hackathon-facilitator.yml
│   └── work-items/             # Step-by-step instructions
│       ├── step-1-azure-resources.md
│       ├── step-2-azure-devops.md
│       ├── step-3-create-agent-pipeline.md    # 🔨 You build this!
│       ├── step-4-deploy-agents.md
│       ├── step-5-create-testing-pipeline.md  # 🔨 You build this!
│       ├── step-6-run-evaluation.md
│       └── step-7-security-redteam.md
├── cicd/                       # 🔨 YOU CREATE THIS FOLDER!
│   └── (your pipeline YAML files go here)
├── terraform/                  # Infrastructure as Code
│   ├── main.tf                 # Azure AI Foundry resources
│   ├── variables.tf
│   └── outputs.tf
├── docs/                       # Additional documentation
├── createagent.py              # Agent creation script
├── exagent.py                  # Agent testing script
├── agenteval.py                # Agent evaluation script
├── redteam.py                  # Security testing script
├── requirements.txt            # Python dependencies
└── sample.env                  # Environment variables template
```

## 🏆 The Challenge

This hackathon is designed to teach you **how to build pipelines**, not just copy them!

### Steps 3 & 5: Build Your Own Pipelines! 🔨

In **Step 3** and **Step 5**, you'll create Azure DevOps pipelines from scratch:

- ✅ Read the requirements in the work items
- ✅ Use Microsoft Learn documentation to understand YAML syntax
- ✅ Build and test your pipelines iteratively
- ✅ Troubleshoot and fix errors yourself

**No pre-built pipeline YAML files are provided!** This is intentional - you'll learn more by building them yourself.

### Resources for Building Pipelines

| Topic | Documentation |
|-------|---------------|
| Azure Pipelines YAML | [YAML Schema Reference](https://learn.microsoft.com/azure/devops/pipelines/yaml-schema/) |
| Multi-Stage Pipelines | [Stages, Jobs, and Steps](https://learn.microsoft.com/azure/devops/pipelines/process/stages) |
| Deployment Jobs | [Deployment Jobs](https://learn.microsoft.com/azure/devops/pipelines/process/deployment-jobs) |
| Variable Groups | [Variable Groups](https://learn.microsoft.com/azure/devops/pipelines/library/variable-groups) |
| Environments & Approvals | [Environments](https://learn.microsoft.com/azure/devops/pipelines/process/environments) |
| Conditions | [Conditions](https://learn.microsoft.com/azure/devops/pipelines/process/conditions) |

## 📋 Hackathon Steps Overview

| Step | Goal | What You Build |
|------|------|----------------|
| 1 | Setup Azure AI Resources | Run Terraform to create infrastructure |
| 2 | Configure Azure DevOps | Create service connections & variable groups |
| **3** | **Build Deployment Pipeline** | 🔨 Create `createagentpipeline.yml` |
| 4 | Deploy Agents | Run your pipeline, verify deployments |
| **5** | **Build Testing Pipeline** | 🔨 Create `agentconsumptionpipeline.yml` |
| 6 | Run Evaluation | Execute tests, review metrics |
| 7 | Security Analysis | Review red team results |

## 🎮 How the Hackathon Works

1. **Create the Facilitator Pipeline** from `ado-hackathon/pipelines/hackathon-facilitator.yml`
2. **Run it once** to initialize the hackathon (creates Step 1 work item)
3. **Complete each step** following the work item instructions
4. **Commit and push** your completion markers (e.g., `azure-resources.md`)
5. **Pipeline auto-advances** you to the next step!

The facilitator pipeline monitors your progress and creates new work items as you complete each step.

## 🔧 Infrastructure Setup (Step 1)

```bash
# Navigate to terraform folder
cd terraform

# Initialize and deploy
terraform init
terraform plan
terraform apply

# Note the outputs for Step 2!
```

This creates:
- 3 Resource Groups (dev, test, prod)
- 3 Azure AI Foundry accounts
- 3 AI Projects with GPT-4o deployed
- Service Principals with proper permissions

## 💡 Tips for Success

### Do's ✅
- **Read the documentation** - The answers are in Microsoft Learn
- **Iterate quickly** - Make small changes, test, repeat
- **Read error messages** - They tell you what's wrong!
- **Use the Azure DevOps YAML editor** - It has IntelliSense
- **Ask teammates** - Collaboration is encouraged!

### Don'ts ❌
- Don't look for pre-built YAML files (there aren't any!)
- Don't skip steps - each builds on the previous
- Don't ignore validation errors - fix them!

## 🆘 Getting Help

### Common Issues

| Problem | Solution |
|---------|----------|
| Pipeline won't trigger | Check trigger paths and branch name |
| Variable group not found | Verify exact naming (case-sensitive) |
| Service connection fails | Check credentials and permissions |
| Agent deployment fails | Verify endpoint URLs and role assignments |

### Debugging Steps

1. Click on the failed step in Azure DevOps
2. Read the full error message (expand the logs)
3. Check if it's a configuration issue (variables, connections)
4. Verify Azure resources exist and are accessible
5. Google the specific error message!

## 📚 Additional Resources

- [Azure AI Foundry Documentation](https://learn.microsoft.com/azure/ai-studio/)
- [Azure DevOps Pipelines](https://learn.microsoft.com/azure/devops/pipelines/)
- [Azure AI Evaluation SDK](https://learn.microsoft.com/azure/ai-studio/how-to/develop/evaluate-sdk)
- [AI Red Team Testing](https://learn.microsoft.com/azure/ai-services/openai/concepts/red-teaming)

## 🎉 Completion

When you finish all 7 steps, you'll have:

- ✅ A complete CI/CD pipeline for AI agent deployment
- ✅ Multi-environment deployment (Dev → Test → Prod)
- ✅ Automated testing and quality evaluation
- ✅ Security vulnerability assessment
- ✅ Production-ready DevOps skills!

---

**Ready to start?** Head to `ado-hackathon/QUICKSTART.md` for the 5-minute setup guide! 🚀

## 📄 License

This project is for educational purposes as part of the Azure DevOps CI/CD Hackathon.
