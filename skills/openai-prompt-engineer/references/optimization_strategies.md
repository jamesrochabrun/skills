# Prompt Optimization Strategies

## Overview

This guide covers systematic approaches to analyzing and improving prompts that aren't giving you the results you need. Learn how to diagnose problems, apply fixes, and measure improvements.

## The Optimization Process

```
1. IDENTIFY → What's wrong with current results?
2. DIAGNOSE → Why is the prompt failing?
3. FIX → Apply appropriate optimization
4. TEST → Verify improvement
5. ITERATE → Refine further if needed
```

---

## Step 1: Identify the Problem

### Common Prompt Problems

| Problem | Symptoms | Quick Test |
|---------|----------|------------|
| **Vague instructions** | Inconsistent outputs, missing requirements | Run prompt 3 times - do you get similar results? |
| **Missing context** | Wrong assumptions, irrelevant responses | Does the prompt include all necessary background? |
| **Unclear format** | Output structure varies | Does prompt specify exact format? |
| **Too complex** | Partial completion, confusion | Does prompt try to do too much at once? |
| **Wrong technique** | Poor accuracy, missed patterns | Does task match technique used? |
| **Model mismatch** | Suboptimal results | Are you using model-specific features? |
| **No examples** | Pattern not learned | Would examples help? |
| **Ambiguous terms** | Misinterpreted requirements | Are terms like "professional" defined? |

### Diagnostic Questions

Ask yourself:

**Clarity:**
- [ ] Is the task stated explicitly?
- [ ] Are all requirements spelled out?
- [ ] Would a junior developer understand this?

**Completeness:**
- [ ] Is all necessary context included?
- [ ] Are constraints specified?
- [ ] Is output format defined?

**Consistency:**
- [ ] Does running it 3x give similar results?
- [ ] Are there contradictory instructions?
- [ ] Is terminology used consistently?

**Appropriateness:**
- [ ] Is the right technique being used?
- [ ] Is this the right model for the task?
- [ ] Is complexity level appropriate?

---

## Step 2: Diagnose Root Cause

### Problem: Inconsistent Results

**Diagnosis:**
- Instructions too vague
- Missing constraints
- Ambiguous terminology
- No output format specified

**How to confirm:**
Run the same prompt 3-5 times and compare outputs.

**Evidence:**
```
Run 1: Returns JSON
Run 2: Returns markdown table
Run 3: Returns plain text

Diagnosis: No format specification
```

### Problem: Wrong or Irrelevant Answers

**Diagnosis:**
- Missing context
- Unclear task definition
- Wrong assumptions by model
- No examples provided

**How to confirm:**
Does the prompt include all information needed to complete the task correctly?

**Evidence:**
```
Prompt: "Optimize this code"
Response: "What language is this? What should I optimize for?"

Diagnosis: Missing context (language, optimization goals)
```

### Problem: Partial Completion

**Diagnosis:**
- Task too complex for single shot
- Prompt too long/confusing
- Multiple competing requirements
- Agentic behavior not calibrated

**How to confirm:**
Break task into smaller parts - does each part work individually?

**Evidence:**
```
Prompt: "Build complete e-commerce backend with auth, payments, inventory"
Response: Only implements auth, ignores rest

Diagnosis: Too complex, needs progressive disclosure
```

### Problem: Incorrect Pattern Application

**Diagnosis:**
- Using few-shot when zero-shot would work
- Missing chain-of-thought for complex reasoning
- No examples when pattern matching needed
- Wrong model for the task

**How to confirm:**
Compare results with different techniques.

**Evidence:**
```
Complex math problem solved directly: Wrong answer
Same problem with "think step-by-step": Correct answer

Diagnosis: Needs chain-of-thought prompting
```

---

## Step 3: Apply Fixes

### Fix: Add Specificity

**Before:**
```
"Write professional code"
```

**After:**
```
"Write TypeScript code following these standards:
- Strict type checking enabled
- JSDoc comments for all public methods
- Error handling for all async operations
- Maximum cyclomatic complexity of 5
- Meaningful variable names (no abbreviations)"
```

**Why it works:** Removes ambiguity, defines "professional" explicitly.

### Fix: Provide Context

**Before:**
```
"Optimize this function:
[code]"
```

**After:**
```
"Optimize this TypeScript function that processes user uploads:

Context:
- Called 1000x per minute
- Typical input: 1-10MB files
- Current bottleneck: O(n²) loop
- Running in Node.js 18

Optimization goals (in priority order):
1. Reduce time complexity
2. Lower memory usage
3. Maintain readability

[code]"
```

**Why it works:** Provides necessary context for appropriate optimization.

### Fix: Specify Format

**Before:**
```
"Analyze this code for issues"
```

**After:**
```
"Analyze this code for issues and respond in this exact format:

## Issues Found

### [Issue Title]
- **Severity**: Critical/High/Medium/Low
- **Category**: Security/Performance/Quality
- **Location**: Line X
- **Problem**: [Description]
- **Fix**: [Specific solution]

### [Next Issue]
[Same format]

## Summary
Total issues: [count by severity]
Recommendation: [Approve/Request Changes]"
```

**Why it works:** Guarantees consistent, parseable output.

### Fix: Add Examples (Few-Shot)

**Before:**
```
"Convert these to camelCase:
user_name
total_count
is_active"
```

**After:**
```
"Convert these to camelCase:

Examples:
user_name → userName
total_count → totalCount

Now convert:
is_active →
created_at →
max_retry_attempts →"
```

**Why it works:** Shows the pattern, improves accuracy.

### Fix: Enable Reasoning (Chain-of-Thought)

**Before:**
```
"What's the time complexity of this algorithm?"
```

**After:**
```
"Analyze the time complexity of this algorithm step-by-step:

1. First, identify the loops and recursive calls
2. Then, determine how many times each executes
3. Next, calculate the overall complexity
4. Finally, express in Big O notation

Algorithm:
[code]"
```

**Why it works:** Structured reasoning leads to correct analysis.

### Fix: Break Down Complexity (Progressive Disclosure)

**Before:**
```
"Build a complete user authentication system with OAuth,
2FA, session management, and password reset"
```

**After:**
```
"Let's build a user authentication system in stages.

STAGE 1: Design the overall architecture
- Components needed
- Data models
- API endpoints

Wait for my review before proceeding to implementation."
```

**Then after review:**
```
"STAGE 2: Implement the core authentication service
- User login with email/password
- JWT token generation
- Session management

Use the architecture we designed in Stage 1."
```

**Why it works:** Breaks overwhelming task into manageable pieces.

### Fix: Add Constraints

**Before:**
```
"Write a function to sort an array"
```

**After:**
```
"Write a function to sort an array with these constraints:

Requirements:
- Input: Array of numbers (may contain duplicates)
- Output: New array, sorted ascending
- Must be pure function (don't modify input)
- Time complexity: O(n log n) or better
- Language: TypeScript with strict types

Edge cases to handle:
- Empty array → return empty array
- Single element → return copy of array
- All same values → return copy of array
- Negative numbers → sort correctly"
```

**Why it works:** Removes ambiguity, ensures all cases handled.

### Fix: Use Model-Specific Features

**For GPT-5:**

**Before (generic):**
```
"Implement this feature"
```

**After (GPT-5 optimized):**
```
SYSTEM: Senior TypeScript developer
TASK: Implement user authentication service
CONSTRAINTS:
- Use JWT with refresh tokens
- TypeScript strict mode
- Include error handling
OUTPUT: Complete implementation with tests
BEHAVIOR: Complete autonomously without asking questions
VERBOSITY: Concise - core functionality only
```

**For Claude:**

**Before (generic):**
```
"Review this code for security issues"
```

**After (Claude optimized):**
```xml
<instruction>
Review this code for security vulnerabilities
</instruction>

<code>
[Code to review]
</code>

<focus_areas>
- SQL injection
- XSS attacks
- Authentication bypasses
- Data exposure
</focus_areas>

<output_format>
For each vulnerability:
- Severity: [Critical/High/Medium/Low]
- Location: [Line number]
- Description: [What's wrong]
- Fix: [How to remediate]
</output_format>
```

---

## Step 4: Test Improvements

### A/B Testing Prompts

**Method:**
1. Keep original prompt as baseline
2. Create improved version
3. Run both on same inputs (5-10 test cases)
4. Compare results objectively

**Evaluation criteria:**
- Accuracy (does it solve the problem?)
- Consistency (similar results each time?)
- Completeness (all requirements met?)
- Quality (meets standards?)
- Format compliance (matches specification?)

**Example:**

| Test Case | Original Prompt | Improved Prompt | Winner |
|-----------|----------------|-----------------|--------|
| Case 1 | 60% accurate | 95% accurate | Improved |
| Case 2 | Wrong format | Correct format | Improved |
| Case 3 | Incomplete | Complete | Improved |
| Case 4 | Correct | Correct | Tie |
| Case 5 | Partial | Complete | Improved |

**Result:** Improved prompt wins 4/5 cases, use it.

### Measuring Improvement

**Quantitative metrics:**
- Success rate: X% of runs produce correct output
- Consistency: X% of runs produce similar output
- Completeness: X% of requirements met on average
- Format compliance: X% match specified format
- Token efficiency: Avg tokens to correct result

**Qualitative assessment:**
- Does it feel easier to use?
- Do results need less manual correction?
- Is output more predictable?
- Are edge cases handled better?

### Iterative Testing

```
Version 1 → Test → 70% success → Identify issues
Version 2 → Test → 85% success → Identify remaining issues
Version 3 → Test → 95% success → Good enough for production
```

Don't expect perfection on first try. Iterate.

---

## Step 5: Continuous Iteration

### When to Iterate Further

**Keep improving if:**
- Success rate < 90%
- Inconsistent outputs across runs
- Missing edge cases
- Requires manual post-processing
- Takes multiple attempts to get right

**Stop iterating when:**
- Success rate > 95%
- Consistent, predictable outputs
- Handles known edge cases
- Minimal manual correction needed
- One-shot success most of the time

### Iteration Strategies

**Strategy 1: Incremental Refinement**
1. Start with basic working prompt
2. Identify most common failure mode
3. Add constraint/example to fix it
4. Test
5. Repeat for next most common failure

**Strategy 2: Template Evolution**
1. Create template with placeholders
2. Test with multiple scenarios
3. Identify missing sections
4. Add new sections to template
5. Retest with scenarios

**Strategy 3: Technique Stacking**
1. Start with base technique (e.g., zero-shot)
2. If accuracy low, add chain-of-thought
3. If still issues, add few-shot examples
4. If format wrong, add explicit structure
5. Layer techniques until quality sufficient

### Tracking What Works

**Maintain a prompt library:**
```
prompts/
├── code-review.md (Success rate: 97%)
├── data-analysis.md (Success rate: 94%)
├── documentation.md (Success rate: 99%)
└── bug-diagnosis.md (Success rate: 91%)
```

**Document each prompt:**
```markdown
# Code Review Prompt

**Success Rate:** 97%
**Last Updated:** 2025-01-15
**Model:** GPT-5 / Claude Sonnet

**Use When:** Reviewing pull requests for security, performance, quality

**Template:**
[Prompt template]

**Known Limitations:**
- May miss complex race conditions
- Better for backend than frontend code

**Changelog:**
- v3 (2025-01-15): Added self-validation step (95% → 97%)
- v2 (2025-01-10): Added severity ratings (90% → 95%)
- v1 (2025-01-05): Initial version (90%)
```

---

## Optimization Checklist

Use this to systematically improve any prompt:

### Clarity
- [ ] Task explicitly stated
- [ ] No ambiguous terms
- [ ] Success criteria defined
- [ ] All requirements listed

### Completeness
- [ ] All necessary context provided
- [ ] Constraints specified
- [ ] Edge cases addressed
- [ ] Output format defined

### Structure
- [ ] Organized into clear sections
- [ ] Appropriate headings/tags
- [ ] Logical flow
- [ ] Easy to parse

### Technique
- [ ] Right approach for task type
- [ ] Examples if pattern matching needed
- [ ] Reasoning steps if complex
- [ ] Progressive disclosure if large

### Model Fit
- [ ] Uses model-specific features
- [ ] Matches model strengths
- [ ] Avoids model weaknesses
- [ ] Appropriate complexity level

### Testability
- [ ] Produces consistent outputs
- [ ] Format is parseable
- [ ] Easy to validate results
- [ ] Clear success/failure criteria

---

## Advanced Optimization Techniques

### Technique 1: Constraint Tuning

**Concept:** Find the right level of constraint specificity.

**Too loose:**
```
"Write good code"
```

**Too tight:**
```
"Write code with exactly 47 lines, 3 functions named specifically
foo, bar, baz, using only these 12 allowed keywords..."
```

**Just right:**
```
"Write TypeScript code:
- 3-5 small functions (<20 lines each)
- Descriptive names
- One responsibility per function
- Type-safe"
```

**Process:**
1. Start loose
2. Add constraints where outputs vary
3. Stop when consistency achieved
4. Don't over-constrain

### Technique 2: Example Engineering

**Concept:** Carefully craft few-shot examples for maximum learning.

**Principles:**
- **Diversity**: Cover different scenarios
- **Edge cases**: Include tricky examples
- **Consistency**: Same format for all
- **Clarity**: Obvious pattern to learn

**Bad examples:**
```
Input: "Hello"
Output: "HELLO"

Input: "Hi"
Output: "HI"

Input: "Hey"
Output: "HEY"
```
(Too similar, no edge cases)

**Good examples:**
```
Input: "Hello World"
Output: "HELLO WORLD"

Input: "it's-a test_case"
Output: "IT'S-A TEST_CASE"

Input: "123abc"
Output: "123ABC"

Input: ""
Output: ""
```
(Diverse, includes spaces, punctuation, numbers, empty)

### Technique 3: Format Scaffolding

**Concept:** Provide the exact structure you want filled in.

**Basic request:**
```
"Analyze this code"
```

**With scaffolding:**
```
"Analyze this code and fill in this template:

## Code Quality: [Good/Fair/Poor]

## Issues Found:
1. [Issue]: [Description]
   - Location: [Line X]
   - Fix: [Solution]

2. [Issue]: [Description]
   - Location: [Line Y]
   - Fix: [Solution]

## Strengths:
- [Strength 1]
- [Strength 2]

## Recommendation: [Approve/Request Changes]"
```

**Result:** Guaranteed format match.

### Technique 4: Self-Correction Loop

**Concept:** Ask the model to validate and fix its own output.

**Single-pass:**
```
"Generate a JSON API response for user data"
```

**With self-correction:**
```
"Generate a JSON API response for user data.

After generating:
1. Validate JSON syntax
2. Check all required fields present
3. Verify data types correct
4. Ensure no sensitive data exposed

If validation fails, fix issues and regenerate."
```

**Result:** Higher quality, fewer errors.

### Technique 5: Precision Through Negation

**Concept:** Specify what NOT to do as well as what to do.

**Positive only:**
```
"Write a professional email"
```

**Positive + Negative:**
```
"Write a professional email:

DO:
- Use formal salutation (Dear [Name])
- State purpose in first sentence
- Use clear, concise language
- Include specific next steps

DON'T:
- Use contractions (don't, won't, etc.)
- Include emojis or informal language
- Exceed 3 paragraphs
- End without clear call-to-action"
```

**Result:** Avoids common mistakes.

---

## Common Optimization Patterns

### Pattern: Vague → Specific

**Before:** "Make this better"
**After:** "Refactor to reduce complexity from 15 to <5, extract helper functions, add type safety"

### Pattern: No Examples → Few-Shot

**Before:** "Format these dates"
**After:** "2025-01-15 → January 15, 2025\n2024-12-01 → December 1, 2024\nNow format: 2025-03-22"

### Pattern: Single-Shot → Progressive

**Before:** "Build entire app"
**After:** "Stage 1: Design architecture [wait for approval] Stage 2: Implement core [wait for approval]..."

### Pattern: Generic → Model-Specific

**Before:** "Review this code"
**After (GPT-5):** "SYSTEM: Senior dev\nTASK: Code review\nCONSTRAINTS:..."
**After (Claude):** `<instruction>Review code</instruction><code>...</code>`

### Pattern: Implicit → Explicit Format

**Before:** "List the issues"
**After:** "List issues as:\n1. [Issue] - Line X - [Fix]\n2. [Issue] - Line Y - [Fix]"

---

## Quick Reference

### Optimization Decision Tree

```
Is output inconsistent?
├─ Yes → Add format specification + constraints
└─ No → Continue

Is output incomplete?
├─ Yes → Check if task too complex → Use progressive disclosure
└─ No → Continue

Is output inaccurate?
├─ Yes → Add examples (few-shot) or reasoning (CoT)
└─ No → Continue

Is output low quality?
├─ Yes → Add quality criteria + validation step
└─ No → Prompt is good!
```

### Quick Fixes

| Symptom | Quick Fix |
|---------|-----------|
| Varying formats | Add exact format template |
| Wrong answers | Add "think step-by-step" |
| Inconsistent results | Add specific constraints |
| Missing edge cases | Add explicit edge case handling |
| Too verbose | Specify length limit |
| Too brief | Request "detailed" or "comprehensive" |
| Wrong assumptions | Provide complete context |
| Partial completion | Break into stages |

---

**Remember:** Optimization is iterative. Start simple, measure results, identify failures, apply targeted fixes, and repeat until quality is sufficient. Don't over-engineer prompts that already work well enough.
