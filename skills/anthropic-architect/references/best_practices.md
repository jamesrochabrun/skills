# Anthropic Architecture Best Practices (2025)

Proven best practices for designing, building, and maintaining Anthropic-based systems.

## Table of Contents

1. [Core Design Principles](#core-design-principles)
2. [Progressive Disclosure](#progressive-disclosure)
3. [Context Management](#context-management)
4. [Security & Safety](#security--safety)
5. [Performance Optimization](#performance-optimization)
6. [Skill Design](#skill-design)
7. [Agent Design](#agent-design)
8. [Testing & Validation](#testing--validation)
9. [Maintenance & Evolution](#maintenance--evolution)
10. [Cost Optimization](#cost-optimization)

---

## Core Design Principles

### 1. Start Simple, Scale Complexity

**Principle:** Always begin with the simplest solution that meets requirements.

**Why:** Avoid over-engineering and unnecessary complexity.

**How:**
```
Level 1: Try Direct Prompt
  └─ Works? → Done
  └─ Too complex? → Continue

Level 2: Create Skill
  └─ Works? → Done
  └─ Needs isolation? → Continue

Level 3: Use Agents
  └─ Works? → Done
  └─ Need custom workflow? → Continue

Level 4: SDK Primitives
  └─ Full control achieved
```

**Example:**
```
Task: Generate code review

❌ Wrong: Immediately build custom SDK agent
✅ Right: Try direct prompt first

"Review this PR for:
- Code quality issues
- Security vulnerabilities
- Performance concerns"

If inconsistent → Create code-review skill
If too complex → Use agent with multiple phases
```

---

### 2. Progressive Disclosure First

**Principle:** Show only what's needed, when it's needed.

**Why:** Optimize context usage, reduce costs, improve performance.

**How:**
```
Structure information hierarchically:
├── Index/Overview (always load)
├── Topic Overviews (load on demand)
├── Detailed Content (load when requested)
└── Examples (load if needed)
```

**Anti-Pattern:**
```markdown
❌ DON'T: Dump entire skill into context

skill/
└── SKILL.md (100KB of everything)
    → Context overload
    → Slow responses
    → High costs
```

**Best Practice:**
```markdown
✅ DO: Structure for progressive disclosure

skill/
├── SKILL.md (overview, 2KB)
├── index.md (navigation, 1KB)
└── topics/
    ├── topic_1/
    │   ├── overview.md (1KB)
    │   └── details.md (loaded on request)
    └── topic_2/
        ├── overview.md (1KB)
        └── details.md (loaded on request)

Total initial load: ~4KB vs 100KB
```

---

### 3. Context as Precious Resource

**Principle:** Treat every token as valuable and limited.

**Why:** Context windows have limits and costs.

**Context Budget:**
```
Claude 4.x: 200K tokens
- Reserve: 50K for responses
- Available: 150K for context
- Budget wisely!
```

**Best Practices:**
- ✅ Load only necessary information
- ✅ Summarize large outputs
- ✅ Use progressive disclosure
- ✅ Reset context periodically
- ✅ Compress repeated information
- ❌ Don't dump raw logs
- ❌ Don't load unused references
- ❌ Don't repeat information

---

### 4. Clear, Explicit Instructions

**Principle:** Claude 4.x responds best to unambiguous direction.

**Why:** Reduces errors, improves consistency, better results.

**Comparison:**
```
❌ Vague:
"Make the code better"

✅ Clear:
"Refactor this function to:
1. Extract magic numbers to constants
2. Add type annotations
3. Improve variable names for clarity
4. Add error handling for edge cases
Format: Return only the refactored code"
```

**Template:**
```
<instructions>
TASK: [Clear task definition]

REQUIREMENTS:
- [Specific requirement 1]
- [Specific requirement 2]
- [Specific requirement 3]

OUTPUT FORMAT:
[Exact format expected]

CONSTRAINTS:
- [Constraint 1]
- [Constraint 2]
</instructions>

<examples>
[2-3 examples showing desired pattern]
</examples>
```

---

### 5. Security by Design

**Principle:** Deny-all default, allowlist approach.

**Why:** Safe, controlled AI systems.

**Security Checklist:**
- [ ] Minimal tool permissions
- [ ] Allowlist approved tools only
- [ ] Deny dangerous commands
- [ ] Require confirmations for sensitive ops
- [ ] Audit all operations
- [ ] Implement rollback capability
- [ ] Validate all inputs
- [ ] Sandbox execution when possible

**Default Agent Security:**
```typescript
const secureAgent = new Agent({
  // Deny-all default
  tools: [],

  // Explicitly allow minimal tools
  allowlist: [
    'Read',   // Read-only
    'Grep',   // Search-only
    'Glob'    // Find-only
  ],

  // Block dangerous operations
  denylist: [
    'rm -rf',
    'sudo',
    'exec',
    'eval'
  ],

  // Require confirmation
  confirmations: [
    'git push',
    'deployment',
    'data modification'
  ]
});
```

---

## Progressive Disclosure

### Pattern: Query-Based Disclosure

**Best Practice:**
```
skill/
├── SKILL.md
│   Content: High-level overview
│   Size: < 2KB
│   Purpose: Introduce skill capabilities
│
├── index.md
│   Content: Navigation/TOC
│   Size: < 1KB
│   Purpose: Guide to available topics
│
└── content/
    └── topic/
        ├── overview.md (load first)
        ├── details.md (load on demand)
        └── examples.md (load when requested)
```

**Loading Strategy:**
```
1. Initial load: SKILL.md + index.md (~3KB)
2. User asks about "authentication"
3. Load: authentication/overview.md (~1KB)
4. User needs details
5. Load: authentication/details.md (~3KB)
6. User wants examples
7. Load: authentication/examples.md (~2KB)

Total: 9KB loaded vs 50KB if dumped all at once
Savings: 82% context reduction
```

---

### Pattern: Hierarchical Expertise

**Best Practice:**
```
expertise/
├── by_task/
│   ├── authentication.md
│   ├── api_design.md
│   └── testing.md
├── by_language/
│   ├── typescript.md
│   ├── python.md
│   └── rust.md
├── by_pattern/
│   ├── repository.md
│   └── factory.md
└── quick_reference/
    └── cheatsheet.md
```

**Query Examples:**
```
"How to implement auth?" → Load: by_task/authentication.md
"TypeScript style guide?" → Load: by_language/typescript.md
"Repository pattern?" → Load: by_pattern/repository.md
"Quick naming conventions?" → Load: quick_reference/cheatsheet.md
```

---

## Context Management

### Best Practice 1: Periodic Context Reset

**Why:** Long sessions accumulate irrelevant context.

**When to reset:**
- After completing major task
- Context feels "bloated"
- Responses become slower
- Approaching token limits

**How:**
```
Option 1: New conversation
- Start fresh conversation
- Provide summary of previous work

Option 2: Explicit reset request
- Ask Claude to forget irrelevant context
- Summarize key points to retain

Option 3: Use separate agents
- Different agents for different tasks
- Clean contexts per task
```

---

### Best Practice 2: Summarize, Don't Dump

**Anti-Pattern:**
```
❌ DON'T: Dump raw logs

"Here are the test results:"
[10,000 lines of test output]
```

**Best Practice:**
```
✅ DO: Summarize key information

"Test Results Summary:
- Total: 1,247 tests
- Passed: 1,245 (99.8%)
- Failed: 2
  - test_auth_token_expiration (line 456)
  - test_rate_limiting (line 789)
- Duration: 2m 34s"
```

---

### Best Practice 3: Compress Repeated Information

**Anti-Pattern:**
```
❌ DON'T: Repeat same information

Task 1: "Following these coding standards: [full standards]"
Task 2: "Following these coding standards: [full standards]"
Task 3: "Following these coding standards: [full standards]"
```

**Best Practice:**
```
✅ DO: Reference once, use skill

Task 1: Load: coding-standards-skill
Task 2: "Continue following loaded coding standards"
Task 3: "Continue following loaded coding standards"
```

---

## Security & Safety

### Best Practice 1: Minimal Permissions

**Principle:** Grant minimum tools needed for task.

**Example: Code Analysis**
```typescript
const analysisAgent = new Agent({
  tools: [
    'Read',   // Read code
    'Grep',   // Search code
    'Glob'    // Find files
  ]
  // NO Write, Edit, Bash, etc.
});
```

**Example: Code Modification**
```typescript
const codeAgent = new Agent({
  tools: [
    'Read',   // Read existing code
    'Edit'    // Modify code
  ]
  // NO Bash (can't execute)
  // NO full Write (use Edit for safety)
});
```

---

### Best Practice 2: Confirmation for Sensitive Operations

**Always require confirmation:**
- git push
- Deployment commands
- Data deletion
- System modifications
- API calls to production
- Database changes

**Implementation:**
```typescript
const deployAgent = new Agent({
  confirmations: [
    'git push',
    'npm publish',
    'kubectl apply',
    'terraform apply',
    'aws',
    'gcloud'
  ]
});
```

---

### Best Practice 3: Audit Logging

**Why:** Track all AI operations for security and debugging.

**What to log:**
- Tool usage
- Commands executed
- Files modified
- API calls made
- Errors encountered
- User confirmations

**Implementation:**
```typescript
const auditedAgent = new Agent({
  audit: {
    enabled: true,
    level: 'verbose',
    includeContext: true,
    destination: './logs/agent-audit.log',
    retention: '90days'
  }
});
```

---

## Performance Optimization

### Best Practice 1: Parallel Execution

**When possible, parallelize:**

**Anti-Pattern:**
```
❌ Sequential (slow):
1. Analyze file1.ts → 10s
2. Analyze file2.ts → 10s
3. Analyze file3.ts → 10s
Total: 30s
```

**Best Practice:**
```
✅ Parallel (fast):
1. Analyze file1.ts ──┐
2. Analyze file2.ts ──┼→ All run simultaneously
3. Analyze file3.ts ──┘
Total: 10s (3x faster)
```

**Implementation:**
```
Launch 3 agents in parallel:
- Agent 1: file1.ts
- Agent 2: file2.ts
- Agent 3: file3.ts
Aggregate results
```

---

### Best Practice 2: Cache Frequent Queries

**Pattern:**
```
skill/
└── cache/
    ├── frequently_asked.md
    └── common_patterns.md
```

**Example:**
```
Common query: "How to handle errors?"

Instead of processing each time:
1. Maintain: error_handling.md with comprehensive guide
2. Query → Immediately load cached response
3. Fast, consistent responses
```

---

### Best Practice 3: Optimize Token Usage

**Token Optimization Checklist:**
- [ ] Use progressive disclosure
- [ ] Summarize large outputs
- [ ] Remove redundant information
- [ ] Compress repeated content
- [ ] Use shorter variable names in examples
- [ ] Remove unnecessary whitespace
- [ ] Reference external docs vs embedding

**Example:**
```
❌ High token usage:
const myVeryLongDescriptiveVariableName = 'value';
const anotherVeryLongDescriptiveVariableName = 'value';

✅ Optimized:
const user = 'value';
const data = 'value';
// Still clear, fewer tokens
```

---

## Skill Design

### Best Practice 1: Single Responsibility

**Principle:** Each skill should have one clear purpose.

**Anti-Pattern:**
```
❌ DON'T: Mega-skill doing everything

super-skill/
├── frontend/
├── backend/
├── database/
├── devops/
└── testing/
→ Too broad, context overload
```

**Best Practice:**
```
✅ DO: Focused skills

frontend-expert/
├── components/
├── styling/
└── accessibility/

backend-expert/
├── apis/
├── services/
└── databases/
```

---

### Best Practice 2: Clear Documentation

**Skill Documentation Template:**
```markdown
---
name: skill-name
description: One-sentence description
---

# Skill Name

## What This Skill Does
[2-3 sentences explaining purpose]

## When to Use
- ✅ Use case 1
- ✅ Use case 2
- ❌ Not for use case 3

## Quick Start
[Simple example]

## Reference Materials
- file1.md - Description
- file2.md - Description

## Examples
[2-3 concrete examples]
```

---

### Best Practice 3: Version Skills

**Why:** Track changes, enable rollback, communicate updates.

**Structure:**
```
skill/
├── VERSION (e.g., 2.1.0)
├── CHANGELOG.md
├── SKILL.md
└── references/
```

**CHANGELOG.md:**
```markdown
# Changelog

## [2.1.0] - 2025-01-15
### Added
- New pattern: async error handling
- Examples for TypeScript 5.x

### Changed
- Updated API guidelines for REST

### Fixed
- Corrected authentication example

## [2.0.0] - 2024-12-01
### Breaking Changes
- Restructured reference materials
```

---

## Agent Design

### Best Practice 1: Clear Agent Boundaries

**Principle:** Each agent should have clear, distinct responsibilities.

**Anti-Pattern:**
```
❌ DON'T: Monolithic agent doing everything

BigAgent
├── Explores codebase
├── Plans changes
├── Executes changes
├── Runs tests
├── Deploys
└── Monitors
→ Too much responsibility, hard to debug
```

**Best Practice:**
```
✅ DO: Specialized agents

Main Orchestrator
├── Explore Agent (read-only)
├── Plan Agent (planning)
├── Code Agent (implementation)
├── Test Agent (validation)
└── Report Agent (aggregation)
```

---

### Best Practice 2: Agent Communication Patterns

**Pattern: Parent-Child**
```
Main Agent
│
├─→ Subagent 1: Task
│   └─→ Returns: Result
│
├─→ Subagent 2: Task
│   └─→ Returns: Result
│
└─→ Main aggregates results
```

**Pattern: Pipeline**
```
Agent 1: Explore
  └─→ Output: Analysis
      └─→ Agent 2: Plan
          └─→ Output: Plan
              └─→ Agent 3: Execute
                  └─→ Output: Changes
```

**Pattern: Parallel Workers**
```
Coordinator
├─┬─ Worker 1 ──┐
│ ├─ Worker 2 ──┤
│ ├─ Worker 3 ──┼→ Aggregator → Result
│ └─ Worker 4 ──┘
```

---

### Best Practice 3: Error Handling in Agents

**Principle:** Graceful failure and recovery.

**Pattern:**
```typescript
const resilientAgent = async (task) => {
  try {
    const result = await agent.run(task);
    return result;
  } catch (error) {
    // Log error
    logger.error('Agent failed', error);

    // Attempt recovery
    if (isRecoverable(error)) {
      return await retryWithBackoff(agent, task);
    }

    // Fallback strategy
    return await fallbackStrategy(task);
  }
};
```

---

## Testing & Validation

### Best Practice 1: Test Skills

**What to test:**
- Skill loads correctly
- References are accessible
- Examples are valid
- Scripts execute successfully

**Example:**
```bash
#!/bin/bash
# test_skill.sh

echo "Testing skill: $1"

# Test 1: Skill file exists
if [ ! -f "$1/SKILL.md" ]; then
  echo "❌ SKILL.md not found"
  exit 1
fi

# Test 2: References are valid
for ref in $1/references/*.md; do
  if [ ! -f "$ref" ]; then
    echo "❌ Reference missing: $ref"
    exit 1
  fi
done

# Test 3: Scripts are executable
for script in $1/scripts/*.sh; do
  if [ ! -x "$script" ]; then
    echo "❌ Script not executable: $script"
    exit 1
  fi
done

echo "✅ All tests passed"
```

---

### Best Practice 2: Validate Agent Output

**Pattern:**
```typescript
const validateAgentOutput = async (output) => {
  // Schema validation
  if (!matchesSchema(output)) {
    throw new Error('Invalid output schema');
  }

  // Business logic validation
  if (!meetsRequirements(output)) {
    throw new Error('Output doesn\'t meet requirements');
  }

  // Safety checks
  if (containsDangerousContent(output)) {
    throw new Error('Output contains dangerous content');
  }

  return output;
};
```

---

## Maintenance & Evolution

### Best Practice 1: Regular Skill Updates

**Schedule:**
- Monthly: Review and update examples
- Quarterly: Major updates for new patterns
- Yearly: Comprehensive review and restructure

**Update Checklist:**
- [ ] New patterns added
- [ ] Deprecated patterns removed
- [ ] Examples updated for current versions
- [ ] Documentation improved
- [ ] User feedback incorporated
- [ ] Version bumped
- [ ] Changelog updated

---

### Best Practice 2: Deprecation Strategy

**When deprecating:**
```markdown
## [3.0.0] - 2025-06-01

### Deprecated
⚠️ OLD PATTERN (Deprecated, remove in 4.0.0):
[Old pattern example]

✅ NEW PATTERN (Use instead):
[New pattern example]

Migration guide: See MIGRATION.md
```

**Deprecation Timeline:**
1. Announce deprecation (version N)
2. Maintain both patterns (version N+1)
3. Remove old pattern (version N+2)

---

## Cost Optimization

### Best Practice 1: Token Efficiency

**Strategies:**
- Use progressive disclosure (load less)
- Summarize outputs (fewer tokens)
- Cache frequent queries (reuse)
- Compress repeated content (deduplicate)
- Choose smaller models when possible (Haiku vs Sonnet)

**Example:**
```
Task: Simple syntax error fix

❌ Expensive: Use Sonnet for everything
Cost: $X per request

✅ Optimized: Use Haiku for simple tasks
Cost: $X/5 per request
Savings: 80%
```

---

### Best Practice 2: Model Selection

**Choose model based on complexity:**

**Haiku (Fast, Cheap):**
- Simple queries
- Straightforward tasks
- Well-defined operations
- Cost-sensitive applications

**Sonnet (Balanced):**
- Medium complexity
- Most general tasks
- Good balance of capability/cost
- Default choice

**Opus (Powerful, Expensive):**
- Complex reasoning
- Critical tasks
- High-stakes decisions
- Quality over cost

---

## Summary Checklist

**Design Phase:**
- [ ] Start with simplest solution
- [ ] Apply progressive disclosure
- [ ] Plan for context efficiency
- [ ] Design security boundaries
- [ ] Consider performance needs

**Implementation Phase:**
- [ ] Follow single responsibility
- [ ] Implement clear documentation
- [ ] Add version control
- [ ] Include error handling
- [ ] Add audit logging

**Testing Phase:**
- [ ] Test skill loading
- [ ] Validate agent outputs
- [ ] Check security controls
- [ ] Verify performance
- [ ] Test edge cases

**Maintenance Phase:**
- [ ] Regular updates
- [ ] Deprecation strategy
- [ ] User feedback loop
- [ ] Cost monitoring
- [ ] Performance optimization

---

**Remember:** The best practices evolve. Stay current with Anthropic updates and community patterns.
