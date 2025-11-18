# Prompt Patterns & Templates

## Overview

This guide provides reusable prompt patterns and templates for common tasks. Each pattern includes the template, usage guidelines, and examples.

## Pattern Categories

1. **Code Generation** - Creating code from specifications
2. **Analysis & Review** - Evaluating code, documents, data
3. **Content Creation** - Writing documentation, articles, etc.
4. **Data Processing** - Transforming, extracting, analyzing data
5. **Decision Support** - Helping make informed choices
6. **Learning & Teaching** - Explaining concepts, tutoring
7. **Debugging & Troubleshooting** - Finding and fixing problems

---

## Code Generation Patterns

### Pattern: Feature Implementation

**Use when:** Building a new feature or component

**Template:**
```
ROLE: Expert [language] developer following [style guide/framework]

FEATURE REQUEST:
[Description of feature to implement]

TECHNICAL REQUIREMENTS:
- Language/Framework: [specific versions]
- Architecture: [pattern to follow]
- Dependencies: [what you can use]
- Constraints: [limitations]

CODE STANDARDS:
- [Naming conventions]
- [Documentation requirements]
- [Error handling approach]
- [Testing requirements]

DELIVERABLES:
1. Main implementation
2. Unit tests
3. Integration tests (if applicable)
4. Usage example
5. Brief documentation

OUTPUT STRUCTURE:
[Specify files, organization]
```

**Example:**
```
ROLE: Expert TypeScript developer following Airbnb style guide

FEATURE REQUEST:
Implement a caching service with TTL support and LRU eviction

TECHNICAL REQUIREMENTS:
- Language/Framework: TypeScript 5.0+, Node.js
- Architecture: Service class with dependency injection
- Dependencies: Only Node.js built-ins
- Constraints: Must be memory-efficient, thread-safe

CODE STANDARDS:
- Use strict TypeScript types
- JSDoc comments for public methods
- Explicit error handling with custom exceptions
- 80%+ code coverage

DELIVERABLES:
1. CacheService class implementation
2. Comprehensive unit tests
3. Usage examples
4. Performance considerations doc

OUTPUT STRUCTURE:
- src/services/CacheService.ts
- src/services/__tests__/CacheService.test.ts
- examples/cache-usage.ts
```

### Pattern: Code Refactoring

**Use when:** Improving existing code

**Template:**
```
ROLE: Senior developer performing code refactoring

CURRENT CODE:
[Code to refactor]

REFACTORING GOALS:
1. [Goal 1 - e.g., reduce complexity]
2. [Goal 2 - e.g., improve testability]
3. [Goal 3 - e.g., enhance performance]

CONSTRAINTS:
- Maintain backward compatibility: [yes/no]
- Keep same API surface: [yes/no]
- Preserve functionality exactly: [yes/no]

EVALUATION CRITERIA:
- Cyclomatic complexity < [number]
- No functions > [number] lines
- [Other measurable improvements]

OUTPUT:
1. Refactored code
2. Explanation of changes
3. Before/after comparison
4. Test plan for validation
```

### Pattern: Bug Fix

**Use when:** Diagnosing and fixing bugs

**Template:**
```
ROLE: Senior debugger and problem solver

BUG REPORT:
Symptoms: [What's happening]
Expected: [What should happen]
Steps to reproduce: [How to trigger]

CODE:
[Relevant code sections]

CONTEXT:
- Environment: [runtime, versions]
- Recent changes: [what changed recently]
- Error messages: [any errors]

DEBUGGING APPROACH:
1. Analyze code for potential issues
2. Identify root cause
3. Propose fix
4. Suggest tests to prevent regression

OUTPUT:
## Root Cause
[Explanation]

## Proposed Fix
[Code changes]

## Testing
[How to verify fix]

## Prevention
[How to avoid similar bugs]
```

---

## Analysis & Review Patterns

### Pattern: Code Review

**Use when:** Reviewing pull requests or code changes

**Template:**
```
ROLE: Senior engineer conducting code review

CODE TO REVIEW:
[Code or diff]

REVIEW FOCUS:
1. Security vulnerabilities
2. Performance issues
3. Code quality and maintainability
4. Best practices adherence
5. Test coverage
6. Documentation

SEVERITY LEVELS:
- Critical: Must fix before merge
- High: Should fix before merge
- Medium: Should fix soon
- Low: Nice to have

OUTPUT FORMAT:
For each issue:
### [Issue Title]
- **Severity**: [Level]
- **Category**: [Security/Performance/Quality/Tests/Docs]
- **Location**: `[file]:[line]`
- **Issue**: [What's wrong]
- **Why**: [Why it matters]
- **Fix**: [How to fix it]

SUMMARY:
- Overall assessment: Approve / Request Changes / Comment
- Critical/High issues: [count]
- Recommendation: [merge or not]
```

### Pattern: Architecture Review

**Use when:** Evaluating system design decisions

**Template:**
```
ROLE: Solutions architect reviewing system design

PROPOSED ARCHITECTURE:
[Architecture description, diagrams, specs]

EVALUATION FRAMEWORK:
1. **Scalability**: Can it handle growth?
2. **Reliability**: Single points of failure?
3. **Performance**: Will it meet SLAs?
4. **Security**: Threat model coverage?
5. **Maintainability**: Easy to change/debug?
6. **Cost**: Resource efficiency?

CONTEXT:
- Expected scale: [users, requests, data]
- Team size: [developers]
- Timeline: [when needed]
- Constraints: [technical, business]

OUTPUT:
For each dimension:
## [Dimension]
- Assessment: [Good/Concerns/Critical Issues]
- Analysis: [Detailed evaluation]
- Risks: [What could go wrong]
- Recommendations: [Improvements]

FINAL RECOMMENDATION:
[Approve / Modify / Redesign] with reasoning
```

### Pattern: Security Audit

**Use when:** Checking for security vulnerabilities

**Template:**
```
ROLE: Security engineer performing audit

TARGET:
[Code, system, or architecture to audit]

SECURITY FRAMEWORK:
- OWASP Top 10
- Authentication/Authorization
- Data protection
- Input validation
- Cryptography
- API security
- Dependency security

THREAT MODEL:
- Assets: [What needs protection]
- Threat actors: [Who might attack]
- Attack vectors: [How they might attack]

OUTPUT:
For each vulnerability:
### [Vulnerability Name]
- **CVSS Score**: [0-10]
- **Category**: [OWASP category]
- **Location**: [Where found]
- **Description**: [What's vulnerable]
- **Exploit scenario**: [How to exploit]
- **Impact**: [Damage if exploited]
- **Remediation**: [How to fix]
- **References**: [CVE, CWE numbers]

EXECUTIVE SUMMARY:
- Critical vulnerabilities: [count]
- Overall risk: [High/Medium/Low]
- Priority fixes: [top 3]
```

---

## Content Creation Patterns

### Pattern: Technical Documentation

**Use when:** Writing docs for APIs, libraries, tools

**Template:**
```
ROLE: Technical writer with [domain] expertise

DOCUMENTATION TARGET:
[What you're documenting]

AUDIENCE:
- Experience level: [Beginner/Intermediate/Advanced]
- Background: [Assumed knowledge]
- Goals: [What they want to achieve]

DOCUMENTATION REQUIREMENTS:
- Tone: [Professional/Friendly/Formal]
- Detail level: [High-level/Detailed/Comprehensive]
- Include: [Examples/Diagrams/Code samples]

STRUCTURE:
# [Title]

## Overview
[One paragraph - what is it]

## Quick Start
[Minimal example to get started]

## Installation
[How to install/setup]

## Core Concepts
[Key ideas to understand]

## Usage
### [Feature 1]
[Description + example]

### [Feature 2]
[Description + example]

## API Reference
[Detailed API docs]

## Advanced Usage
[Complex scenarios]

## Troubleshooting
[Common issues and solutions]

## FAQ
[Frequently asked questions]
```

### Pattern: Tutorial Creation

**Use when:** Teaching how to do something step-by-step

**Template:**
```
ROLE: Expert teacher creating a tutorial

TUTORIAL GOAL:
Teach [audience] how to [accomplish task]

AUDIENCE:
- Current knowledge: [What they know]
- Learning goal: [What they'll learn]
- Preferred style: [Hands-on/Conceptual/Both]

TUTORIAL STRUCTURE:
## Introduction
- What you'll build
- What you'll learn
- Prerequisites

## Concepts
[Key ideas explained simply]

## Step-by-Step Instructions
### Step 1: [First step]
- Explanation: [Why this step]
- Code: [What to write]
- Result: [What happens]

### Step 2: [Next step]
[Same format]

## Challenges
[Optional exercises]

## Next Steps
[Where to go from here]

REQUIREMENTS:
- Clear explanations for each step
- Working code at each checkpoint
- Expected output shown
- Common mistakes highlighted
```

### Pattern: Blog Post/Article

**Use when:** Writing technical articles or posts

**Template:**
```
ROLE: Technical blogger writing for [audience]

ARTICLE TOPIC:
[What you're writing about]

ARTICLE GOALS:
- Educate about: [Topic]
- Show how to: [Practical application]
- Inspire to: [Action reader should take]

REQUIREMENTS:
- Length: [Word count]
- Tone: [Conversational/Professional/Academic]
- Include: [Code examples/Diagrams/Screenshots]
- SEO keywords: [Primary and secondary]

STRUCTURE:
# [Compelling Title with Keyword]

## Introduction (Hook)
- Problem statement
- Why it matters
- What you'll learn

## Background/Context
[Necessary foundation]

## Main Content
### [Section 1]
[Content with examples]

### [Section 2]
[Content with examples]

### [Section 3]
[Content with examples]

## Practical Example
[Working code or demo]

## Conclusion
- Summary of key points
- Call to action
- Further reading

STYLE GUIDELINES:
- Use "you" (second person)
- Active voice
- Short paragraphs (3-4 sentences)
- Subheadings every 300 words
- Code examples well-commented
```

---

## Data Processing Patterns

### Pattern: Data Extraction

**Use when:** Pulling structured data from unstructured sources

**Template:**
```
ROLE: Data engineer extracting information

SOURCE DATA:
[Unstructured text, logs, documents]

EXTRACTION SCHEMA:
{
  "field1": "type (description)",
  "field2": "type (description)",
  "nested": {
    "field3": "type"
  }
}

EXTRACTION RULES:
- If field not found: [default value or null]
- Date format: [ISO 8601 / custom]
- Number format: [decimal places, units]
- Validation: [rules for valid data]

OUTPUT FORMAT:
Return JSON array of objects matching schema

HANDLING AMBIGUITY:
- Multiple possible values: [take first / all / ask]
- Unclear data: [skip / estimate / flag]
- Missing data: [null / default / omit]
```

### Pattern: Data Transformation

**Use when:** Converting data from one format to another

**Template:**
```
ROLE: Data transformation specialist

INPUT DATA:
[Current format]

INPUT SCHEMA:
[Structure of input]

OUTPUT SCHEMA:
[Desired structure]

TRANSFORMATION RULES:
1. [Field mapping]
2. [Calculations]
3. [Aggregations]
4. [Filtering]

EDGE CASES:
- Missing values: [How to handle]
- Invalid data: [How to handle]
- Duplicates: [Keep / remove / aggregate]

OUTPUT:
Transformed data in target format
```

### Pattern: Data Analysis

**Use when:** Analyzing datasets for insights

**Template:**
```
ROLE: Data analyst

DATASET:
[Data to analyze]

ANALYSIS OBJECTIVES:
1. [What to discover - trends]
2. [What to measure - metrics]
3. [What to compare - segments]

ANALYSIS FRAMEWORK:
- Descriptive statistics (mean, median, distribution)
- Trend analysis (over time)
- Comparative analysis (between groups)
- Correlation analysis (relationships)
- Anomaly detection (outliers)

OUTPUT STRUCTURE:
## Executive Summary
[2-3 sentences of key findings]

## Key Metrics
| Metric | Value | Change | Trend |

## Detailed Analysis
### [Finding 1]
- Data: [Numbers]
- Insight: [What it means]
- Implication: [Why it matters]

### [Finding 2]
[Same structure]

## Recommendations
1. [Action based on findings]
2. [Action based on findings]

## Methodology
[How analysis was performed]
```

---

## Decision Support Patterns

### Pattern: Technology Selection

**Use when:** Choosing between technology options

**Template:**
```
ROLE: Technical architect evaluating options

DECISION CONTEXT:
[What you're building, constraints, goals]

OPTIONS:
1. [Option A]
2. [Option B]
3. [Option C]

EVALUATION CRITERIA:
- Technical fit (how well it solves problem)
- Team expertise (learning curve)
- Community/support (help available)
- Maturity/stability (production-ready?)
- Performance (speed, efficiency)
- Cost (licensing, infrastructure)
- Maintenance (ongoing effort)
- Scalability (future growth)

ANALYSIS:
For each option, evaluate against each criterion

COMPARISON MATRIX:
| Criterion | Weight | Option A | Option B | Option C |
|-----------|--------|----------|----------|----------|

RECOMMENDATION:
- First choice: [Option] because [reasoning]
- Alternative: [Option] if [conditions]
- Avoid: [Option] because [reasoning]

IMPLEMENTATION PLAN:
[Next steps if recommendation accepted]
```

### Pattern: Problem Solving

**Use when:** Working through complex problems

**Template:**
```
ROLE: Problem-solving expert

PROBLEM STATEMENT:
[Clear description of the problem]

CONTEXT:
- Current situation: [What exists now]
- Constraints: [Limitations]
- Success criteria: [What good looks like]

PROBLEM-SOLVING APPROACH:
1. **Understand**: Restate problem, identify root cause
2. **Analyze**: Break down into components
3. **Generate**: Brainstorm possible solutions
4. **Evaluate**: Assess each solution
5. **Decide**: Choose best approach
6. **Plan**: Create action plan

OUTPUT:
## Problem Analysis
[Root cause, contributing factors]

## Possible Solutions
1. [Solution A]
   - Pros: [Benefits]
   - Cons: [Drawbacks]
   - Effort: [Low/Medium/High]

2. [Solution B]
   [Same format]

## Recommended Solution
[Which one and why]

## Implementation Plan
1. [Step 1]
2. [Step 2]
3. [Step 3]

## Risk Mitigation
[What could go wrong and how to handle]
```

---

## Learning & Teaching Patterns

### Pattern: Concept Explanation

**Use when:** Explaining technical concepts

**Template:**
```
ROLE: Expert teacher explaining [topic]

CONCEPT TO EXPLAIN:
[Technical concept]

AUDIENCE:
- Background: [What they know]
- Learning goal: [What they need to understand]
- Preferred learning style: [Visual/Hands-on/Theoretical]

EXPLANATION STRUCTURE:
## Simple Definition
[One sentence explanation]

## Why It Matters
[Real-world relevance]

## How It Works
[Step-by-step breakdown]

## Analogy
[Relate to familiar concept]

## Example
[Concrete, runnable example]

## Common Misconceptions
[What people get wrong]

## When to Use
[Practical guidelines]

## Further Learning
[Next topics to explore]

REQUIREMENTS:
- No jargon without explanation
- Build from simple to complex
- Multiple examples
- Visual aids if helpful
```

### Pattern: Code Explanation

**Use when:** Explaining how code works

**Template:**
```
ROLE: Code teacher explaining implementation

CODE TO EXPLAIN:
[Code snippet or file]

EXPLANATION LEVEL:
- Audience: [Beginner/Intermediate/Advanced]
- Focus: [High-level/Detailed/Both]
- Goal: [Understanding/Implementation/Both]

EXPLANATION STRUCTURE:
## Overview
[What this code does in one sentence]

## Purpose
[Why this code exists, problem it solves]

## How It Works
[Step through the logic]

## Line-by-Line Breakdown
Line X: [What it does, why it's there]
Line Y: [What it does, why it's there]

## Key Concepts Used
- [Concept 1]: [Brief explanation]
- [Concept 2]: [Brief explanation]

## Example Usage
[How to use this code]

## Edge Cases
[Special scenarios handled]

## Improvements
[How it could be better]
```

---

## Debugging & Troubleshooting Patterns

### Pattern: Error Diagnosis

**Use when:** Figuring out what's wrong

**Template:**
```
ROLE: Expert debugger

ERROR REPORT:
- Error message: [Exact error]
- When it occurs: [Circumstances]
- Expected behavior: [What should happen]
- Actual behavior: [What actually happens]

CODE:
[Relevant code]

ENVIRONMENT:
- Language/Runtime: [Version]
- Dependencies: [Versions]
- OS/Platform: [Details]
- Recent changes: [What changed]

DEBUGGING PROCESS:
1. **Understand**: Interpret error message
2. **Locate**: Find where error originates
3. **Analyze**: Determine root cause
4. **Verify**: Confirm diagnosis
5. **Solve**: Propose fix

OUTPUT:
## Error Analysis
[What the error means]

## Root Cause
[Why it's happening]

## Location
[Where in code]

## Fix
[Code changes needed]

## Verification
[How to test the fix]

## Prevention
[How to avoid in future]
```

### Pattern: Performance Optimization

**Use when:** Making code faster or more efficient

**Template:**
```
ROLE: Performance optimization expert

PERFORMANCE ISSUE:
[What's slow or inefficient]

CURRENT METRICS:
- Response time: [Current]
- Throughput: [Current]
- Resource usage: [CPU/Memory]
- Target: [What you need]

CODE/SYSTEM:
[Code or architecture to optimize]

PROFILING DATA:
[Measurements, bottlenecks identified]

OPTIMIZATION APPROACH:
1. Identify hotspots
2. Analyze algorithmic complexity
3. Propose optimizations
4. Estimate improvements
5. Consider trade-offs

OUTPUT:
## Bottleneck Analysis
[What's causing slowness]

## Optimization Opportunities
1. [Optimization 1]
   - Current: O(n²)
   - Proposed: O(n log n)
   - Expected improvement: [X% faster]
   - Trade-off: [Any downsides]
   - Implementation: [Code changes]

2. [Optimization 2]
   [Same format]

## Recommended Approach
[Which optimizations to do, in what order]

## Expected Results
[Performance after optimization]
```

---

## Pattern Combination

### Multi-Pattern Workflow

Often, you'll combine patterns:

**Example: Full Feature Development**
1. Use **Technology Selection** to choose stack
2. Use **Feature Implementation** to build it
3. Use **Code Review** to verify quality
4. Use **Technical Documentation** to document it
5. Use **Tutorial Creation** to teach others

**Example: Problem Resolution**
1. Use **Error Diagnosis** to find the issue
2. Use **Problem Solving** to explore solutions
3. Use **Bug Fix** to implement the fix
4. Use **Code Explanation** to document the solution

---

## Quick Reference

### Choosing a Pattern

| Task | Pattern |
|------|---------|
| Building new code | Feature Implementation |
| Improving code | Code Refactoring |
| Fixing bugs | Bug Fix, Error Diagnosis |
| Reviewing code | Code Review |
| Evaluating design | Architecture Review |
| Security check | Security Audit |
| Writing docs | Technical Documentation |
| Teaching concept | Concept Explanation, Tutorial |
| Making decisions | Technology Selection, Problem Solving |
| Analyzing data | Data Analysis |
| Transforming data | Data Extraction, Data Transformation |
| Speeding up code | Performance Optimization |

### Customizing Patterns

All patterns are templates. Customize by:
- Adjusting sections for your needs
- Adding domain-specific criteria
- Changing output format
- Combining multiple patterns
- Simplifying for simpler tasks

---

**Remember:** These patterns are starting points. Adapt them to your specific needs, combine them creatively, and iterate based on results.
