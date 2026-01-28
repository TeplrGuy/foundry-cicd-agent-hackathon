# Azure DevOps AI Agent Deployment Hackathon - Quick Start

## 🎯 Overview

This hackathon teaches you how to deploy and test AI agents using Azure DevOps CI/CD pipelines. Through 7 progressive steps, you'll build a complete deployment pipeline for AI agents with evaluation and security testing.

**SIMPLE APPROACH:** Create ONE facilitator pipeline that guides you through the entire journey! 🎉

## 📊 How It Works

```
┌─────────────────────────────────────────────────────────┐
│  Setup: Create Facilitator Pipeline (ONE TIME)          │
│  └─→ User creates hackathon-facilitator.yml pipeline    │
│  └─→ Runs it once (manual)                              │
│  └─→ Creates Epic + Step 1 work item                    │
└────────────┬────────────────────────────────────────────┘
             │
             ▼
┌─────────────────────────────────────────────────────────┐
│  Step 1: Setup Azure AI Resources                       │
│  └─→ User creates Azure AI Projects & OpenAI resources  │
│  └─→ Stores connection info in Azure DevOps            │
│  └─→ Commits and pushes to main                         │
└────────────┬────────────────────────────────────────────┘
             │
             ▼
┌─────────────────────────────────────────────────────────┐
│  Step 2-7: Progressive AI Agent Deployment              │
│  └─→ Configure Azure DevOps project                     │
│  └─→ Create agent deployment pipeline                   │
│  └─→ Deploy agents to environments                      │
│  └─→ Set up evaluation pipeline                         │
│  └─→ Run agent evaluations                              │
│  └─→ Review security red team results                   │
└────────────┬────────────────────────────────────────────┘
             │
             ▼
┌─────────────────────────────────────────────────────────┐
│  Completion: Hackathon Finished! 🎉                     │
│  └─→ All 7 steps completed                              │
│  └─→ AI agents deployed and tested                      │
│  └─→ Security vulnerabilities reviewed                  │
└─────────────────────────────────────────────────────────┘
```

## 🚀 Get Started in 3 Steps (5 minutes!)

### 1. Import Repository to Azure DevOps

```bash
# In Azure DevOps:
# 1. Go to Repos → Files
# 2. Click "Import repository"
# 3. Enter: https://github.com/TeplrGuy/foundry-cicd-agent-hackathon
# 4. Click "Import"
```

⏱️ **Time:** 2 minutes

---

### 2. Create the Facilitator Pipeline (ONE Pipeline Only!)

🎯 **SIMPLIFIED:** You only need to create **ONE** pipeline - the hackathon facilitator!

This single pipeline:
- ✅ Initializes the hackathon on first run
- ✅ Monitors your progress automatically  
- ✅ Creates work items as you complete steps
- ✅ Guides you through all 7 AI agent deployment steps

**How to create it:**

1. Go to **Pipelines** → **Pipelines**
2. Click **New pipeline**
3. Select **Azure Repos Git**
4. Select your repository
5. Choose **Existing Azure Pipelines YAML file**
6. Path: `/ado-hackathon/pipelines/hackathon-facilitator.yml`
7. Click **Save**

⏱️ **Time:** 2 minutes

---

### 3. Run the Facilitator Pipeline

Run it once to initialize the hackathon:

1. Go to **Pipelines** → **Pipelines**
2. Find **hackathon-facilitator** pipeline
3. Click **Run pipeline**
4. Click **Run**

The pipeline will:
- ✅ Create an Epic work item: "🚀 Azure DevOps AI Agent Deployment Hackathon"
- ✅ Create Step 1 work item: "Step 1: Setup Azure AI Resources"
- ✅ Display next steps in the logs

⏱️ **Time:** 1 minute

---

## 🎮 You're Ready! Start the Hackathon

### Follow the Work Items

1. Go to **Boards** → **Work Items**
2. Find **"Step 1: Setup Azure AI Resources"** work item
3. Read the instructions carefully
4. Complete the step (create Azure AI Projects and OpenAI resources)
5. **Push your changes:**
   ```bash
   git add .
   git commit -m "Complete Step 1: Setup Azure AI resources"
   git push origin main
   ```
6. **Watch the magic happen:**
   - Facilitator pipeline triggers automatically
   - Detects step completion
   - Closes Step 1 work item
   - Creates Step 2 work item
7. **Repeat for all 7 steps!**

### What You'll Build

Through the 7 steps, you'll:

1. **Azure AI Resources** - Set up Azure AI Projects and OpenAI resources
2. **Azure DevOps Config** - Configure service connections and variables
3. **Agent Pipeline** - Create your own deployment pipeline YAML
4. **Deploy Agents** - Deploy AI agents to dev, test, and prod environments
5. **Testing Pipeline** - Create your own evaluation pipeline YAML
6. **Run Evaluation** - Evaluate agent performance and quality
7. **Security Review** - Review red team security testing results

### Key Python Scripts

The hackathon uses these Python scripts that your pipelines will execute:

- **`createagent.py`** - Creates AI agents in Azure AI Foundry
- **`exagent.py`** - Tests existing deployed agents
- **`agenteval.py`** - Runs quality evaluation on agents
- **`redteam.py`** - Performs security red team testing

You'll create the pipeline YAML files yourself to orchestrate these scripts!

---

## ❓ Troubleshooting

### Nothing happens after I complete a step

**Most Common Issue:** Pipeline didn't trigger after your push

**Solutions:**

1. **Check if pipeline ran:**
   - Go to **Pipelines** → **Pipelines**
   - Find **hackathon-facilitator** pipeline
   - Check if it ran after your push
   - Look at the run logs for any errors

2. **Manually trigger the pipeline:**
   - Go to **Pipelines** → **Pipelines**
   - Find **hackathon-facilitator** pipeline
   - Click **Run pipeline**
   - It will detect your progress and create next work item

3. **Verify you pushed to the main branch:**
   ```bash
   git status  # Should show "Your branch is up to date with 'origin/main'"
   git log --oneline -1  # Should show your latest commit
   git remote -v  # Should show your Azure Repos URL
   ```

4. **Check pipeline logs:**
   - Open the pipeline run
   - Look for messages indicating step detection
   - If you see errors, they'll explain what's wrong

### Pipeline fails with "No suitable work item type found"

**Issue:** The facilitator pipeline tries multiple work item types but all fail.

**Solutions:**
1. Check you have permission to create work items in the project
2. Verify your project has at least one of these work item types enabled
3. Go to **Project Settings** → **Boards** → **Process** to check

### How do I know which step I'm on?

**Option 1:** Check Boards
- Go to **Boards** → **Work Items**
- Look for **open** work items (not Closed)
- The open work item shows your current step

**Option 2:** Check pipeline logs
- Run the facilitator pipeline
- It will show your current step status

### The facilitator pipeline isn't triggering automatically

**Check:**
1. **Trigger is enabled:**
   - Go to the pipeline
   - Click **Edit**
   - Check that `trigger:` section includes your branch

2. **You're pushing to the main branch:**
   ```bash
   git branch  # Should show "* main"
   ```

3. **Pipeline isn't disabled:**
   - Go to **Pipelines** → **Pipelines**
   - Facilitator pipeline should not show "Disabled"

### Azure AI resources not configured

**Issue:** Pipelines fail because Azure AI endpoints aren't set up

**Solution:**
- Complete Step 1 fully: Create all Azure AI Projects and OpenAI resources
- Complete Step 2 fully: Set up service connections and pipeline variables
- Check that variable groups and service connections exist in Azure DevOps

---

## 📚 What's Next?

After setup, your hackathon flow is:

1. ✅ Facilitator pipeline created and run once (initialization)
2. ✅ Step 1 work item created
3. 🎯 **Work on Step 1** - Set up Azure AI resources
4. 🔄 **Push changes** - Facilitator auto-triggers
5. 🎉 **Step 2 created** - Facilitator detects completion
6. 🔁 **Repeat for Steps 2-7** - Deploy and test AI agents
7. 🏆 **Celebrate!** - You've mastered AI agent deployment!

---

## 📖 Additional Resources

- **[README.md](README.md)** - Comprehensive documentation
- **[Work Items](work-items/)** - Detailed instructions for each step
- **[/cicd Pipelines](../cicd/)** - Production-ready pipeline templates

---

## 🎉 Ready to Start?

1. Import repository (2 min)
2. Create facilitator pipeline (2 min)
3. Run it once (1 min)
4. Start deploying AI agents! (rest of hackathon)

**Total setup time: ~5 minutes**

**Happy hacking!** 🚀

---

## 🆘 Need Help?

- Check work item instructions carefully
- Review pipeline logs for detailed status
- Verify facilitator pipeline is created and enabled
- Manually trigger the pipeline if automatic trigger doesn't work
- Check [README.md](README.md) for comprehensive documentation

Remember: The facilitator pipeline is your friend! It monitors your progress and automatically creates the next step. Just focus on learning AI agent deployment! 💪
