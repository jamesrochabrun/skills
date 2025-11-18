# Architectural Decision Rubric

Comprehensive framework for choosing the right Anthropic architecture for your project.

## Overview

This rubric evaluates seven key dimensions to recommend the optimal combination of Skills, Agents, Prompts, and SDK primitives.

## The Seven Dimensions

### 1. Task Complexity
### 2. Reusability Requirements
### 3. Context Management
### 4. Security & Control
### 5. Performance Needs
### 6. Maintenance Burden
### 7. Time to Market

---

## 1. Task Complexity Analysis

### Low Complexity (Score: 1-3)
**Characteristics:**
- Single operation or simple workflow
- Clear input → output mapping
- No dependencies or minimal dependencies
- Linear execution (no branching)
- 1-5 steps maximum
- Can be described in one sentence

**Recommendation:** **Direct Prompts**

**Examples:**
- "Explain this function"
- "Fix this typo"
- "Add a comment to this class"
- "Format this JSON"
- "Translate this error message"

**Implementation:**
```
Simple, clear instruction to Claude without additional structure
```

---

### Medium Complexity (Score: 4-6)
**Characteristics:**
- Multiple related operations
- Structured workflow with steps
- Some dependencies between steps
- Requires reference materials or examples
- 5-20 steps
- Benefits from organization and guidance
- Reusable pattern

**Recommendation:** **Skills**

**Examples:**
- Generate comprehensive code review
- Create design system component
- Write technical documentation with examples
- Analyze codebase for patterns
- Generate test suite following guidelines

**Implementation:**
```
skill/
├── SKILL.md (main documentation)
├── references/
│   ├── patterns.md
│   ├── examples.md
│   └── guidelines.md
└── scripts/ (optional)
    └── helper.sh
```

---

### High Complexity (Score: 7-9)
**Characteristics:**
- Multi-step autonomous workflow
- Needs isolated context
- Parallel execution beneficial
- Different phases with different requirements
- 20+ steps or multiple parallel tracks
- Requires exploration, planning, execution, validation
- Different tool permissions per phase

**Recommendation:** **Agents/Subagents**

**Examples:**
- Full codebase refactoring
- Comprehensive security audit
- Multi-file feature implementation
- Documentation generation across entire project
- Performance optimization analysis and fixes

**Implementation:**
```
Main Agent (orchestrator)
├── Explore Subagent (read-only, analysis)
├── Plan Subagent (planning, no execution)
├── Execute Subagent (write permissions)
└── Validate Subagent (testing, verification)
```

---

### Custom Complexity (Score: 10)
**Characteristics:**
- Unique workflow requirements
- System integration needed
- Custom tools required
- Specific feedback loops
- Production deployment
- Fine-grained control necessary

**Recommendation:** **SDK Primitives**

**Examples:**
- Custom CI/CD integration
- Proprietary system automation
- Domain-specific code analysis
- Production AI features
- Specialized agent behaviors

**Implementation:**
```typescript
import { Agent, Tool } from 'claude-agent-sdk';

const customAgent = new Agent({
  tools: [customTool1, customTool2],
  workflow: customFeedbackLoop,
  integrations: [ciSystem, deploySystem]
});
```

---

## 2. Reusability Requirements

### Single Use (Score: 1-2)
**Characteristics:**
- One-time task
- Project-specific
- No future reuse expected
- Temporal need

**Recommendation:** **Direct Prompts**

**Examples:**
- Debug this specific bug
- Update this particular file
- Answer question about this code

---

### Personal Reuse (Score: 3-4)
**Characteristics:**
- You'll use it multiple times
- Personal workflow optimization
- Not shared with team

**Recommendation:** **Skills (Personal)**

**Examples:**
- Your personal code review checklist
- Your preferred refactoring patterns
- Your documentation template

**Storage:** Local `.claude/skills/` directory

---

### Team Reuse (Score: 5-7)
**Characteristics:**
- Multiple team members benefit
- Team-wide patterns
- Shared knowledge
- Collaboration value

**Recommendation:** **Skills (Team Plugin)**

**Examples:**
- Team coding standards
- Project-specific patterns
- Shared workflows
- Team documentation templates

**Storage:** Team repository plugin

---

### Organization Reuse (Score: 8-9)
**Characteristics:**
- Cross-team benefit
- Company-wide standards
- Multiple projects
- Organization knowledge

**Recommendation:** **Skills (Organization Marketplace)**

**Examples:**
- Company coding standards
- Security review guidelines
- Architecture patterns
- Compliance requirements

**Distribution:** Internal marketplace

---

### Product Feature (Score: 10)
**Characteristics:**
- End-user facing
- Production deployment
- Product differentiation
- Revenue impact

**Recommendation:** **SDK Primitives**

**Examples:**
- AI-powered product feature
- Customer-facing automation
- Production workflow
- SaaS feature

**Implementation:** Custom SDK integration

---

## 3. Context Management Needs

### Minimal Context (Score: 1-3)
**Characteristics:**
- Self-contained task
- No external references
- All info in prompt
- < 1000 tokens

**Recommendation:** **Direct Prompts**

**Example:**
```
Explain this function:
[paste function]
```

---

### Structured Context (Score: 4-6)
**Characteristics:**
- Reference materials needed
- Organized information
- Progressive disclosure beneficial
- 1K-10K tokens

**Recommendation:** **Skills with Progressive Disclosure**

**Example:**
```
skill/
├── SKILL.md
└── references/
    ├── quick_reference.md (loaded first)
    ├── detailed_patterns.md (loaded on demand)
    └── examples.md (loaded when needed)
```

**Pattern:**
- Start with minimal context
- Load more as needed
- Query-based retrieval

---

### Isolated Context (Score: 7-9)
**Characteristics:**
- Separate concerns
- Avoid context pollution
- Parallel execution
- Different contexts per phase
- 10K+ tokens per context

**Recommendation:** **Agents/Subagents**

**Example:**
```
Explore Agent: Codebase context (read-only)
Plan Agent: Planning context (insights from explore)
Code Agent: Implementation context (plan + target files)
Review Agent: Validation context (changes + tests)
```

**Benefits:**
- No context pollution
- Clear boundaries
- Parallel execution
- Optimal token usage

---

### Custom Context (Score: 10)
**Characteristics:**
- Specific context handling
- Integration requirements
- Custom context sources
- Dynamic context loading

**Recommendation:** **SDK Primitives**

**Example:**
```typescript
const context = await customContextLoader({
  source: proprietarySystem,
  filter: taskSpecific,
  transform: domainFormat
});
```

---

## 4. Security & Control Requirements

### Basic Safety (Score: 1-3)
**Characteristics:**
- Read-only operations
- No sensitive data
- Standard guardrails sufficient
- Low risk

**Recommendation:** **Direct Prompts + Skills**

**Controls:**
- Standard Claude safety features
- No additional restrictions needed

---

### Controlled Access (Score: 4-6)
**Characteristics:**
- Write operations
- Specific tool permissions needed
- Some sensitive operations
- Medium risk

**Recommendation:** **Agents with Tool Restrictions**

**Controls:**
```typescript
Explore Agent: [Read, Grep, Glob]  // Read-only
Plan Agent: [TodoWrite]             // Planning only
Code Agent: [Read, Edit, Write]     // Code changes
Review Agent: [Bash, Read]          // Testing
```

**Pattern:**
- Allowlist approach
- Minimal permissions
- Explicit grants

---

### High Security (Score: 7-9)
**Characteristics:**
- Sensitive operations
- Compliance requirements
- Audit logging needed
- High risk

**Recommendation:** **Agents with Confirmations**

**Controls:**
```typescript
Agent {
  tools: allowlistOnly,
  confirmations: [
    'git push',
    'deployment',
    'data deletion',
    'sensitive operations'
  ],
  audit: true,
  denylist: dangerousCommands
}
```

**Pattern:**
- Deny-all default
- Explicit confirmations
- Audit all operations
- Block dangerous commands

---

### Maximum Security (Score: 10)
**Characteristics:**
- Production systems
- Financial/medical data
- Regulatory compliance
- Critical infrastructure

**Recommendation:** **SDK Primitives + Custom Security**

**Controls:**
```typescript
const secureAgent = new Agent({
  security: {
    denyAll: true,
    allowlist: minimalTools,
    mfa: true,
    audit: comprehensiveLogger,
    encryption: true,
    rateLimits: strict,
    monitoring: realtime,
    rollback: automatic
  }
});
```

---

## 5. Performance Needs

### Standard Performance (Score: 1-3)
**Characteristics:**
- User can wait
- Not time-sensitive
- Occasional use

**Recommendation:** **Any approach**

---

### Fast Response (Score: 4-6)
**Characteristics:**
- Quick feedback expected
- Interactive use
- Multiple requests

**Recommendation:** **Skills with Progressive Disclosure**

**Optimization:**
- Load minimal context initially
- Query additional info on demand
- Cache frequent queries

---

### High Performance (Score: 7-9)
**Characteristics:**
- Real-time or near real-time
- Parallel execution beneficial
- Resource optimization critical

**Recommendation:** **Agents (Parallel Execution)**

**Optimization:**
```
Parallel Subagents:
├── Agent 1: File 1-10
├── Agent 2: File 11-20
├── Agent 3: File 21-30
└── Agent 4: Aggregation

Execution: All run simultaneously
```

---

### Maximum Performance (Score: 10)
**Characteristics:**
- Production SLA requirements
- Sub-second responses
- High throughput
- Resource limits

**Recommendation:** **SDK Primitives + Custom Optimization**

**Optimization:**
```typescript
const optimizedAgent = new Agent({
  caching: aggressive,
  parallelization: maximum,
  contextCompression: true,
  earlyTermination: true,
  resourceLimits: optimized
});
```

---

## 6. Maintenance Burden

### Low Maintenance (Score: 1-3)
**Characteristics:**
- Set and forget
- Stable requirements
- Minimal updates

**Recommendation:** **Direct Prompts (no maintenance)**

---

### Medium Maintenance (Score: 4-6)
**Characteristics:**
- Periodic updates
- Evolving patterns
- Team contributions

**Recommendation:** **Skills (easy to update)**

**Maintenance:**
- Update reference docs
- Add new examples
- Version control friendly
- Clear documentation

---

### High Maintenance (Score: 7-9)
**Characteristics:**
- Regular updates
- Multiple contributors
- Evolving requirements

**Recommendation:** **Skills + Version Control**

**Maintenance:**
```
skill/
├── CHANGELOG.md
├── VERSION
├── SKILL.md
└── references/
    └── (versioned docs)
```

---

### Custom Maintenance (Score: 10)
**Characteristics:**
- Custom codebase
- Breaking changes
- Integration updates
- Production support

**Recommendation:** **SDK Primitives (with CI/CD)**

**Maintenance:**
```typescript
// Automated testing
// Version management
// Deployment pipeline
// Monitoring and alerts
```

---

## 7. Time to Market

### Immediate (Score: 1-3)
**Characteristics:**
- Need it now
- No setup time
- Quick win

**Recommendation:** **Direct Prompts**

**Time:** Seconds to minutes

---

### Quick (Score: 4-6)
**Characteristics:**
- Hours to days
- Some setup acceptable
- Reusability valuable

**Recommendation:** **Skills**

**Time:** 1-4 hours to create

---

### Planned (Score: 7-9)
**Characteristics:**
- Days to weeks
- Proper planning
- Complex requirements

**Recommendation:** **Agents/Subagents**

**Time:** 1-3 days to design and implement

---

### Strategic (Score: 10)
**Characteristics:**
- Weeks to months
- Product feature
- Full development cycle

**Recommendation:** **SDK Primitives**

**Time:** 1+ weeks to build and deploy

---

## Decision Matrix

### Quick Reference Table

| Dimension | Prompts | Skills | Agents | SDK |
|-----------|---------|--------|--------|-----|
| **Complexity** | Low (1-3) | Medium (4-6) | High (7-9) | Custom (10) |
| **Reusability** | Single (1-2) | Team (5-7) | Org (8-9) | Product (10) |
| **Context** | Minimal (1-3) | Structured (4-6) | Isolated (7-9) | Custom (10) |
| **Security** | Basic (1-3) | Controlled (4-6) | High (7-9) | Max (10) |
| **Performance** | Standard (1-3) | Fast (4-6) | High (7-9) | Max (10) |
| **Maintenance** | Low (1-3) | Medium (4-6) | High (7-9) | Custom (10) |
| **Time to Market** | Immediate (1-3) | Quick (4-6) | Planned (7-9) | Strategic (10) |

---

## Scoring Your Project

### Step 1: Score Each Dimension
Rate your project on each of the 7 dimensions (1-10).

### Step 2: Calculate Weighted Average
Different dimensions may have different importance for your use case.

**Default Weights:**
- Task Complexity: 25%
- Reusability: 20%
- Context Management: 15%
- Security: 15%
- Performance: 10%
- Maintenance: 10%
- Time to Market: 5%

### Step 3: Interpret Score

**Average Score 1-3:** Direct Prompts
- Simple, clear instructions
- No additional structure

**Average Score 4-6:** Skills
- Organized expertise
- Progressive disclosure
- Reference materials

**Average Score 7-9:** Agents/Subagents
- Complex workflows
- Isolated contexts
- Parallel execution

**Average Score 10:** SDK Primitives
- Custom implementation
- Full control
- Production deployment

---

## Special Cases

### Hybrid Architectures
**When:** Scores span multiple ranges

**Solution:** Combine approaches
- Direct Prompts for simple tasks
- Skills for reusable expertise
- Agents for complex workflows

**Example:**
```
Project with scores:
- Complexity: 7 (Agents)
- Reusability: 5 (Skills)
- Context: 4 (Skills)
- Security: 6 (Skills/Agents)

Recommendation: Agents + Skills
- Use Agents for complex workflows
- Load Skills for domain expertise
- Direct Prompts for simple operations
```

---

## Decision Tree

```
Start
│
├─ Is it a simple, one-time task?
│  └─ YES → Direct Prompts
│  └─ NO → Continue
│
├─ Do you need reusable expertise?
│  └─ YES → Continue
│  └─ NO → Continue
│     │
│     ├─ Is it complex with multiple phases?
│     │  └─ YES → Agents
│     │  └─ NO → Direct Prompts
│
├─ Is it complex with isolated contexts needed?
│  └─ YES → Agents
│  └─ NO → Skills
│
├─ Is it a production feature or unique workflow?
│  └─ YES → SDK Primitives
│  └─ NO → Agents or Skills
│
└─ Default → Skills (best balance)
```

---

## Example Evaluations

### Example 1: Code Review Automation

**Scores:**
- Complexity: 5 (structured workflow)
- Reusability: 7 (team-wide)
- Context: 5 (reference materials)
- Security: 4 (read operations)
- Performance: 5 (interactive)
- Maintenance: 6 (evolving standards)
- Time to Market: 5 (hours to setup)

**Average:** 5.3

**Recommendation:** **Skills**
- Create code-review skill
- Include team standards
- Progressive disclosure of guidelines
- Reference materials for patterns

---

### Example 2: Codebase Migration

**Scores:**
- Complexity: 9 (multi-phase, autonomous)
- Reusability: 3 (one-time migration)
- Context: 8 (isolated per phase)
- Security: 7 (write operations)
- Performance: 8 (parallel execution)
- Maintenance: 3 (temporary)
- Time to Market: 7 (proper planning)

**Average:** 6.4

**Recommendation:** **Agents**
- Despite low reusability, complexity demands Agents
- Explore Agent: Analyze codebase
- Plan Agent: Create migration strategy
- Migrate Agent: Execute changes
- Validate Agent: Run tests

---

### Example 3: Quick Bug Fix

**Scores:**
- Complexity: 2 (single fix)
- Reusability: 1 (one-time)
- Context: 2 (minimal)
- Security: 3 (single file change)
- Performance: 2 (can wait)
- Maintenance: 1 (no maintenance)
- Time to Market: 1 (immediate)

**Average:** 1.7

**Recommendation:** **Direct Prompt**
- Simple instruction
- Fast execution
- No overhead

---

### Example 4: AI-Powered Product Feature

**Scores:**
- Complexity: 10 (custom workflow)
- Reusability: 10 (product feature)
- Context: 10 (custom handling)
- Security: 9 (production)
- Performance: 9 (SLA requirements)
- Maintenance: 10 (ongoing support)
- Time to Market: 10 (strategic)

**Average:** 9.7

**Recommendation:** **SDK Primitives**
- Custom agent implementation
- Production-grade security
- Full monitoring and controls
- Integration with product

---

## Summary

Use this rubric to:
1. **Score** your project on 7 dimensions
2. **Calculate** weighted average
3. **Interpret** score to get recommendation
4. **Validate** with decision tree
5. **Review** example evaluations

**Key Principle:** Start simple, scale complexity as needed.

**Remember:** The best architecture is the simplest one that meets your requirements.
