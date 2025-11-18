# Claude 4.x Best Practices

Specific best practices for Claude 4.x models (Opus 4, Sonnet 4.5, Haiku 4).

## What's Different in Claude 4.x

Claude 4.x models have been trained for **more precise instruction following** than previous generations.

**Key improvements:**
- Better adherence to explicit instructions
- Enhanced attention to details and examples
- Improved thinking capabilities for complex reasoning
- More consistent output formatting
- Better handling of structured data

---

## Best Practice 1: Be Explicitly Clear

Claude 4.x responds especially well to clear, explicit instructions.

**Do this:**
```
Write a Python function that validates email addresses.

Requirements:
- Function name: validate_email
- Input: string
- Output: boolean
- Use regex for validation
- Support international domains
- Include docstring with examples
```

**Not this:**
```
Make an email validator in Python
```

---

## Best Practice 2: Provide Context and Motivation

Explaining *why* helps Claude 4.x understand goals and deliver targeted responses.

**Good:**
```
I'm building a user registration system for a SaaS application.
I need to validate email addresses to ensure users provide legitimate contact info.

Write a robust email validation function in Python that:
[requirements]
```

**Better understanding** → **Better results**

---

## Best Practice 3: Ensure Examples Align

Claude 4.x pays close attention to examples as part of instruction following.

**Critical:** Examples must perfectly match desired behavior

❌ **Misaligned example:**
```xml
<instructions>
Extract dates in ISO format (YYYY-MM-DD)
</instructions>

<example>
Input: "Meeting on January 5th, 2024"
Output: 01/05/2024  <!-- Wrong format! -->
</example>
```

✅ **Aligned example:**
```xml
<instructions>
Extract dates in ISO format (YYYY-MM-DD)
</instructions>

<example>
Input: "Meeting on January 5th, 2024"
Output: 2024-01-05
</example>
```

---

## Best Practice 4: Leverage Thinking Capabilities

Claude 4.x has enhanced thinking capabilities for complex tasks.

**Use thinking for:**
- Multi-step reasoning
- Complex analysis
- Problem-solving
- Reflection after tool use

**Example:**
```xml
<task>
Analyze this codebase architecture and suggest improvements.
</task>

<instructions>
First, think through the analysis in <thinking> tags:
1. What patterns are being used?
2. What are the strengths?
3. What are the weaknesses?
4. What improvements would have the most impact?

Then provide your recommendations.
</instructions>

<codebase>
[code here]
</codebase>
```

---

## Best Practice 5: Guide Initial Thinking

You can guide Claude's thinking process for better results.

**Example:**
```
Solve this algorithm problem. Before coding, think through:

<thinking_guide>
1. What is the core problem?
2. What data structures would be efficient?
3. What's the time complexity target?
4. Are there edge cases to consider?
</thinking_guide>

Then implement the solution.
```

---

## Best Practice 6: Use Structured Prompts

Claude 4.x excels with well-organized prompts.

**Template:**
```xml
<role>
You are a senior software engineer reviewing code.
</role>

<task>
Review the following pull request for security vulnerabilities.
</task>

<code>
[code here]
</code>

<focus_areas>
- SQL injection risks
- XSS vulnerabilities
- Authentication issues
- Input validation
</focus_areas>

<output_format>
For each issue found:
1. Severity: Critical/High/Medium/Low
2. Location: File and line number
3. Description: What's wrong
4. Recommendation: How to fix
</output_format>
```

---

## Best Practice 7: Specify Precision Level

Claude 4.x can adjust precision based on your needs.

**For high accuracy:**
```
Analyze this data with high precision. Double-check all calculations.
If uncertain about anything, state your confidence level.
```

**For creative tasks:**
```
Generate creative marketing slogans. Prioritize originality and impact.
```

---

## Best Practice 8: Test and Iterate

Claude 4.x's consistency makes testing more reliable.

**Recommended approach:**
1. Create test cases covering:
   - Happy path
   - Edge cases
   - Error conditions
   - Boundary values

2. Run prompt against all test cases

3. Identify patterns in failures

4. Refine prompt based on failures

5. Repeat until quality threshold met

---

## Model Selection Guide

Choose the right Claude 4.x model for your use case:

### Opus 4
**Best for:**
- Highest accuracy requirements
- Complex reasoning tasks
- Mission-critical applications
- Creative writing
- In-depth analysis

**Example use cases:**
- Legal document analysis
- Complex code generation
- Research synthesis
- Strategic planning

### Sonnet 4.5
**Best for:**
- Balance of performance and cost
- Most production applications
- Real-time interactions
- General-purpose tasks

**Example use cases:**
- Chatbots
- Content generation
- Code review
- Data extraction

### Haiku 4
**Best for:**
- Speed-critical applications
- High-volume processing
- Simpler tasks
- Cost optimization

**Example use cases:**
- Classification
- Simple extraction
- Quick summaries
- Moderation

---

## Performance Optimization

### Token Efficiency

**Minimize unnecessary tokens:**
```xml
<!-- Inefficient -->
<instructions>
I would like you to please analyze the following text
and then extract any email addresses that you find
in the text and return them to me in a list format.
</instructions>

<!-- Efficient -->
<instructions>
Extract all email addresses from the text below.
Return as a JSON array.
</instructions>
```

### Batching

**For multiple similar tasks:**
```xml
<instructions>
Classify each review as positive/negative/neutral.
</instructions>

<reviews>
<review id="1">[text]</review>
<review id="2">[text]</review>
<review id="3">[text]</review>
</reviews>

<output_format>
[
  {"id": "1", "sentiment": "positive"},
  {"id": "2", "sentiment": "negative"},
  ...
]
</output_format>
```

---

## Production Readiness Checklist

Before deploying prompts in production:

- [ ] Tested on diverse inputs
- [ ] Edge cases handled
- [ ] Output format strictly controlled
- [ ] Examples align with instructions
- [ ] Context minimized to essentials
- [ ] Error handling specified
- [ ] Token usage optimized
- [ ] Model version specified
- [ ] Success metrics defined
- [ ] Fallback behavior defined
