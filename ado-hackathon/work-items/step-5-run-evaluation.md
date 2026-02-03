# Step 5: Run AI Agent Evaluation 📊

Execute comprehensive evaluation and quality testing of your deployed AI agents!

## 🎯 Goal
Run the testing pipeline to evaluate agent quality, review AI evaluation metrics, and understand how to measure AI agent performance.

## 📋 What You'll Learn
- Running automated AI agent evaluation
- Interpreting evaluation metrics and scores
- Understanding quality benchmarks
- Using evaluation results to improve agents

## 🔨 Tasks

### 1. Prepare for Testing

Before running evaluation, ensure:

**Prerequisites:**
- [ ] Agents deployed in all environments (Step 3 complete)
- [ ] Testing pipeline created (Step 4 complete)
- [ ] Variable groups contain all required values
- [ ] Azure AI project endpoints are accessible

### 2. Run the Testing Pipeline

**Steps:**
1. Go to **Pipelines** in Azure DevOps
2. Select **Agent-Testing-Pipeline**
3. Click **Run pipeline**
4. Branch/tag: `main`
5. Click **Run**

The testing pipeline begins! 🧪

### 3. Monitor Build Stage

Watch the validation stage:

**Expected output:**
```
✓ Set Python Version
✓ Install Dependencies
✓ Validate Python Syntax
  - createagent.py ✓
  - exagent.py ✓
  - agenteval.py ✓
  - redteam.py ✓
✓ Publish Artifacts
```

**Duration:** ~2-3 minutes

### 4. Monitor Dev Stage Testing

Dev stage runs basic functionality tests:

**What's happening:**
```bash
Testing existing agent in DEV...
Connecting to agent...
Sending test query: "What investment options do you recommend?"
Response received: [agent response]
✓ Agent is responding correctly
```

**Expected results:**
- Agent responds to queries
- Responses are coherent
- No connection errors
- Note: May show "continueOnError" if agent not found (OK)

### 5. Monitor Test Stage (Main Evaluation)

This is where the comprehensive testing happens!

#### 5a. Agent Evaluation (`agenteval.py`)

**What's happening:**
```bash
Running agent evaluation in TEST...

Initializing Azure AI Evaluation SDK...
Loading test dataset...
Evaluating agent responses...

Evaluation Metrics:
```

**Expected output includes:**

```
===========================================
AI AGENT EVALUATION RESULTS
===========================================

Overall Quality Score: 4.2/5.0

Metric Breakdown:
- Groundedness:    4.5/5.0  ✓ Excellent
- Relevance:       4.3/5.0  ✓ Very Good
- Coherence:       4.1/5.0  ✓ Very Good
- Fluency:         4.0/5.0  ✓ Good

Test Scenarios Evaluated: 10
Pass Rate: 90%

Recommendations:
- Continue monitoring coherence
- Consider additional context for edge cases
```

**Understanding the scores:**

| Score Range | Rating | Meaning |
|------------|---------|----------|
| 4.5 - 5.0 | Excellent | Production-ready |
| 4.0 - 4.4 | Very Good | Minor improvements |
| 3.5 - 3.9 | Good | Needs optimization |
| 3.0 - 3.4 | Fair | Significant work needed |
| < 3.0 | Poor | Major revisions required |

### 6. Review Evaluation Metrics in Detail

Click on the **Agent Evaluation** task to see detailed output:

#### Groundedness Analysis
```
Question: "What's the current interest rate for savings?"
Context: "Our savings account offers 4.2% APY"
Agent Response: "We offer 4.2% APY on savings accounts"
Groundedness Score: 5.0
✓ Response perfectly grounded in provided context
```

#### Relevance Analysis
```
Question: "How do I open a retirement account?"
Agent Response: [detailed retirement account steps]
Relevance Score: 4.8
✓ Highly relevant and directly addresses question
```

#### Coherence Analysis
```
Response Structure:
- Clear introduction ✓
- Logical flow of information ✓
- Proper conclusion ✓
- No contradictions ✓
Coherence Score: 4.3
```

#### Fluency Analysis
```
Language Quality:
- Grammar: Excellent
- Vocabulary: Professional
- Tone: Appropriate
- Readability: Clear
Fluency Score: 4.5
```

### 7. Interpret Evaluation Results

Look for:

**Positive Indicators:**
- ✓ All metrics above 4.0
- ✓ Pass rate above 80%
- ✓ No critical failures
- ✓ Consistent scoring across metrics

**Warning Signs:**
- ⚠ Any metric below 3.5
- ⚠ Pass rate below 70%
- ⚠ Large variance in scores
- ⚠ Specific scenario failures

**Action Items:**
- Review failed test cases
- Identify patterns in low scores
- Update agent instructions if needed
- Add more context/training data

### 8. Monitor Production Verification

After Test stage completes, Prod stage verifies production agent:

**What's happening:**
```bash
Verifying production agent...
Agent status: Active ✓
Running basic health check...
✓ Agent responding normally
Production verification complete
```

### 9. Review Pipeline Summary

**Steps:**
1. Return to pipeline **Summary** tab
2. Review:
   - All stages completed
   - Test duration
   - Evaluation scores (in logs)
   - Any warnings or errors

## ✅ Completion Criteria

To complete this step and unlock Step 6:

1. Create `evaluation-complete.md` with your results:

```markdown
# AI Agent Evaluation - Completed

## Pipeline Run Details
- Run Number: #[number]
- Status: ✅ Succeeded
- Duration: [time]
- Date: [date]

## Evaluation Results

### Overall Quality Score: [X.X]/5.0

### Metric Scores
- **Groundedness**: [score]/5.0 - [rating]
- **Relevance**: [score]/5.0 - [rating]
- **Coherence**: [score]/5.0 - [rating]
- **Fluency**: [score]/5.0 - [rating]

### Test Results
- Total Scenarios: [number]
- Passed: [number]
- Failed: [number]
- Pass Rate: [percentage]%

## Stage Results

### Dev Stage
- Status: ✅ Completed
- Agent Test: ✅ Passing

### Test Stage
- Status: ✅ Completed
- Evaluation: ✅ Completed
- Red Team: ✅ Completed

### Prod Stage
- Status: ✅ Completed
- Verification: ✅ Passed

## Key Findings

### Strengths
- [List top 2-3 strengths based on scores]
- Example: Excellent groundedness (4.5/5.0)
- Example: Very good relevance (4.3/5.0)

### Areas for Improvement
- [List 1-2 areas if scores < 4.0]
- Example: Improve coherence in complex queries

## Recommendations
- [Based on evaluation, list 2-3 actionable recommendations]
- Example: Continue current approach
- Example: Add more examples for edge cases

## Next Steps
Ready to review security red team results!

Evaluated on: [date and time]
```

2. Commit and push:

```bash
git add evaluation-complete.md
git commit -m "Step 5: Completed AI agent evaluation"
git push origin main
```

## 🔍 Understanding AI Evaluation

### Why Evaluate AI Agents?

**Quality Assurance:**
- Ensures consistent performance
- Catches regressions early
- Validates improvements

**Objective Metrics:**
- Removes subjective assessment
- Provides quantifiable scores
- Enables comparison over time

**Continuous Improvement:**
- Identifies weak areas
- Guides optimization efforts
- Tracks progress

### Evaluation Best Practices

1. **Regular testing**: Run evaluation on every deployment
2. **Diverse scenarios**: Test various question types
3. **Real-world queries**: Use actual user questions
4. **Baseline comparison**: Track scores over time
5. **Threshold gates**: Set minimum acceptable scores

### Common Patterns

**High Groundedness, Low Coherence:**
- Agent has facts but poor structure
- Fix: Improve instruction prompts for better organization

**High Fluency, Low Relevance:**
- Agent writes well but off-topic
- Fix: Add stronger relevance requirements to prompts

**Inconsistent Scores:**
- Works well sometimes, not others
- Fix: Add more examples, improve context

## 📚 Resources

- [Azure AI Evaluation SDK Documentation](https://learn.microsoft.com/azure/ai-studio/how-to/develop/evaluate-sdk)
- [Understanding AI Quality Metrics](https://learn.microsoft.com/azure/ai-studio/concepts/evaluation-metrics-built-in)
- [Improving Agent Performance](https://learn.microsoft.com/azure/ai-services/agents/how-to/best-practices)

## 🆘 Need Help?

**Common Issues:**

- **Evaluation timeout**:
  - Increase pipeline timeout in YAML
  - Reduce number of test scenarios
  - Check agent response times

- **Low evaluation scores**:
  - Review agent instructions in `createagent.py`
  - Add more context/examples
  - Update model configuration

- **Evaluation SDK errors**:
  - Verify Azure AI project endpoint
  - Check service connection permissions
  - Ensure API version is current

- **No evaluation output**:
  - Check Python script logs
  - Verify evaluation SDK installed
  - Review variable group values

**Debugging Low Scores:**

If **Groundedness** is low:
- Provide more context documents
- Improve retrieval quality
- Add citation requirements

If **Relevance** is low:
- Refine agent instructions
- Add more diverse examples
- Improve query understanding

If **Coherence** is low:
- Update system prompts for structure
- Add response formatting guidelines
- Use better conversation flow

If **Fluency** is low:
- Adjust language style in instructions
- Use better model (GPT-4 vs GPT-3.5)
- Add tone/style guidelines

## 💡 Pro Tips

- **Compare runs**: Track score trends across deployments
- **Spot check**: Manually review some test conversations
- **Set thresholds**: Fail pipeline if scores drop below minimum
- **A/B testing**: Compare different agent configurations
- **Custom metrics**: Add domain-specific evaluation criteria

## 🎉 Great Job!

You've successfully:
- ✅ Ran comprehensive AI evaluation
- ✅ Reviewed quality metrics
- ✅ Interpreted evaluation scores
- ✅ Identified strengths and improvements

Your agents are now quality-tested!

## ⏭️ What's Next?

After pushing your changes, the hackathon facilitator will automatically:
1. Detect your completion (evaluation-complete.md file)
2. Close this work item
3. Create Step 6: Security Red Team Testing Review

Next, review security red team results to ensure your agents are secure! 🔒
