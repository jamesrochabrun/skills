# Prompt Templates

Ready-to-use prompt templates for common tasks.

## Template 1: Data Extraction

```xml
<role>
You are a data extraction specialist.
</role>

<instructions>
Extract structured information from the text below.
</instructions>

<text>
{{INPUT_TEXT}}
</text>

<schema>
{
  "field1": "type",
  "field2": "type",
  "field3": "type"
}
</schema>

<rules>
- If information is missing, use null
- Preserve exact values (don't paraphrase)
- Validate data types match schema
</rules>
```

---

## Template 2: Code Review

```xml
<role>
You are a {{LANGUAGE}} expert with {{YEARS}} years of experience.
</role>

<task>
Review the following code for:
1. Bugs and errors
2. Performance issues
3. Security vulnerabilities
4. Best practice violations
5. Code style and readability
</task>

<code>
{{CODE_HERE}}
</code>

<output_format>
For each issue:

### Issue: [Title]
- **Severity**: Critical/High/Medium/Low
- **Category**: Bug/Performance/Security/Style
- **Location**: Line {{LINE_NUMBER}}
- **Problem**: [Description]
- **Fix**: [Recommendation]
- **Code**:
```{{LANGUAGE}}
[Fixed code]
```
</output_format>
```

---

## Template 3: Content Generation

```xml
<task>
Write a {{CONTENT_TYPE}} about {{TOPIC}}.
</task>

<requirements>
- **Length**: {{WORD_COUNT}} words
- **Tone**: {{TONE}}
- **Audience**: {{AUDIENCE}}
- **Format**: {{FORMAT}}
</requirements>

<must_include>
- {{POINT_1}}
- {{POINT_2}}
- {{POINT_3}}
</must_include>

<structure>
1. {{SECTION_1}}
2. {{SECTION_2}}
3. {{SECTION_3}}
4. {{SECTION_4}}
</structure>

<examples>
<example>
<good_example>
{{EXAMPLE_TEXT}}
</good_example>
<why_good>
{{EXPLANATION}}
</why_good>
</example>
</examples>
```

---

## Template 4: Classification

```xml
<instructions>
Classify the following {{ITEM_TYPE}} into one of these categories:
{{CATEGORY_LIST}}
</instructions>

<classification_rules>
- {{RULE_1}}
- {{RULE_2}}
- {{RULE_3}}
</classification_rules>

<examples>
{{FEW_SHOT_EXAMPLES}}
</examples>

<item>
{{ITEM_TO_CLASSIFY}}
</item>

<output_format>
{
  "category": "{{CATEGORY}}",
  "confidence": {{0-1}},
  "reasoning": "{{BRIEF_EXPLANATION}}"
}
</output_format>
```

---

## Template 5: Analysis and Insights

```xml
<role>
You are an expert {{DOMAIN}} analyst.
</role>

<task>
Analyze the following {{DATA_TYPE}} and provide insights.
</task>

<data>
{{DATA_HERE}}
</data>

<analysis_framework>
1. **Overview**: What are we looking at?
2. **Patterns**: What trends or patterns emerge?
3. **Anomalies**: What's unexpected or noteworthy?
4. **Insights**: What does this mean?
5. **Recommendations**: What actions should be taken?
</analysis_framework>

<output_requirements>
- Support claims with data
- Quantify findings where possible
- Prioritize insights by impact
- Be specific and actionable
</output_requirements>
```

---

## Template 6: Debugging Assistant

```xml
<role>
You are a debugging expert for {{LANGUAGE/FRAMEWORK}}.
</role>

<problem>
{{ERROR_MESSAGE_OR_DESCRIPTION}}
</problem>

<code>
{{PROBLEMATIC_CODE}}
</code>

<context>
{{ADDITIONAL_CONTEXT}}
</context>

<debugging_process>
Think step by step:

1. What is the error telling us?
2. What could cause this error?
3. What's the most likely root cause?
4. How can we fix it?
5. How can we prevent this in the future?
</debugging_process>

<output>
Provide:
1. Root cause explanation
2. Fixed code with comments
3. Prevention tips
</output>
```

---

## Template 7: Comparison and Evaluation

```xml
<task>
Compare {{OPTION_A}} vs {{OPTION_B}} for {{USE_CASE}}.
</task>

<evaluation_criteria>
1. {{CRITERION_1}}
2. {{CRITERION_2}}
3. {{CRITERION_3}}
4. {{CRITERION_4}}
</evaluation_criteria>

<option_a>
{{DETAILS_A}}
</option_a>

<option_b>
{{DETAILS_B}}
</option_b>

<output_format>
## Summary
[2-3 sentence overview]

## Detailed Comparison

| Criterion | {{OPTION_A}} | {{OPTION_B}} | Winner |
|-----------|--------------|--------------|--------|
| {{CRIT_1}} | [analysis] | [analysis] | [A/B/Tie] |

## Recommendation
[Specific recommendation with reasoning]
</output_format>
```

---

## Template 8: Step-by-Step Tutorial

```xml
<task>
Create a step-by-step tutorial for {{TASK}}.
</task>

<audience>
{{TARGET_AUDIENCE}} with {{SKILL_LEVEL}} level knowledge
</audience>

<requirements>
- {{REQUIREMENT_1}}
- {{REQUIREMENT_2}}
- {{REQUIREMENT_3}}
</requirements>

<structure>
For each step:
1. **Step title**: Clear, action-oriented
2. **Explanation**: Why this step matters
3. **Instructions**: How to do it
4. **Code/Example**: Concrete implementation
5. **Expected result**: What success looks like
6. **Common issues**: Troubleshooting tips
</structure>

<tone>
- Clear and encouraging
- Explain technical terms
- Assume no prior knowledge beyond prerequisites
</tone>
```

---

## Template 9: API/Function Documentation

```xml
<task>
Generate comprehensive documentation for this {{API/FUNCTION}}.
</task>

<code>
{{CODE_HERE}}
</code>

<documentation_template>
## {{FUNCTION_NAME}}

### Description
[What it does and when to use it]

### Signature
```{{LANGUAGE}}
[function signature]
```

### Parameters
- `param1` (type): Description
- `param2` (type): Description

### Returns
- (type): Description

### Raises/Throws
- `ExceptionType`: When and why

### Examples

```{{LANGUAGE}}
# Example 1: Basic usage
[code]

# Example 2: Advanced usage
[code]
```

### Notes
- [Important consideration 1]
- [Important consideration 2]
</documentation_template>
```

---

## Template 10: Prompt Improvement

```xml
<task>
Improve the following prompt to be more effective.
</task>

<original_prompt>
{{PROMPT_TO_IMPROVE}}
</original_prompt>

<improvement_criteria>
1. Clarity and specificity
2. Proper structure (XML tags)
3. Examples where helpful
4. Clear output format
5. Appropriate context
6. Avoid common mistakes
</improvement_criteria>

<improved_prompt>
[Provide the improved version with explanations of changes]
</improved_prompt>

<explanation>
**Changes made:**
1. [Change 1 and why]
2. [Change 2 and why]
3. [Change 3 and why]
</explanation>
```
