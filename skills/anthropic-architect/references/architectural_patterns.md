# Architectural Patterns

Comprehensive catalog of proven Anthropic architecture patterns for common use cases.

## Table of Contents

1. [Skills-First Patterns](#skills-first-patterns)
2. [Agent-Based Patterns](#agent-based-patterns)
3. [Hybrid Patterns](#hybrid-patterns)
4. [SDK Custom Patterns](#sdk-custom-patterns)
5. [Progressive Disclosure Patterns](#progressive-disclosure-patterns)
6. [Security Patterns](#security-patterns)

---

## Skills-First Patterns

### Pattern 1: Domain Expert Skill

**When to use:**
- Specialized domain knowledge needed
- Team-wide expertise sharing
- Consistent application of patterns

**Structure:**
```
domain-expert-skill/
├── SKILL.md
├── references/
│   ├── core_concepts.md
│   ├── patterns/
│   │   ├── pattern_1.md
│   │   ├── pattern_2.md
│   │   └── pattern_3.md
│   ├── best_practices.md
│   └── examples/
│       ├── example_1.md
│       └── example_2.md
└── scripts/
    └── validate.sh
```

**Example: Security Expert Skill**
```
security-expert/
├── SKILL.md
├── references/
│   ├── owasp_top_10.md
│   ├── patterns/
│   │   ├── authentication.md
│   │   ├── authorization.md
│   │   ├── encryption.md
│   │   └── input_validation.md
│   ├── threat_models.md
│   └── examples/
│       ├── secure_api.md
│       └── secure_storage.md
└── scripts/
    └── security_audit.sh
```

**Usage:**
```
Using the security-expert skill, review this authentication flow
for vulnerabilities following OWASP guidelines.
```

**Benefits:**
- Centralized expertise
- Consistent security reviews
- Team knowledge sharing
- Progressive disclosure of security patterns

---

### Pattern 2: Workflow Automation Skill

**When to use:**
- Repeatable multi-step workflows
- Team-wide process standardization
- Interactive script execution

**Structure:**
```
workflow-automation-skill/
├── SKILL.md
├── workflows/
│   ├── workflow_1.md
│   ├── workflow_2.md
│   └── workflow_3.md
├── scripts/
│   ├── step_1.sh
│   ├── step_2.sh
│   └── orchestrate.sh
└── templates/
    ├── template_1.md
    └── template_2.md
```

**Example: Release Management Skill**
```
release-management/
├── SKILL.md
├── workflows/
│   ├── version_bump.md
│   ├── changelog_generation.md
│   ├── deployment.md
│   └── rollback.md
├── scripts/
│   ├── bump_version.sh
│   ├── generate_changelog.sh
│   ├── deploy.sh
│   └── release.sh (orchestrator)
└── templates/
    ├── changelog_template.md
    └── release_notes.md
```

**Usage:**
```
Using the release-management skill, prepare a new release:
- Bump version to 2.1.0
- Generate changelog from commits
- Create release notes
```

**Benefits:**
- Standardized processes
- Reduced errors
- Faster execution
- Team consistency

---

### Pattern 3: Progressive Disclosure Skill

**When to use:**
- Large knowledge base
- Context limits are concern
- Query-based information retrieval

**Structure:**
```
progressive-skill/
├── SKILL.md
├── query_tool.sh
├── index.md (high-level navigation)
├── expertise/
│   ├── by_task/
│   │   ├── task_1.md
│   │   └── task_2.md
│   ├── by_category/
│   │   ├── category_1.md
│   │   └── category_2.md
│   └── quick_reference/
│       └── cheat_sheet.md
└── examples/
    └── contextualized_examples.md
```

**Example: API Design Skill**
```
api-design-expert/
├── SKILL.md
├── query_expertise.sh
├── index.md
├── expertise/
│   ├── by_task/
│   │   ├── rest_api.md
│   │   ├── graphql.md
│   │   └── webhooks.md
│   ├── by_concern/
│   │   ├── authentication.md
│   │   ├── rate_limiting.md
│   │   ├── versioning.md
│   │   └── documentation.md
│   └── quick_reference/
│       ├── http_methods.md
│       └── status_codes.md
└── examples/
    └── real_world_apis.md
```

**Usage:**
```
Using api-design-expert, show me best practices for:
- RESTful resource design
- Authentication and authorization
- Rate limiting strategy
```

**Query Flow:**
1. Agent loads index.md (high-level)
2. Agent identifies relevant task: "rest_api.md"
3. Skill provides only REST API patterns
4. If auth needed, loads authentication.md
5. Progressive disclosure of information

**Benefits:**
- Minimal context usage
- Fast responses
- Scalable knowledge base
- Efficient token consumption

---

## Agent-Based Patterns

### Pattern 4: Multi-Phase Agent Pipeline

**When to use:**
- Complex workflows with distinct phases
- Different tool permissions per phase
- Isolated contexts beneficial

**Structure:**
```
Main Agent (orchestrator)
│
├── Phase 1: Explore Agent
│   Tools: [Read, Grep, Glob]
│   Context: Codebase exploration
│   Output: Insights, patterns, structure
│
├── Phase 2: Plan Agent
│   Tools: [TodoWrite]
│   Context: Insights from Phase 1
│   Output: Detailed plan
│
├── Phase 3: Execute Agent
│   Tools: [Read, Edit, Write]
│   Context: Plan + target files
│   Output: Code changes
│
└── Phase 4: Validate Agent
    Tools: [Bash, Read]
    Context: Changes + tests
    Output: Validation results
```

**Example: Feature Implementation**
```
Feature Implementation Pipeline

1. Explore Agent
   - Analyze existing codebase
   - Find related code patterns
   - Identify integration points
   → Output: Architecture analysis

2. Design Agent
   - Review analysis
   - Create detailed design
   - Plan file changes
   → Output: Implementation plan

3. Code Agent
   - Implement feature
   - Follow design plan
   - Write tests
   → Output: Code changes

4. Review Agent
   - Run tests
   - Check coverage
   - Validate functionality
   → Output: Pass/fail + feedback

5. Main Agent
   - Aggregate results
   - Report to user
   - Handle iterations
```

**Usage:**
```
Implement a new user authentication feature:
1. Analyze current auth system
2. Design JWT-based auth
3. Implement changes
4. Validate with tests
```

**Benefits:**
- Clear phase separation
- Minimal permissions per phase
- Isolated contexts (no pollution)
- Parallel execution possible
- Easy to debug and iterate

---

### Pattern 5: Parallel Agent Execution

**When to use:**
- Independent tasks that can run simultaneously
- Large codebases or datasets
- Time-sensitive operations

**Structure:**
```
Coordinator Agent
│
├─┬─ Worker Agent 1: Task Subset 1
│ │
│ ├─ Worker Agent 2: Task Subset 2
│ │
│ ├─ Worker Agent 3: Task Subset 3
│ │
│ └─ Worker Agent 4: Task Subset 4
│
└── Aggregator Agent: Combine Results
```

**Example: Codebase Analysis**
```
Analysis Coordinator
│
├─┬─ Analyze Agent 1: /src/components/
│ │  → Component patterns
│ │
│ ├─ Analyze Agent 2: /src/services/
│ │  → Service patterns
│ │
│ ├─ Analyze Agent 3: /src/utils/
│ │  → Utility patterns
│ │
│ └─ Analyze Agent 4: /tests/
│    → Test coverage
│
└── Aggregator Agent
    → Combined analysis report
```

**Usage:**
```
Analyze entire codebase for:
- Code patterns
- Test coverage
- Performance issues
- Security vulnerabilities

Execute in parallel for speed.
```

**Benefits:**
- Massive speedup (4x with 4 agents)
- Independent execution
- Resource optimization
- Scalable to large codebases

---

### Pattern 6: Specialist Agent Team

**When to use:**
- Different expertise areas needed
- Collaborative task execution
- Review and validation workflows

**Structure:**
```
Project Lead Agent (orchestrator)
│
├── Frontend Specialist Agent
│   Expertise: UI/UX, components, accessibility
│   Tools: Frontend-specific
│
├── Backend Specialist Agent
│   Expertise: APIs, databases, services
│   Tools: Backend-specific
│
├── DevOps Specialist Agent
│   Expertise: CI/CD, deployment, infrastructure
│   Tools: DevOps-specific
│
└── QA Specialist Agent
    Expertise: Testing, validation, quality
    Tools: Testing-specific
```

**Example: Full-Stack Feature**
```
Feature: Add user profile page

Project Lead Agent
│
├── Frontend Agent
│   - Create profile component
│   - Add routing
│   - Implement responsive design
│   Load: frontend-designer skill
│
├── Backend Agent
│   - Create profile API endpoint
│   - Add database queries
│   - Implement validation
│   Load: api-design-expert skill
│
├── DevOps Agent
│   - Update deployment config
│   - Add environment variables
│   - Configure monitoring
│   Load: devops-expert skill
│
└── QA Agent
    - Write integration tests
    - Validate end-to-end flow
    - Check accessibility
    Load: qa-test-planner skill
```

**Usage:**
```
Implement user profile feature across the stack:
- Frontend: Profile page with edit capability
- Backend: CRUD API for profile data
- DevOps: Deploy to staging
- QA: Full test coverage
```

**Benefits:**
- Specialized expertise
- Parallel execution
- Skills loading per specialist
- Clear ownership
- Comprehensive coverage

---

## Hybrid Patterns

### Pattern 7: Agents + Skills Hybrid

**When to use:**
- Complex workflows needing domain expertise
- Reusable knowledge + autonomous execution
- Best of both approaches

**Structure:**
```
Agent Workflow
│
├── Explore Agent
│   Loads: codebase-analysis-skill
│   Expertise: Pattern recognition
│   Tools: [Read, Grep, Glob]
│
├── Plan Agent
│   Loads: architecture-patterns-skill
│   Expertise: Design patterns
│   Tools: [TodoWrite]
│
└── Execute Agent
    Loads: coding-standards-skill
    Expertise: Team conventions
    Tools: [Read, Edit, Write]
```

**Example: Refactoring Pipeline**
```
Refactoring Workflow

1. Analysis Agent
   Load: code-quality-skill
   - Identify code smells
   - Find duplication
   - Analyze complexity
   Use skill's: anti-patterns reference

2. Planning Agent
   Load: refactoring-patterns-skill
   - Choose refactoring patterns
   - Plan step-by-step changes
   - Estimate risk
   Use skill's: safe refactoring strategies

3. Execution Agent
   Load: team-coding-standards-skill
   - Apply refactorings
   - Follow team style
   - Maintain tests
   Use skill's: style guide and examples

4. Validation Agent
   Load: testing-strategies-skill
   - Run test suite
   - Check coverage
   - Verify behavior
   Use skill's: test validation patterns
```

**Usage:**
```
Refactor the UserService class:
- Load relevant skills for expertise
- Use agents for autonomous execution
- Progressive disclosure of skill knowledge
- Isolated contexts per phase
```

**Benefits:**
- Reusable expertise (skills)
- Autonomous execution (agents)
- Progressive disclosure
- Isolated contexts
- Best of both worlds

---

### Pattern 8: Prompts + Skills Fallback

**When to use:**
- Start simple, escalate complexity
- Most tasks simple, some complex
- Cost optimization

**Structure:**
```
Task Router
│
├── Simple task? → Direct Prompt
│
├── Needs expertise? → Load Skill
│   └── Still simple? → Skill + Prompt
│   └── Complex? → Skill + Agent
│
└── Very complex? → Agents + Skills
```

**Example: Code Review System**
```
Code Review Router

1. Check complexity
   - Small PR (< 50 lines)? → Direct Prompt
     "Review this PR for basic issues"

   - Medium PR (50-500 lines)? → Load Skill
     Using code-review-skill, review this PR
     Skill provides: checklist, patterns

   - Large PR (> 500 lines)? → Agent + Skill
     Review Agent loads code-review-skill
     - Explore codebase context
     - Apply review checklist
     - Generate comprehensive review
```

**Benefits:**
- Cost-effective (simple → cheap)
- Scalable (complex → powerful)
- Flexible (adapts to task)
- Progressive enhancement

---

## SDK Custom Patterns

### Pattern 9: Custom Tool Integration

**When to use:**
- Integration with proprietary systems
- Custom tools needed
- Domain-specific operations

**Structure:**
```typescript
import { Agent, Tool } from 'claude-agent-sdk';

// Define custom tool
const customTool: Tool = {
  name: 'custom-tool',
  description: 'Interacts with proprietary system',
  execute: async (params) => {
    // Custom implementation
    return await proprietarySystem.call(params);
  }
};

// Create agent with custom tool
const agent = new Agent({
  tools: [customTool, ...standardTools],
  systemPrompt: 'You are an expert with custom-system access'
});
```

**Example: CRM Integration Agent**
```typescript
// Custom CRM tools
const getCRMData: Tool = {
  name: 'get-crm-data',
  description: 'Fetch customer data from CRM',
  execute: async ({ customerId }) => {
    return await crmAPI.getCustomer(customerId);
  }
};

const updateCRMData: Tool = {
  name: 'update-crm-data',
  description: 'Update customer data in CRM',
  execute: async ({ customerId, data }) => {
    return await crmAPI.updateCustomer(customerId, data);
  }
};

// Agent with CRM access
const crmAgent = new Agent({
  tools: [getCRMData, updateCRMData],
  systemPrompt: `You are a CRM assistant with access to customer data.
    Help users query and update customer information.`
});
```

**Usage:**
```typescript
const response = await crmAgent.run({
  task: 'Get customer data for customer ID 12345 and update their email'
});
```

**Benefits:**
- Direct system integration
- Custom business logic
- Proprietary data access
- Fine-grained control

---

### Pattern 10: Custom Feedback Loop

**When to use:**
- Specific workflow requirements
- Unique validation logic
- Custom iteration patterns

**Structure:**
```typescript
const customWorkflow = async (task: Task) => {
  let result;
  let iterations = 0;
  const maxIterations = 5;

  while (iterations < maxIterations) {
    // Step 1: Generate
    result = await agent.generate(task);

    // Step 2: Custom validation
    const validation = await customValidator(result);

    // Step 3: Custom decision
    if (validation.passed) {
      break; // Success
    }

    // Step 4: Custom feedback
    task = customFeedback(task, validation.issues);
    iterations++;
  }

  return result;
};
```

**Example: Code Generation with Custom Linter**
```typescript
const codeGenerationWorkflow = async (spec: Specification) => {
  let code;
  let attempt = 0;

  while (attempt < 3) {
    // Generate code
    code = await codeAgent.generate(spec);

    // Custom linter validation
    const lintResults = await customLinter.check(code);

    if (lintResults.errors.length === 0) {
      // Passed linting
      break;
    }

    // Custom feedback loop
    spec = addLintingFeedback(spec, lintResults.errors);
    attempt++;
  }

  // Custom post-processing
  code = await customFormatter.format(code);

  return code;
};
```

**Benefits:**
- Custom validation logic
- Specific iteration patterns
- Business rule enforcement
- Unique workflows

---

## Progressive Disclosure Patterns

### Pattern 11: Query-Based Disclosure

**When to use:**
- Large knowledge bases
- Context optimization critical
- Task-specific information needed

**Structure:**
```
skill/
├── SKILL.md (high-level overview)
├── query.sh (interactive query tool)
├── index.md (navigation)
└── content/
    ├── topic_1/
    │   ├── overview.md (loaded first)
    │   ├── detailed.md (on demand)
    │   └── examples.md (when requested)
    └── topic_2/
        ├── overview.md
        ├── detailed.md
        └── examples.md
```

**Query Pattern:**
```bash
# User queries skill
"Using skill, how do I implement authentication?"

# Skill loading strategy
1. Load: index.md (< 500 tokens)
   → Find relevant topic: authentication
2. Load: authentication/overview.md (< 1000 tokens)
   → Provides high-level guidance
3. If user needs more:
   Load: authentication/detailed.md
   → In-depth patterns
4. If user wants examples:
   Load: authentication/examples.md
   → Real code samples
```

**Benefits:**
- Minimal initial context
- Load more as needed
- Efficient token usage
- Fast initial response

---

### Pattern 12: Hierarchical Disclosure

**When to use:**
- Complex topics with depth
- Progressive learning needed
- Multiple expertise levels

**Structure:**
```
skill/
├── level_1_basics/
│   └── (fundamental concepts)
├── level_2_intermediate/
│   └── (common patterns)
├── level_3_advanced/
│   └── (complex techniques)
└── level_4_expert/
    └── (edge cases, optimization)
```

**Disclosure Flow:**
```
User: "Help me with caching"

Skill responds:
├─ Level 1: Basic caching concepts
│  User: "I know basics, show me patterns"
│
├─ Level 2: Common caching patterns
│  User: "Show me advanced optimization"
│
├─ Level 3: Cache optimization techniques
│  User: "What about distributed caching?"
│
└─ Level 4: Distributed caching strategies
```

**Benefits:**
- Tailored to user expertise
- Prevents overwhelming
- Progressive depth
- Efficient learning

---

## Security Patterns

### Pattern 13: Allowlist Security Pattern

**When to use:**
- Sensitive operations
- Controlled tool access
- Security-critical applications

**Structure:**
```typescript
const secureAgent = new Agent({
  tools: allowlistOnly([
    'Read',      // Safe: read-only
    'Grep',      // Safe: read-only
    'Glob',      // Safe: read-only
  ]),
  denylist: [
    'rm -rf',
    'sudo',
    'curl',      // Could leak data
    'wget',      // Could leak data
  ],
  confirmations: [
    'git push',
    'deployment',
    'data deletion'
  ]
});
```

**Example: Production Agent**
```typescript
const productionAgent = new Agent({
  name: 'production-agent',

  // Minimal permissions
  tools: [
    'Read',          // View configs
    'Grep',          // Search logs
  ],

  // Block dangerous operations
  denylist: [
    'rm',
    'delete',
    'drop',
    'truncate',
    'sudo',
    'chmod',
    'exec'
  ],

  // Require confirmation
  confirmations: [
    'restart service',
    'change config',
    'modify database'
  ],

  // Audit all operations
  audit: {
    enabled: true,
    logLevel: 'verbose',
    destination: 'security-log'
  }
});
```

**Benefits:**
- Deny-all default
- Explicit permissions
- Confirmations for sensitive ops
- Full audit trail

---

### Pattern 14: Defense in Depth

**When to use:**
- High security requirements
- Multiple security layers needed
- Critical systems

**Structure:**
```
Security Layers:

Layer 1: Tool Allowlist
  → Only approved tools

Layer 2: Command Validation
  → Validate command safety

Layer 3: Confirmation Required
  → Human approval for sensitive ops

Layer 4: Sandbox Execution
  → Isolated environment

Layer 5: Audit Logging
  → Full operation trail

Layer 6: Rollback Capability
  → Undo mechanism
```

**Example: Financial System Agent**
```typescript
const financialAgent = new Agent({
  // Layer 1: Tool Allowlist
  tools: allowlistOnly(['Read', 'Grep']),

  // Layer 2: Command Validation
  preExecute: async (command) => {
    return await securityValidator.validate(command);
  },

  // Layer 3: Confirmation Required
  confirmations: 'all',

  // Layer 4: Sandbox
  sandbox: {
    enabled: true,
    isolated: true,
    networkBlocked: true
  },

  // Layer 5: Audit
  audit: {
    enabled: true,
    level: 'detailed',
    retention: '7years',
    immutable: true
  },

  // Layer 6: Rollback
  rollback: {
    enabled: true,
    autoSnapshot: true,
    quickRevert: true
  }
});
```

**Benefits:**
- Multiple security layers
- Defense against various threats
- Compliance ready
- Maximum security

---

## Summary

Choose patterns based on your requirements:

**Simple Tasks:** Direct Prompts
**Reusable Expertise:** Skills (Patterns 1-3)
**Complex Workflows:** Agents (Patterns 4-6)
**Best of Both:** Hybrid (Patterns 7-8)
**Custom Needs:** SDK (Patterns 9-10)
**Large Knowledge:** Progressive Disclosure (Patterns 11-12)
**Security Critical:** Security Patterns (Patterns 13-14)

**Key Principle:** Start simple, add complexity only when needed.
