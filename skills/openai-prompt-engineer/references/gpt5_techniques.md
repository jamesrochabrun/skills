# GPT-5 Specific Techniques

## Overview

GPT-5 represents a significant advancement in LLM capabilities, requiring updated prompting strategies that differ from GPT-4 and earlier models. This guide covers GPT-5-specific techniques based on official OpenAI guidelines.

## Key Architectural Changes

### What's Different in GPT-5

1. **Agentic behavior** - GPT-5 is proactive and thorough by default
2. **Better reasoning** - Native step-by-step thinking without explicit prompting
3. **Instruction adherence** - Superior at following complex constraints
4. **Reduced hallucination** - More factually accurate
5. **Context handling** - Better at long-context tasks

### What No Longer Works

**Old GPT-4 techniques that fail with GPT-5:**

❌ **Excessive repetition** - Don't repeat instructions multiple times
```
BAD (GPT-4 style):
"Write code. Remember to write code. Make sure you write code.
The task is to write code."

GOOD (GPT-5):
"Write a TypeScript authentication service with JWT support."
```

❌ **Over-prompting for reasoning** - GPT-5 reasons well by default
```
BAD:
"Think carefully. Take your time. Reason step-by-step. Don't rush.
Make sure to think deeply..."

GOOD:
"Analyze this architecture decision:"
[GPT-5 will reason appropriately without excessive prompting]
```

❌ **Contradictory instructions** - GPT-5 will call these out
```
BAD:
"Be concise but provide extensive detail with comprehensive examples..."
[GPT-5 may refuse or ask for clarification]

GOOD:
"Provide a detailed explanation (3-4 paragraphs) with 2 code examples"
```

## Structured Prompting Format

### The Triple-S Pattern: System, Specification, Structure

**Optimal GPT-5 prompt structure:**

```
SYSTEM (Role + Context):
You are [specific role with relevant expertise]
[Brief context about the situation]

SPECIFICATION (Task + Constraints):
Task: [Clear, specific task]
Requirements:
- [Requirement 1]
- [Requirement 2]
Constraints:
- [Limitation 1]
- [Limitation 2]

STRUCTURE (Output Format):
Provide output as:
[Exact format specification]
```

**Example:**
```
SYSTEM:
You are a senior security engineer reviewing authentication systems.
This is a production system handling 1M+ daily active users.

SPECIFICATION:
Task: Review this authentication implementation for security vulnerabilities
Requirements:
- Focus on OWASP Top 10 vulnerabilities
- Consider token-based auth best practices
- Evaluate session management approach
Constraints:
- Only flag issues with security implications
- Must provide specific line numbers
- Include severity ratings (Critical/High/Medium/Low)

STRUCTURE:
For each vulnerability found:
1. Title: [Brief description]
2. Severity: [Rating]
3. Location: [File:Line]
4. Explanation: [Why this is a problem]
5. Fix: [Specific code recommendation]
6. References: [Relevant security standards]
```

## Reasoning Effort Control

### Understanding Reasoning Effort

GPT-5 includes a `reasoning_effort` parameter that controls computational intensity:

- **Low** - Quick responses, simple tasks
- **Medium** (default) - Balanced approach
- **High** - Deep reasoning, complex problems

### When to Adjust Reasoning Effort

**Use Low reasoning_effort:**
- Simple transformations
- Formatting tasks
- Quick classifications
- Template filling
- Fast iterations needed

**Use Medium reasoning_effort:**
- Standard coding tasks
- Content generation
- Analysis tasks
- Most general work

**Use High reasoning_effort:**
- Complex algorithms
- Architecture decisions
- Security analysis
- Mathematical proofs
- Multi-step reasoning
- Critical decisions

### Prompting for Higher Reasoning

If you can't control the API parameter, trigger higher reasoning in prompts:

```
"This is a high-stakes decision requiring careful analysis.
Consider all edge cases and potential failure modes before responding.

[Your task]"
```

**Magic phrases that trigger deeper reasoning:**
- "This is a high-stakes/critical task"
- "Analyze thoroughly before responding"
- "Consider all edge cases"
- "Think through potential failure modes"

## Agentic Behavior Calibration

### Understanding GPT-5's Agentic Nature

GPT-5 is proactive by default - it will:
- Ask clarifying questions
- Suggest improvements
- Point out potential issues
- Offer alternatives
- Request more context

### Controlling Agentic Behavior

**For maximum autonomy (task completion mode):**
```
"Complete this task end-to-end without asking for guidance.
Make reasonable assumptions where needed and persist until
the task is fully handled.

[Task description]"
```

**For collaborative mode (step-by-step):**
```
"Work on this task incrementally, asking for my confirmation
before making significant decisions or assumptions.

[Task description]"
```

**For minimal agency (just answer):**
```
"Answer this question directly based only on the information
provided. Do not suggest alternatives or ask for clarification.

[Question]"
```

### Examples

**Task Completion Mode:**
```
"Implement a complete REST API for user management with
authentication. Make standard architectural decisions and
persist until fully implemented. Use TypeScript, Express,
and PostgreSQL."

Result: GPT-5 will complete entire implementation without
asking intermediate questions.
```

**Collaborative Mode:**
```
"Let's build a REST API for user management. Start by proposing
the overall architecture and wait for my feedback before
implementing."

Result: GPT-5 will propose, wait for approval, then implement
each piece with check-ins.
```

## Verbosity Management

### The Verbosity Challenge

GPT-5 tends to be thorough (sometimes too thorough), providing:
- Detailed explanations
- Multiple examples
- Edge case discussions
- Alternative approaches

### Controlling Output Length

**For concise output:**
```
"Provide a concise implementation:
- Core functionality only
- Minimal comments
- Under 50 lines of code
- No explanatory text"
```

**For detailed output:**
```
"Provide a comprehensive solution:
- Fully documented code
- Multiple examples showing different use cases
- Detailed explanation of design decisions
- Error handling for edge cases"
```

**Using word/line limits:**
```
"Explain JWT authentication in exactly 3 paragraphs (about 150 words total)"

"Write this function in under 30 lines with inline comments"

"List the top 5 issues only, one sentence each"
```

### Verbosity Spectrum

```
"Minimal" → Core answer only, no elaboration
"Concise" → Brief answer with key points
"Standard" → Balanced explanation with examples
"Detailed" → Thorough with multiple examples
"Comprehensive" → Exhaustive coverage of topic
```

## Prompt Optimization Workflow

### 1. Start with Clear Structure

```
ROLE: [Who the AI is]
TASK: [What to do]
CONSTRAINTS: [Limitations]
FORMAT: [Output structure]
```

### 2. Add Reasoning Guidance (if complex)

```
"Approach this step-by-step:
1. First, [step 1]
2. Then, [step 2]
3. Finally, [step 3]"
```

### 3. Specify Verbosity

```
"Provide a [concise/detailed/comprehensive] [output type]
of approximately [length]"
```

### 4. Set Agentic Behavior

```
"[Complete autonomously / Ask before major decisions /
Answer directly without suggestions]"
```

## Common GPT-5 Patterns

### Pattern 1: Code Generation

```
SYSTEM:
You are an expert [language] developer following [style guide]

TASK:
Implement [specific feature] with these requirements:
[Requirement list]

CODE STYLE:
- [Style point 1]
- [Style point 2]

OUTPUT:
1. Implementation code with JSDoc/docstrings
2. Unit tests covering main scenarios
3. Brief usage example

CONSTRAINTS:
- Under [X] lines for main implementation
- Follow [pattern/architecture]
- Handle [specific edge cases]
```

### Pattern 2: Analysis Tasks

```
SYSTEM:
You are a [domain] expert analyzing [subject]

DATA:
[Data/code/content to analyze]

ANALYSIS FRAMEWORK:
1. Identify [aspect 1]
2. Evaluate [aspect 2]
3. Assess [aspect 3]
4. Recommend [improvements]

OUTPUT FORMAT:
## Summary
[2-3 sentences]

## Findings
[Structured findings]

## Recommendations
[Prioritized action items]
```

### Pattern 3: Creative Content

```
SYSTEM:
You are a [type] writer with expertise in [domain]

TASK:
Create [content type] about [topic]

REQUIREMENTS:
- Audience: [target audience]
- Tone: [specific tone]
- Length: [word count]
- Style: [style guidelines]

INCLUDE:
- [Element 1]
- [Element 2]

STRUCTURE:
[Specific outline or format]
```

### Pattern 4: Decision Support

```
SYSTEM:
You are a [role] helping with a strategic decision

DECISION CONTEXT:
[Background information]

OPTIONS:
1. [Option 1]
2. [Option 2]
3. [Option 3]

ANALYSIS REQUIRED:
For each option, analyze:
- Pros and cons
- Risks and mitigations
- Resource requirements
- Implementation complexity
- Expected outcomes

RECOMMENDATION:
Provide ranked recommendation with reasoning

THINK STEP-BY-STEP:
Consider all implications before recommending
```

## Using the GPT-5 Prompt Optimizer

### What the Optimizer Does

OpenAI provides a prompt optimizer that:
- Identifies contradictions
- Removes redundancy
- Adds missing specifications
- Improves structure
- Suggests format improvements
- Fixes common anti-patterns

### When to Use It

**Good candidates for optimization:**
- Complex prompts with multiple requirements
- Prompts getting inconsistent results
- Long prompts with possible contradictions
- Migrating GPT-4 prompts to GPT-5

**Don't optimize:**
- Simple, working prompts
- Prompts that are already well-structured
- When you need full control over exact wording

### Optimization Process

1. Submit prompt to optimizer
2. Review suggested changes
3. Understand the reasoning
4. Test optimized version
5. Iterate if needed

**Example transformation:**

**Before (GPT-4 style):**
```
You are a developer. Write code. Make sure to write good code.
The code should be in Python. Don't forget to add comments.
Remember to handle errors. The code should be clean. Make it
maintainable. Think about edge cases. Write tests too.
```

**After (GPT-5 optimized):**
```
ROLE: Senior Python developer

TASK: Implement [feature]

REQUIREMENTS:
- Clean, maintainable code
- Comprehensive error handling
- Inline comments for complex logic
- Unit tests for main scenarios

OUTPUT:
1. Implementation
2. Tests
3. Usage example
```

## Advanced GPT-5 Techniques

### Technique 1: Constraint Layering

Stack constraints from general to specific:

```
GENERAL CONSTRAINTS:
- Language: TypeScript
- Framework: React
- Style: Functional components

SPECIFIC CONSTRAINTS:
- Use hooks (useState, useEffect)
- Props interface must be exported
- Handle loading and error states

EDGE CASE CONSTRAINTS:
- Handle empty data gracefully
- Debounce rapid state changes
- Clean up subscriptions in useEffect
```

### Technique 2: Format Enforcement

Use examples to enforce exact format:

```
OUTPUT FORMAT EXAMPLE:
{
  "status": "success|error",
  "data": {
    "field1": "value",
    "field2": 123
  },
  "metadata": {
    "timestamp": "ISO 8601",
    "version": "1.0"
  }
}

Now process this input and return in exactly this format:
[Input data]
```

### Technique 3: Multi-Stage Reasoning

Break complex tasks into explicit stages:

```
STAGE 1 - ANALYSIS:
First, analyze the requirements and identify:
- Core functionality needed
- Technical constraints
- Potential challenges

STAGE 2 - DESIGN:
Then, design the solution:
- Propose architecture
- Choose patterns
- Plan data flow

STAGE 3 - IMPLEMENTATION:
Finally, implement with:
- Clean code
- Error handling
- Tests

Complete each stage fully before moving to the next.
```

### Technique 4: Self-Validation

Ask GPT-5 to validate its own output:

```
[Task description]

After completing the task, validate your output against:
1. All requirements met
2. No contradictions
3. Edge cases handled
4. Code compiles/runs
5. Tests pass

If validation fails, fix issues and re-validate.
```

## Common Mistakes with GPT-5

### Mistake 1: Over-Prompting

❌ **Don't:**
```
"Please carefully think about this step-by-step and make sure
you reason through it thoroughly and don't rush and take your
time to analyze..."
```

✅ **Do:**
```
"Analyze this step-by-step:"
```

### Mistake 2: Contradictory Requirements

❌ **Don't:**
```
"Be very concise but include extensive detail and comprehensive
examples covering all edge cases"
```

✅ **Do:**
```
"Provide a focused explanation (2-3 paragraphs) with one
representative example"
```

### Mistake 3: Unclear Success Criteria

❌ **Don't:**
```
"Write good, clean code that follows best practices"
```

✅ **Do:**
```
"Write code that:
- Passes TypeScript strict mode
- Has < 10 cyclomatic complexity per function
- Includes JSDoc for public methods
- Handles null/undefined explicitly"
```

### Mistake 4: Ignoring Agentic Behavior

❌ **Don't:**
```
[Give vague task and get frustrated when GPT-5 asks questions]
```

✅ **Do:**
```
"Complete this autonomously, making standard decisions..."
OR
"Let's work on this step-by-step with check-ins..."
```

## Best Practices Summary

### Structure
- Use SYSTEM/SPECIFICATION/STRUCTURE format
- Layer constraints from general to specific
- Provide explicit examples for format

### Reasoning
- Let GPT-5 reason naturally for most tasks
- Use "high-stakes" language for deeper analysis
- Break complex tasks into explicit stages

### Behavior
- Set clear agentic behavior expectations
- Use "persist until complete" for autonomy
- Use "ask before major decisions" for collaboration

### Verbosity
- Specify exact length requirements
- Use "concise" or "comprehensive" explicitly
- Give word/line count limits

### Optimization
- Start with clear structure
- Use the optimizer for complex prompts
- Test and iterate based on results
- Remove GPT-4 anti-patterns

## Quick Reference

### Prompt Template
```
SYSTEM:
You are [role] with [expertise]
[Context]

SPECIFICATION:
Task: [Clear task]
Requirements:
- [Req 1]
- [Req 2]
Constraints:
- [Limit 1]
- [Limit 2]

STRUCTURE:
[Exact output format]

BEHAVIOR:
[Complete autonomously / Collaborate / Direct answer only]

VERBOSITY:
[Concise/Standard/Detailed] - approximately [length]
```

### Quick Fixes

| Problem | Solution |
|---------|----------|
| Inconsistent results | Add explicit constraints |
| Too verbose | Specify length + "concise" |
| Asks too many questions | "Complete autonomously" |
| Not thorough enough | "High-stakes" + explicit stages |
| Wrong format | Provide format example |
| Contradictions | Use optimizer to identify |
| Slow responses | Lower reasoning_effort |

---

**Remember:** GPT-5 is smarter but needs clearer structure. Less repetition, more precision.
