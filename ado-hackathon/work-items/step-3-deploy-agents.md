# Step 3: Run Your Pipeline & Deploy Agents 🚀

## 🎯 Your Mission

Execute the pipeline you created in Step 2 and successfully deploy AI agents to all three environments. Monitor the execution, troubleshoot any failures, and verify your agents are running in Azure AI Foundry.

## 📋 Pre-Flight Checklist

Before running your pipeline, verify everything is in place:

### Azure DevOps Setup
- [ ] Pipeline exists and points to your YAML file
- [ ] Variable groups created: `agent-dev-vars`, `agent-test-vars`, `agent-prod-vars`
- [ ] Service connections configured for Azure authentication
- [ ] Environments created: `dev`, `test`, `production`

### Variable Group Contents
Each variable group should contain (research what values these need):
- [ ] `AZURE_AI_PROJECT_ENDPOINT` - Where do you find this?
- [ ] `AZURE_AI_MODEL_DEPLOYMENT_NAME` - What should this be?

**Hint:** Check Azure AI Foundry portal for endpoint URLs.

### Environment Approvals
- [ ] (Optional) Configure approval on `test` environment
- [ ] (Recommended) Configure approval on `production` environment

**Research:** How do you add approvals to environments in Azure DevOps?

## 🔨 Execute Your Pipeline

### Step 1: Trigger the Pipeline

1. Go to **Pipelines** → Select your pipeline
2. Click **Run pipeline**
3. Select branch: `main`
4. Click **Run**

### Step 2: Monitor Build Stage

Watch the first stage carefully. Ask yourself:
- What's happening at each step?
- How long does dependency installation take?
- What artifacts are being published?

**If it fails:** Read the error message! Don't just re-run blindly.

### Step 3: Monitor Deployment Stages

For each deployment stage (Dev → Test → Prod):

1. **Observe the logs** - What commands are executing?
2. **Check for approvals** - Is the pipeline waiting for you?
3. **Verify in Azure** - Can you see the agent being created?

## 🔍 Verification Tasks

### After Dev Deployment

Go to Azure AI Foundry and verify:
- [ ] Agent exists in the Dev project
- [ ] Agent has the expected name
- [ ] Agent uses the correct model (gpt-4o)

**Document the Agent ID - you'll need it later!**

### After Test Deployment

Same verification:
- [ ] Agent exists in Test project
- [ ] Configuration matches Dev

### After Production Deployment

Final verification:
- [ ] Agent exists in Production project
- [ ] Test the agent in the playground!

## 🧪 Testing Your Deployed Agent

Once deployed, test your agent:

1. Go to [Azure AI Foundry](https://ai.azure.com/)
2. Navigate to your project
3. Click **Agents**
4. Select your agent
5. Click **Test in Playground**
6. Ask: "What services do you offer?"

**Does it respond appropriately?** If not, what went wrong?

## 🆘 Troubleshooting Guide

When something fails, follow this process:

### 1. Read the Error (Really Read It!)

Common errors and what they mean:

| Error Pattern | Likely Cause |
|--------------|--------------|
| `Variable group not found` | Missing or misnamed variable group |
| `Service connection not found` | Missing Azure service connection |
| `Environment not found` | Environment doesn't exist in Project Settings |
| `Authentication failed` | Service principal permissions issue |
| `PermissionDenied` | Role assignments missing on Azure resources |
| `Resource not found` | Endpoint URL is incorrect |

### 2. Check Your Logs

- Click on the failed step
- Expand the logs
- Look for the **actual error message** (often near the bottom)

### 3. Verify Azure Resources

In Azure Portal:
- Does the AI Foundry resource exist?
- Is the model deployed?
- Does the service principal have the right roles?

### 4. Check Variable Values

In Azure DevOps Library:
- Are variable values correct?
- Are secret variables marked as secrets?
- Did you grant pipeline access to the variable group?

## 📝 Document Your Deployment

Create `agents-deployed.md` documenting:

```markdown
# Agent Deployment Results

## Pipeline Execution Summary
- Pipeline Name: [Your pipeline name]
- Run Number: #[X]
- Total Duration: [X minutes]
- Status: [Succeeded/Failed and fixed/Still failing]

## What I Learned

### Challenges Encountered
[Describe any issues you hit and how you solved them]

### Key Observations
[What did you notice about the pipeline execution?]

## Agent Verification

### Dev Environment
- Agent ID: [ID from Azure]
- Tested: [Yes/No]
- Working: [Yes/No]

### Test Environment  
- Agent ID: [ID]
- Tested: [Yes/No]
- Working: [Yes/No]

### Production Environment
- Agent ID: [ID]
- Tested: [Yes/No]
- Working: [Yes/No]

## Improvements I Would Make
[After running the pipeline, what would you change?]
```

## ✅ Completion Criteria

You've completed this step when:

1. ✅ Pipeline ran successfully (all stages green)
2. ✅ Agents verified in Azure AI Foundry for all 3 environments
3. ✅ At least one agent tested in playground
4. ✅ `agents-deployed.md` documents your experience
5. ✅ Committed and pushed

```bash
git add agents-deployed.md
git commit -m "Step 3: Deployed agents to all environments"
git push origin main
```

## 🏆 Bonus Challenges

- **Challenge A**: Set up email notifications when pipeline completes
- **Challenge B**: Add a manual validation step between Test and Prod
- **Challenge C**: Create a dashboard showing deployment history
- **Challenge D**: Implement a rollback mechanism

## 💡 Reflection Questions

After completing this step, think about:

1. How would you handle a failed production deployment?
2. What metrics would you track for your deployments?
3. How would you implement blue-green deployments for agents?
4. What security considerations should you add?

---

**Pro Tip:** Pipeline failures are learning opportunities! Each error teaches you something about how Azure DevOps and Azure AI Foundry work together. 🎯
