# Step 2: Build Your First Agent Deployment Pipeline 🎓

## 🎯 Your Mission

Create an Azure DevOps pipeline that deploys AI agents across multiple environments (Dev → Test → Production). You'll need to design the pipeline YAML yourself using Azure DevOps documentation.

**This is a hackathon - we won't give you the YAML!** You'll learn more by building it yourself.

## 📚 What You Need to Learn

Before you start coding your pipeline, research these concepts:

### Core Concepts to Research

1. **Multi-Stage Pipelines** - How do you structure a pipeline with Build → Dev → Test → Prod stages?
2. **Triggers** - How do you make a pipeline run when specific files change?
3. **Artifacts** - How do you pass build outputs to deployment stages?
4. **Deployment Jobs** - What's special about `deployment:` vs regular `job:`?
5. **Variable Groups** - How do you use Library variable groups in YAML?
6. **Environment Approvals** - How do you require approval before production?

### 📖 Required Reading (Do This First!)

Study these Azure DevOps documentation pages:

| Topic | Documentation Link |
|-------|-------------------|
| Pipeline YAML Structure | [Azure Pipelines YAML Schema](https://learn.microsoft.com/azure/devops/pipelines/yaml-schema/) |
| Multi-Stage Pipelines | [Stages in Pipelines](https://learn.microsoft.com/azure/devops/pipelines/process/stages) |
| Deployment Jobs | [Deployment Jobs](https://learn.microsoft.com/azure/devops/pipelines/process/deployment-jobs) |
| Variable Groups | [Variable Groups](https://learn.microsoft.com/azure/devops/pipelines/library/variable-groups) |
| Environments & Approvals | [Environments](https://learn.microsoft.com/azure/devops/pipelines/process/environments) |
| Python Tasks | [Python Build Tasks](https://learn.microsoft.com/azure/devops/pipelines/ecosystems/python) |

## 🏗️ Pipeline Requirements

Your pipeline must meet these requirements:

### Triggers
- [ ] Only trigger on `main` branch
- [ ] Only trigger when relevant Python files or pipeline files change

### Stages (4 Required)

**Stage 1: Build**
- [ ] Use Python 3.11
- [ ] Install dependencies from `requirements.txt`
- [ ] Validate Python syntax using `py_compile`
- [ ] Publish source code as a pipeline artifact

**Stage 2: Deploy to Dev**
- [ ] Depends on Build stage success
- [ ] Use a deployment job targeting `dev` environment
- [ ] Reference variable group for dev configuration
- [ ] Execute Python script to create the agent

**Stage 3: Deploy to Test**
- [ ] Depends on Dev stage success
- [ ] Use a deployment job targeting `test` environment
- [ ] Reference variable group for test configuration

**Stage 4: Deploy to Production**
- [ ] Depends on Test stage success
- [ ] Use a deployment job targeting `production` environment
- [ ] Should require manual approval (configure this in Environments)

### Integration with Azure
- [ ] Use `AzureCLI@2` task to authenticate and run Python scripts
- [ ] Pass environment variables for AI Foundry endpoint and model deployment

## 🧩 Hints (Use Sparingly!)

<details>
<summary>💡 Hint 1: Basic Pipeline Structure</summary>

```yaml
trigger:
  branches:
    include:
      - ???
  paths:
    include:
      - ???

stages:
  - stage: ???
    jobs:
      - job: ???
        steps:
          - ???
```
</details>

<details>
<summary>💡 Hint 2: Deployment Job Syntax</summary>

Deployment jobs use a different syntax than regular jobs:

```yaml
- stage: DeployDev
  jobs:
    - deployment: ???
      environment: ???
      strategy:
        runOnce:
          deploy:
            steps:
              - ???
```
</details>

<details>
<summary>💡 Hint 3: Using Variable Groups</summary>

```yaml
stages:
  - stage: Deploy
    variables:
      - group: '???-vars'
    jobs:
      # Your jobs here
```
</details>

<details>
<summary>💡 Hint 4: Publishing Artifacts</summary>

Look up `PublishPipelineArtifact@1` task and `DownloadPipelineArtifact@2` task.
</details>

## 📝 Your Task

### Step 1: Create Your Pipeline YAML

1. Create a new file in the `cicd/` folder (name it appropriately)
2. Write your pipeline YAML from scratch based on the requirements above
3. Test your YAML syntax using the Azure DevOps pipeline editor

### Step 2: Register the Pipeline in Azure DevOps

1. Go to **Pipelines** → **New Pipeline**
2. Select **Azure Repos Git** → Your repository
3. Choose **Existing Azure Pipelines YAML file**
4. Select YOUR YAML file
5. **Save** (don't run yet - verify your variable groups exist first!)

### Step 3: Verify Prerequisites

Before running:
- [ ] Variable groups exist for each environment
- [ ] Service connections are configured
- [ ] Environments (dev, test, production) are created

### Step 4: Document What You Built

Create `pipeline-1-created.md` explaining:
- What stages did you create and why?
- What triggers did you configure?
- How does artifact passing work between stages?
- What deployment strategy did you use?

## ✅ Completion Criteria

You've completed this step when:

1. ✅ Your pipeline YAML file exists in the `cicd/` folder
2. ✅ Pipeline is registered in Azure DevOps
3. ✅ `pipeline-1-created.md` documents your design decisions
4. ✅ Commit and push to trigger the facilitator

```bash
git add cicd/your-pipeline.yml pipeline-1-created.md
git commit -m "Step 2: Created agent deployment pipeline"
git push origin main
```

## 🏆 Bonus Challenges

Already done? Try these advanced enhancements:

- **Challenge A**: Add a code quality check using `pylint` or `flake8`
- **Challenge B**: Make Dev and Test stages run in parallel (both depend on Build)
- **Challenge C**: Add a rollback stage that runs on failure
- **Challenge D**: Add Microsoft Teams notifications on deployment

## 🆘 Stuck?

1. **Re-read the documentation** - The answers are there!
2. **Use the Azure DevOps YAML editor** - It has IntelliSense and validation
3. **Check the pipeline run logs** - Error messages tell you what's wrong
4. **Ask your teammates** - It's a hackathon, collaboration is encouraged!

## 📚 Additional Resources

- [YAML Schema Reference](https://learn.microsoft.com/azure/devops/pipelines/yaml-schema/)
- [Predefined Variables](https://learn.microsoft.com/azure/devops/pipelines/build/variables)
- [Expressions and Conditions](https://learn.microsoft.com/azure/devops/pipelines/process/expressions)
- [Task Reference](https://learn.microsoft.com/azure/devops/pipelines/tasks/reference/)

---

**Remember:** The best way to learn pipelines is to build them yourself. Resist the urge to look for complete examples - you'll learn much more by figuring it out! 🚀
