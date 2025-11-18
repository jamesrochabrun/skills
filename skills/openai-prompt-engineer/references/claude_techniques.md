# Claude-Specific Techniques

## Overview

Claude (by Anthropic) excels at instruction following, long-context tasks, and detailed analysis. This guide covers techniques optimized specifically for Claude, based on official Anthropic documentation and best practices.

## Claude's Strengths

### What Claude Does Best

1. **Instruction adherence** - Exceptional at following complex, detailed instructions
2. **Long context** - Handles 100K+ tokens effectively
3. **Structured output** - Excels with XML and structured formats
4. **Safety and helpfulness** - Well-calibrated for harmless, helpful responses
5. **Analysis depth** - Thorough analysis when asked
6. **Reasoning clarity** - Shows work step-by-step naturally

### Key Differentiators

**Claude vs GPT-5:**
- Better with very long contexts (200K vs GPT-5's limits)
- More conservative (less likely to make things up)
- Responds better to XML structuring
- Excellent at detailed instruction following
- Strong at nuanced analysis

## XML Tag Structuring

### Why XML Tags Matter

Claude was trained with XML tags extensively, making them highly effective for:
- Separating different types of content
- Creating clear structure
- Guiding output format
- Organizing complex prompts

### Basic XML Pattern

```xml
<instruction>
Your main task description
</instruction>

<context>
Background information Claude needs
</context>

<constraints>
- Limitation 1
- Limitation 2
</constraints>

<output_format>
Expected structure of the response
</output_format>
```

### Common Tag Names

**Use these for clarity:**

- `<instruction>` - Main task
- `<context>` - Background info
- `<examples>` - Sample inputs/outputs
- `<constraints>` - Limitations
- `<output_format>` - Desired structure
- `<data>` - Data to process
- `<document>` - Long-form content
- `<code>` - Code snippets
- `<thinking>` - Request reasoning steps

**Example:**
```xml
<instruction>
Review this code for security vulnerabilities
</instruction>

<code>
function login(username, password) {
  const query = `SELECT * FROM users WHERE username='${username}'`;
  // ... more code
}
</code>

<focus_areas>
- SQL injection
- Password handling
- Session management
</focus_areas>

<output_format>
For each issue:
- Severity: Critical/High/Medium/Low
- Location: Line number
- Problem: Description
- Fix: Recommended solution
</output_format>
```

## Step-by-Step Thinking

### Enabling Reasoning

Claude naturally shows reasoning when asked, but you can enhance it:

**Simple approach:**
```
Think step-by-step about this problem:

[Problem description]
```

**Structured approach:**
```xml
<instruction>
Solve this problem by thinking through it step-by-step
</instruction>

<problem>
[Problem description]
</problem>

<thinking_process>
1. First, identify the key components
2. Then, analyze relationships
3. Next, consider edge cases
4. Finally, provide solution
</thinking_process>
```

**Explicit reasoning request:**
```
Before providing your answer, explain your reasoning process.

<thinking>
[Let Claude show its work here]
</thinking>

<answer>
[Then provide the final answer here]
</answer>
```

### Benefits

- More accurate results
- Visible logic for debugging
- Builds trust in responses
- Helps Claude catch its own errors
- Better for complex problems

## Clear and Specific Instructions

### The Clarity Principle

**Treat Claude like a skilled intern on day one:**
- Provide ALL necessary context
- Define terms explicitly
- Give specific examples
- State assumptions clearly
- Specify exact requirements

### Bad vs Good Instructions

**❌ Vague:**
```
"Make this better"
```

**✅ Specific:**
```
"Refactor this function to:
1. Reduce cyclomatic complexity below 5
2. Extract helper functions for clarity
3. Add type annotations
4. Include JSDoc comments
5. Handle null/undefined edge cases"
```

**❌ Ambiguous:**
```
"Write professional content"
```

**✅ Explicit:**
```
"Write in formal business tone with these characteristics:
- No contractions (use 'do not' vs 'don't')
- Active voice
- Sentences under 20 words
- Direct address ('you') rather than third person
- Industry-standard terminology
- Professional but approachable"
```

### Specificity Checklist

- [ ] Exact task clearly stated
- [ ] Output format specified
- [ ] Length/size requirements defined
- [ ] Tone/style described
- [ ] Edge cases addressed
- [ ] Success criteria stated
- [ ] Examples provided (if applicable)
- [ ] Constraints listed

## Progressive Disclosure

### Why It Matters for Claude

With Claude's 100K+ token context window, you might be tempted to dump everything at once. Don't.

**Progressive disclosure benefits:**
- More focused responses
- Better token efficiency
- Clearer reasoning chains
- Easier to course-correct
- More maintainable conversations

### Pattern: Multi-Stage Workflow

**Stage 1: High-level analysis**
```xml
<instruction>
Analyze this codebase structure and provide:
1. List of main components
2. Key dependencies
3. Overall architecture pattern
</instruction>

<codebase>
[File structure]
</codebase>
```

**Stage 2: Focused deep-dive**
```xml
<instruction>
Now, for the authentication component you identified,
perform a detailed security review
</instruction>

<context>
You previously identified the auth component at: [location]
</context>

<focus>
Review for:
- Authentication bypass vulnerabilities
- Token security
- Session management
- Password handling
</focus>
```

**Stage 3: Implementation**
```xml
<instruction>
Based on the security issues you found, implement fixes
for the high-severity items
</instruction>

<issues_to_fix>
[High severity issues from previous response]
</issues_to_fix>
```

### When to Use Progressive Disclosure

**Good for:**
- Large codebases
- Multi-step workflows
- Research tasks
- Iterative refinement
- Complex projects

**Not needed for:**
- Simple, single-shot tasks
- Well-defined transformations
- When all context fits easily

## Example-Driven Prompting

### Few-Shot with Claude

Claude excels at learning from examples. Show 2-5 examples of desired behavior:

```xml
<instruction>
Convert casual messages to professional email format
</instruction>

<examples>
<example>
<input>
Hey! Got your message. That sounds cool, let's do it!
</input>
<output>
Thank you for your message. I appreciate the proposal and
would be pleased to move forward with this initiative.
</output>
</example>

<example>
<input>
Thanks! I'll get back to you later about this.
</input>
<output>
Thank you. I will provide you with my response regarding
this matter at my earliest convenience.
</output>
</example>
</examples>

<task>
Now convert this message:
"Sounds good! See you next week for the meeting."
</task>
```

### Example Quality Matters

**Good examples:**
- Cover edge cases
- Show variety
- Are realistic
- Demonstrate exact format
- Include challenging scenarios

**Poor examples:**
- Too similar to each other
- Unrealistic/contrived
- Missing edge cases
- Inconsistent format

## Long-Context Best Practices

### Leveraging Claude's 100K+ Token Window

Claude can handle massive context, but structure it well:

```xml
<task>
Analyze all these customer support tickets for common issues
</task>

<tickets>
<ticket id="1">
[Ticket 1 content]
</ticket>

<ticket id="2">
[Ticket 2 content]
</ticket>

<!-- ... many more tickets ... -->

<ticket id="1523">
[Ticket 1523 content]
</ticket>
</tickets>

<analysis_instructions>
1. Categorize issues by type
2. Identify the top 5 most common problems
3. Calculate frequency for each
4. Recommend solutions for top issues
5. Note any patterns across tickets
</analysis_instructions>

<output_format>
## Issue Categories
[List of categories found]

## Top 5 Issues
1. [Issue]: [Frequency] - [Description]
   - Recommended solution: [Solution]

## Patterns Observed
[Cross-ticket patterns]
</output_format>
```

### Long-Context Tips

1. **Use clear delimiters** - XML tags, markdown headers
2. **Structure hierarchically** - Group related content
3. **Reference by ID** - Make it easy to cite specific parts
4. **Summarize upfront** - Give Claude the big picture first
5. **Be specific in queries** - Don't make Claude search the entire context

## Document Analysis Pattern

### For Large Documents

```xml
<instruction>
Analyze this technical specification document
</instruction>

<document>
[Large technical document - can be 50K+ tokens]
</document>

<analysis_framework>
1. COMPLETENESS: Are all necessary sections present?
2. CLARITY: Are requirements unambiguous?
3. CONSISTENCY: Any contradictions?
4. FEASIBILITY: Any technical concerns?
5. GAPS: What's missing?
</analysis_framework>

<output_format>
For each framework dimension:
## [Dimension]
- Assessment: [Good/Needs Work/Critical Issues]
- Findings: [Specific findings with section references]
- Recommendations: [What to improve]
</output_format>
```

## Code Review Pattern

### Thorough Code Analysis

```xml
<instruction>
Conduct a comprehensive code review
</instruction>

<code_files>
<file path="auth/service.ts">
[Code content]
</file>

<file path="auth/controller.ts">
[Code content]
</file>

<file path="auth/middleware.ts">
[Code content]
</file>
</code_files>

<review_criteria>
<security>
- Authentication/authorization flaws
- Input validation
- Sensitive data exposure
- Injection vulnerabilities
</security>

<quality>
- Code complexity
- Naming conventions
- DRY violations
- Error handling
</quality>

<performance>
- N+1 queries
- Unnecessary loops
- Inefficient algorithms
</performance>
</review_criteria>

<output_format>
For each issue found:
### [Issue Title]
- **Severity**: Critical/High/Medium/Low
- **Category**: Security/Quality/Performance
- **Location**: `[file]:[line]`
- **Problem**: [Clear description]
- **Impact**: [Why this matters]
- **Fix**: [Specific code solution]

At the end:
### Summary
- Total issues: [count by severity]
- Recommendation: Approve / Request Changes / Comment
- Must-fix before merge: [Critical/High issues]
</output_format>
```

## Iterative Refinement Pattern

### Building Complex Solutions

**Round 1: Initial Draft**
```xml
<instruction>
Create an initial draft of a REST API design for user management
</instruction>

<requirements>
- CRUD operations for users
- Authentication required
- Role-based permissions
- Email verification flow
</requirements>
```

**Round 2: Refine Based on Feedback**
```xml
<instruction>
Refine the API design based on this feedback
</instruction>

<original_design>
[Claude's previous response]
</original_design>

<feedback>
- Add rate limiting specifications
- Include pagination for list endpoints
- Define error response format
- Add API versioning strategy
</feedback>
```

**Round 3: Implementation Details**
```xml
<instruction>
Now provide implementation details for the refined design
</instruction>

<context>
Refined API design: [design from round 2]
</context>

<implementation_requirements>
- TypeScript with Express
- PostgreSQL database
- JWT authentication
- Include OpenAPI spec
</implementation_requirements>
```

## Structured Output Enforcement

### Guaranteed Format with XML

```xml
<instruction>
Analyze this data and respond ONLY in the specified XML format
</instruction>

<data>
[Data to analyze]
</data>

<required_output_format>
<analysis>
  <summary>One paragraph overview</summary>
  <metrics>
    <metric name="[name]" value="[value]" trend="up|down|stable"/>
    <!-- Repeat for each metric -->
  </metrics>
  <insights>
    <insight priority="high|medium|low">
      <finding>What was discovered</finding>
      <implication>What it means</implication>
      <action>What to do</action>
    </insight>
    <!-- Repeat for each insight -->
  </insights>
</analysis>
</required_output_format>

Do not include any text outside this XML structure.
```

## Common Claude Patterns

### Pattern 1: Document Summarization

```xml
<instruction>
Summarize this document for [target audience]
</instruction>

<document>
[Long document]
</document>

<summary_requirements>
- Length: [word count]
- Focus: [key aspects]
- Include: [specific elements]
- Tone: [formal/casual/technical]
</summary_requirements>

<output_structure>
1. Executive Summary (2-3 sentences)
2. Key Points (bullet list)
3. Important Details (1-2 paragraphs)
4. Action Items (if applicable)
</output_structure>
```

### Pattern 2: Data Extraction

```xml
<instruction>
Extract structured data from these unstructured documents
</instruction>

<documents>
<document id="1">
[Unstructured text]
</document>
<!-- More documents -->
</documents>

<extraction_schema>
{
  "name": "string",
  "date": "YYYY-MM-DD",
  "amount": "number",
  "category": "string",
  "tags": ["string"]
}
</extraction_schema>

<output_format>
Return a JSON array of objects matching the schema
</output_format>
```

### Pattern 3: Comparative Analysis

```xml
<instruction>
Compare these options across the specified dimensions
</instruction>

<options>
<option name="Option A">
[Details]
</option>

<option name="Option B">
[Details]
</option>

<option name="Option C">
[Details]
</option>
</options>

<comparison_dimensions>
- Cost (initial and ongoing)
- Performance (speed, scalability)
- Complexity (setup, maintenance)
- Risk (technical, business)
- Timeline (implementation time)
</comparison_dimensions>

<output_format>
## Comparison Matrix
| Dimension | Option A | Option B | Option C |
|-----------|----------|----------|----------|

## Analysis
For each dimension, explain the differences

## Recommendation
Ranked recommendation with reasoning
</output_format>
```

## Best Practices Summary

### Structure Your Prompts

✅ **DO:**
- Use XML tags for organization
- Separate concerns clearly
- Provide complete context
- Show examples
- Specify exact format

❌ **DON'T:**
- Mix different types of content without delimiters
- Leave requirements implicit
- Assume Claude knows your context
- Skip format specification

### Leverage Long Context

✅ **DO:**
- Include all relevant information
- Structure with clear sections
- Use progressive disclosure for complex tasks
- Reference specific parts by ID

❌ **DON'T:**
- Dump unstructured mass of text
- Make Claude search for key info
- Forget to organize hierarchically

### Request Reasoning

✅ **DO:**
- Ask for step-by-step thinking
- Request explanations
- Use `<thinking>` tags
- Show work for complex problems

❌ **DON'T:**
- Accept black-box answers for important decisions
- Skip reasoning on complex tasks

### Be Specific

✅ **DO:**
- Define exact requirements
- Specify tone, length, format
- Give concrete examples
- State success criteria

❌ **DON'T:**
- Use vague terms like "better" or "professional"
- Assume Claude knows what you want
- Leave format open-ended

## Quick Reference

### Basic Template

```xml
<instruction>
[Clear, specific task]
</instruction>

<context>
[Background information]
</context>

<requirements>
- [Requirement 1]
- [Requirement 2]
</requirements>

<constraints>
- [Constraint 1]
- [Constraint 2]
</constraints>

<examples>
[If using few-shot]
</examples>

<output_format>
[Exact structure expected]
</output_format>
```

### Quick Tips

| Goal | Technique |
|------|-----------|
| Structured output | XML tags with schema |
| Complex reasoning | Ask for step-by-step thinking |
| Learning patterns | 2-5 few-shot examples |
| Long documents | XML sections with IDs |
| Precise format | Provide exact template |
| Detailed analysis | Multi-stage progressive disclosure |
| Consistent style | Specific style guidelines + examples |

---

**Remember:** Claude excels with clear structure, XML tags, and detailed instructions. Be explicit, provide context, and leverage its long-context capabilities.
