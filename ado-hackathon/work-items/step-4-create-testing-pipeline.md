# Step 4: Build Your Testing & Evaluation Pipeline 🧪

## 🎯 Your Mission

Create a second pipeline focused on **testing, evaluating, and security-assessing** your deployed AI agents. This pipeline is different from your deployment pipeline - it validates that agents work correctly and safely.

## 📚 What You Need to Learn

This step introduces new pipeline concepts. Research these before building:

### New Concepts for Testing Pipelines

1. **Parallel Jobs** - How do you run multiple jobs simultaneously in a stage?
2. **`continueOnError`** - How do you let a pipeline continue even if a step fails?
3. **Conditional Artifact Publishing** - How do you publish artifacts even on failure?
4. **Test Result Publishing** - How do you display test results in Azure DevOps?

### 📖 Required Reading

| Topic | Documentation Link |
|-------|-------------------|
| Parallel Jobs | [Jobs in Stages](https://learn.microsoft.com/azure/devops/pipelines/process/phases) |
| Conditions | [Conditions and Expressions](https://learn.microsoft.com/azure/devops/pipelines/process/conditions) |
| Publish Test Results | [Publish Test Results Task](https://learn.microsoft.com/azure/devops/pipelines/tasks/test/publish-test-results) |
| Pipeline Artifacts | [Pipeline Artifacts](https://learn.microsoft.com/azure/devops/pipelines/artifacts/pipeline-artifacts) |

## 🏗️ Pipeline Requirements

Your testing pipeline must include:

### Triggers
- [ ] Trigger when test-related Python files change
- [ ] Trigger when pipeline files change

### Stage 1: Build & Validate
- [ ] Validate syntax of ALL Python scripts (not just one!)
- [ ] Install dependencies
- [ ] Publish artifacts for use in later stages

### Stage 2: Dev Testing
- [ ] Test the agent in the dev environment
- [ ] Use `continueOnError: true` so failures don't block the pipeline
- [ ] Why would you want tests to not block? Think about it!

### Stage 3: Test Environment (The Critical Stage!)

This stage should run **two jobs in parallel**:

**Job A: Agent Evaluation**
- Run quality evaluation against your agent
- Measure metrics like groundedness, relevance, coherence
- Research: What is the Azure AI Evaluation SDK?

**Job B: Security Testing (Red Team)**
- Run security tests against your agent
- Test for prompt injection, jailbreaking attempts
- Publish security results as a downloadable artifact
- Research: What is AI Red Teaming?

### Stage 4: Production Verification
- [ ] Basic smoke tests on production agent
- [ ] Verify production is healthy

## 🧩 Hints (Use Sparingly!)

<details>
<summary>💡 Hint 1: Running Jobs in Parallel</summary>

Jobs in the same stage run in parallel by default:

```yaml
- stage: Test
  jobs:
    - job: JobA
      steps:
        - ???
    
    - job: JobB
      # JobB runs AT THE SAME TIME as JobA!
      steps:
        - ???
```
</details>

<details>
<summary>💡 Hint 2: Continue on Error</summary>

```yaml
- script: |
    python some_test.py
  displayName: 'Run Tests'
  continueOnError: true
```

This lets the pipeline continue even if tests fail - useful for gathering all test results!
</details>

<details>
<summary>💡 Hint 3: Publish Artifacts on Failure</summary>

```yaml
- task: PublishPipelineArtifact@1
  inputs:
    targetPath: '$(System.DefaultWorkingDirectory)/results.json'
    artifact: 'test-results'
  condition: succeededOrFailed()
```

`condition: succeededOrFailed()` means "run this even if previous steps failed"
</details>

<details>
<summary>💡 Hint 4: What Scripts Exist?</summary>

Look in the repository root. There are Python scripts for:
- Creating agents
- Testing existing agents
- Running evaluations
- Running security (red team) tests

Read their code to understand what environment variables they need!
</details>

## 🤔 Think About It

Before building, answer these questions:

1. **Why run evaluation and security tests in parallel?**
   - Hint: Think about time and efficiency

2. **Why use `continueOnError: true` for tests?**
   - Hint: What happens if one test fails but others might provide useful info?

3. **Why publish test artifacts even on failure?**
   - Hint: How do you debug a failed test if you can't see the results?

4. **What's the difference between this pipeline and the deployment pipeline?**
   - Hint: One creates things, one validates things

## 📝 Your Task

### Step 1: Study the Test Scripts

Before writing your pipeline, understand what scripts exist:
- Look at the Python files in the repository root
- Read their code to understand:
  - What environment variables do they need?
  - What do they output?
  - What files do they create?

### Step 2: Create Your Pipeline YAML

1. Create a new YAML file in the `cicd/` folder
2. Implement all the requirements above
3. Focus on the parallel jobs in the Test stage - this is the key learning!

### Step 3: Register and Test

1. Create the pipeline in Azure DevOps
2. Run it and watch the parallel execution
3. Debug any failures

### Step 4: Document Your Design

Create `pipeline-2-created.md` explaining:

```markdown
# Testing & Evaluation Pipeline

## Design Decisions

### Why I Structured It This Way
[Explain your stage structure and why]

### Parallel Jobs
[Explain why you run jobs in parallel]

### Error Handling
[Explain your use of continueOnError and conditions]

### Artifacts
[What artifacts does your pipeline publish and why?]

## What I Learned About Testing Pipelines
[Your key takeaways]
```

## ✅ Completion Criteria

You've completed this step when:

1. ✅ Testing pipeline YAML exists in `cicd/` folder
2. ✅ Pipeline is registered in Azure DevOps
3. ✅ Pipeline runs with parallel jobs in Test stage
4. ✅ Artifacts are published for test results
5. ✅ `pipeline-2-created.md` documents your design
6. ✅ Committed and pushed

```bash
git add cicd/your-testing-pipeline.yml pipeline-2-created.md
git commit -m "Step 4: Created testing and evaluation pipeline"
git push origin main
```

## 🏆 Bonus Challenges

- **Challenge A**: Add a quality gate that fails the pipeline if evaluation scores are too low
- **Challenge B**: Add performance/load testing as a third parallel job
- **Challenge C**: Create a visual test report using Azure DevOps test publishing
- **Challenge D**: Implement test result trending across runs

## 🔬 Deep Dive: AI Agent Testing

### What is Agent Evaluation?

AI Agent Evaluation measures quality:
- **Groundedness**: Are responses based on real information?
- **Relevance**: Do responses address the user's question?
- **Coherence**: Are responses logically structured?
- **Fluency**: Is the language natural?

Research the [Azure AI Evaluation SDK](https://learn.microsoft.com/azure/ai-studio/how-to/develop/evaluate-sdk) to learn more.

### What is Red Team Testing?

Red Team testing simulates attacks:
- **Prompt Injection**: Tricking the agent with malicious prompts
- **Jailbreaking**: Bypassing safety guidelines
- **Data Extraction**: Attempting to leak sensitive data
- **Harmful Content**: Testing for inappropriate responses

Research [AI Red Teaming](https://learn.microsoft.com/azure/ai-studio/concepts/evaluation-approach-gen-ai) to learn more.

## 📚 Resources

- [Azure AI Evaluation](https://learn.microsoft.com/azure/ai-studio/how-to/develop/evaluate-sdk)
- [AI Safety and Responsible AI](https://learn.microsoft.com/azure/ai-services/responsible-use-of-ai-overview)
- [Pipeline Conditions Reference](https://learn.microsoft.com/azure/devops/pipelines/process/conditions)
- [Parallel Jobs](https://learn.microsoft.com/azure/devops/pipelines/process/phases)

---

**Key Takeaway:** Testing pipelines require different patterns than deployment pipelines. The ability to continue on failure, run tests in parallel, and always capture results are essential skills for CI/CD! 🧪
