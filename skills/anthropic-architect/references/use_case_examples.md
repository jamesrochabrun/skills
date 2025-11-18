# Real-World Use Case Examples

Comprehensive examples of Anthropic architectures for common use cases, with detailed implementation guidance.

## Table of Contents

1. [Code Quality & Review](#code-quality--review)
2. [Feature Development](#feature-development)
3. [Documentation](#documentation)
4. [Testing & QA](#testing--qa)
5. [Refactoring & Modernization](#refactoring--modernization)
6. [Security & Compliance](#security--compliance)
7. [DevOps & Automation](#devops--automation)
8. [Data Analysis](#data-analysis)
9. [Customer Support](#customer-support)
10. [Content Generation](#content-generation)

---

## Code Quality & Review

### Use Case 1: Automated Code Review System

**Requirements:**
- Review all PRs automatically
- Check coding standards
- Identify security issues
- Suggest improvements
- Team-wide consistency

**Complexity Analysis:**
- Task Complexity: 6 (structured workflow)
- Reusability: 8 (organization-wide)
- Context: 5 (needs coding standards)
- Security: 5 (read operations)

**Recommended Architecture:** **Skills + Direct Prompts**

**Implementation:**

**1. Create code-review-expert skill:**
```
code-review-expert/
├── SKILL.md
├── references/
│   ├── coding_standards.md
│   ├── security_patterns.md
│   ├── performance_guidelines.md
│   └── review_checklist.md
└── scripts/
    └── review_pr.sh
```

**2. Usage for PRs:**
```
Simple PR (< 50 lines):
  → Direct Prompt
  "Using code-review-expert skill, review PR #123"

Complex PR (> 500 lines):
  → Agent + Skill
  Review Agent:
    - Load code-review-expert skill
    - Analyze all changed files
    - Generate comprehensive review
```

**3. coding_standards.md:**
```markdown
# Team Coding Standards

## TypeScript
- Use strict mode
- Explicit return types
- No `any` types
- Prefer const over let
- 100 character line limit

## Patterns
- Repository pattern for data access
- Dependency injection for services
- Factory pattern for object creation

## Security
- Validate all inputs
- Sanitize user data
- Use parameterized queries
- Never log sensitive data
```

**4. Review Workflow:**
```bash
#!/bin/bash
# review_pr.sh

PR_NUMBER=$1

echo "Reviewing PR #$PR_NUMBER..."

# Get PR diff
gh pr diff $PR_NUMBER > /tmp/pr_diff.txt

# Review with Claude + skill
claude "Using code-review-expert skill, review this PR:

Changes:
$(cat /tmp/pr_diff.txt)

Check for:
1. Coding standards compliance
2. Security vulnerabilities
3. Performance issues
4. Best practices adherence
5. Test coverage

Format: Provide detailed review with specific line numbers and suggestions."
```

**Benefits:**
- Consistent reviews
- Team standards enforced
- Reusable across all PRs
- Fast feedback

**Metrics:**
- Review time: 2-5 minutes
- Coverage: 100% of PRs
- False positives: < 5%
- Developer satisfaction: High

---

### Use Case 2: Code Quality Dashboard

**Requirements:**
- Analyze entire codebase
- Track metrics over time
- Identify problem areas
- Generate reports

**Recommended Architecture:** **Parallel Agents**

**Implementation:**

```
Quality Dashboard Workflow

Coordinator Agent
│
├─┬─ Complexity Agent → Analyze code complexity
│ │
│ ├─ Coverage Agent → Check test coverage
│ │
│ ├─ Security Agent → Find vulnerabilities
│ │
│ └─ Duplication Agent → Detect code duplication
│
└─→ Dashboard Agent → Generate visual report

All agents run in parallel → 4x faster
```

**Code:**
```typescript
// Launch parallel agents
const [
  complexityReport,
  coverageReport,
  securityReport,
  duplicationReport
] = await Promise.all([
  analyzeComplexity(codebase),
  analyzeCoverage(codebase),
  analyzeSecurity(codebase),
  analyzeDuplication(codebase)
]);

// Aggregate results
const dashboard = generateDashboard({
  complexity: complexityReport,
  coverage: coverageReport,
  security: securityReport,
  duplication: duplicationReport
});
```

---

## Feature Development

### Use Case 3: Full-Stack Feature Implementation

**Requirements:**
- Implement user authentication
- Frontend + Backend + Database
- Tests and documentation
- Deploy to staging

**Recommended Architecture:** **Specialist Agent Team + Skills**

**Implementation:**

```
Project Lead Agent
│
├── Frontend Agent
│   Load: frontend-designer-skill
│   Tasks:
│   - Create login/signup components
│   - Add form validation
│   - Implement token storage
│   - Add loading states
│
├── Backend Agent
│   Load: api-design-expert-skill
│   Tasks:
│   - Create auth endpoints
│   - Implement JWT generation
│   - Add refresh token logic
│   - Database queries
│
├── Database Agent
│   Load: database-expert-skill
│   Tasks:
│   - Design user schema
│   - Create migrations
│   - Add indexes
│   - Seed test data
│
├── Testing Agent
│   Load: testing-strategies-skill
│   Tasks:
│   - Unit tests
│   - Integration tests
│   - E2E tests
│   - Coverage reports
│
└── DevOps Agent
    Load: deployment-expert-skill
    Tasks:
    - Update configs
    - Deploy to staging
    - Run smoke tests
    - Monitor deployment
```

**Execution:**
```
Phase 1: Planning (Sequential)
  Lead Agent creates detailed plan

Phase 2: Implementation (Parallel)
  All specialist agents work simultaneously
  - Frontend: 15 minutes
  - Backend: 15 minutes
  - Database: 10 minutes
  - Tests: 20 minutes
  Total: 20 minutes (vs 70 minutes sequential)

Phase 3: Integration (Sequential)
  Lead Agent coordinates integration

Phase 4: Deployment (Sequential)
  DevOps Agent deploys to staging
```

**Benefits:**
- Parallel execution (70% faster)
- Specialized expertise per layer
- Comprehensive test coverage
- Automated deployment

---

### Use Case 4: Feature Flag System

**Requirements:**
- Add feature flag capability
- Minimal risk implementation
- Gradual rollout support
- Analytics integration

**Recommended Architecture:** **Skills + Multi-Phase Agents**

**Implementation:**

```
Phase 1: Exploration Agent
  Tools: [Read, Grep, Glob]
  Load: architecture-patterns-skill
  Task:
    - Analyze current architecture
    - Identify integration points
    - Research feature flag patterns
    - Assess risk areas

Phase 2: Design Agent
  Tools: [TodoWrite]
  Load: system-design-skill
  Task:
    - Design feature flag service
    - Plan database schema
    - Define API contracts
    - Create rollout strategy

Phase 3: Implementation Agent
  Tools: [Read, Edit, Write]
  Load: coding-standards-skill
  Task:
    - Implement feature flag service
    - Add database migrations
    - Create admin UI
    - Write documentation

Phase 4: Testing Agent
  Tools: [Bash, Read]
  Load: testing-strategies-skill
  Task:
    - Unit tests
    - Integration tests
    - Load testing
    - Rollback testing

Phase 5: Deployment Agent
  Tools: [Bash]
  Load: deployment-patterns-skill
  Confirmations: ['deployment', 'database migration']
  Task:
    - Deploy to staging
    - Run validation tests
    - Deploy to production (10% users)
    - Monitor metrics
```

---

## Documentation

### Use Case 5: API Documentation Generator

**Requirements:**
- Generate API docs from code
- Include examples
- Keep docs in sync with code
- Multiple output formats

**Recommended Architecture:** **Skills**

**Implementation:**

```
api-documentation-skill/
├── SKILL.md
├── references/
│   ├── openapi_spec.md
│   ├── documentation_guidelines.md
│   └── example_formats.md
├── templates/
│   ├── endpoint_template.md
│   ├── schema_template.md
│   └── example_template.md
└── scripts/
    └── generate_docs.sh
```

**Usage:**
```
Using api-documentation-skill, generate complete API
documentation for all endpoints in src/api/

Include:
- OpenAPI spec
- Request/response examples
- Authentication details
- Error responses
- Rate limiting info

Format: Markdown with code examples
```

**Output:**
```markdown
# User API

## POST /api/users

Create a new user account.

### Request
```json
{
  "email": "user@example.com",
  "password": "SecurePass123!",
  "name": "John Doe"
}
```

### Response (201 Created)
```json
{
  "id": "usr_123",
  "email": "user@example.com",
  "name": "John Doe",
  "createdAt": "2025-01-15T10:30:00Z"
}
```

### Errors
- 400: Invalid email format
- 409: Email already exists
- 429: Rate limit exceeded
```

---

### Use Case 6: Onboarding Documentation

**Requirements:**
- Help new developers get started
- Multiple learning paths
- Interactive tutorials
- Up-to-date with codebase

**Recommended Architecture:** **Progressive Disclosure Skill**

**Implementation:**

```
onboarding-guide/
├── SKILL.md
├── index.md (learning paths)
├── getting_started/
│   ├── day_1.md
│   ├── day_2.md
│   └── week_1.md
├── by_role/
│   ├── frontend_dev.md
│   ├── backend_dev.md
│   └── fullstack_dev.md
├── by_topic/
│   ├── architecture.md
│   ├── deployment.md
│   └── testing.md
└── interactive/
    ├── setup_walkthrough.sh
    └── first_pr_guide.sh
```

**Progressive Disclosure:**
```
New developer: "I'm a frontend developer, where do I start?"

1. Load: index.md
   → Shows: Learning paths

2. Load: by_role/frontend_dev.md
   → Shows: Frontend-specific onboarding

3. Load: getting_started/day_1.md
   → Shows: Day 1 tasks

4. As they progress:
   → Load additional topics on demand
```

---

## Testing & QA

### Use Case 7: Comprehensive Test Suite Generator

**Requirements:**
- Generate tests for new features
- Multiple test types
- High coverage targets
- Integration with CI/CD

**Recommended Architecture:** **Agent + Skills**

**Implementation:**

```
Test Generation Agent
│
Load Skills:
├── testing-strategies-skill
└── code-analysis-skill

Workflow:
1. Analyze code to test
2. Identify test scenarios
3. Generate unit tests
4. Generate integration tests
5. Generate E2E tests
6. Verify coverage > 80%
```

**Example:**
```
Using testing-strategies-skill, generate comprehensive test suite
for UserService class:

Coverage requirements:
- Unit tests: 90%+
- Integration tests: All API endpoints
- E2E tests: Critical user flows

Test frameworks:
- Jest for unit/integration
- Playwright for E2E

Include:
- Happy paths
- Error cases
- Edge cases
- Security tests
```

**Generated Output:**
```typescript
// user-service.test.ts
describe('UserService', () => {
  describe('createUser', () => {
    it('should create user with valid data', async () => {
      // Test implementation
    });

    it('should reject invalid email', async () => {
      // Test implementation
    });

    it('should reject duplicate email', async () => {
      // Test implementation
    });

    it('should hash password', async () => {
      // Test implementation
    });
  });

  // ... more tests
});
```

---

### Use Case 8: Regression Test Suite Maintenance

**Requirements:**
- Keep tests up-to-date
- Remove obsolete tests
- Update for API changes
- Improve flaky tests

**Recommended Architecture:** **Multi-Phase Agents**

**Implementation:**

```
Phase 1: Analysis Agent
  - Identify failing tests
  - Find flaky tests
  - Detect obsolete tests
  - Check coverage gaps

Phase 2: Cleanup Agent
  - Remove obsolete tests
  - Update outdated assertions
  - Fix broken imports

Phase 3: Enhancement Agent
  - Improve flaky tests
  - Add missing test cases
  - Increase coverage

Phase 4: Validation Agent
  - Run full test suite
  - Verify improvements
  - Generate report
```

---

## Refactoring & Modernization

### Use Case 9: Legacy Code Modernization

**Requirements:**
- Upgrade from JavaScript to TypeScript
- Update deprecated APIs
- Improve code quality
- Maintain functionality

**Recommended Architecture:** **Multi-Phase Agents + Skills**

**Implementation:**

```
Modernization Pipeline

Phase 1: Assessment Agent
  Load: code-quality-skill
  - Analyze current codebase
  - Identify modernization opportunities
  - Assess risk levels
  - Create priority list

Phase 2: Planning Agent
  Load: refactoring-patterns-skill
  - Create detailed migration plan
  - Define phases and milestones
  - Identify dependencies
  - Plan rollback strategy

Phase 3: TypeScript Migration Agent
  Load: typescript-migration-skill
  - Convert .js to .ts
  - Add type definitions
  - Fix type errors
  - Update build config

Phase 4: API Update Agent
  Load: api-modernization-skill
  - Replace deprecated APIs
  - Update to new patterns
  - Modernize syntax
  - Optimize performance

Phase 5: Testing Agent
  Load: testing-strategies-skill
  - Run existing tests
  - Add new tests
  - Verify functionality
  - Check performance

Phase 6: Validation Agent
  - Compare behavior (before/after)
  - Run regression tests
  - Performance benchmarks
  - Generate migration report
```

**Safety Measures:**
```
- Git branch per phase
- Tests after each phase
- Rollback capability
- Progressive rollout
- Monitoring and alerts
```

---

### Use Case 10: Microservices Extraction

**Requirements:**
- Extract service from monolith
- Minimal downtime
- Data migration
- Gradual rollout

**Recommended Architecture:** **SDK Custom Workflow**

**Implementation:**

```typescript
const microserviceExtraction = {
  phases: [
    {
      name: 'Analysis',
      agent: analysisAgent,
      tasks: [
        'Identify service boundaries',
        'Map dependencies',
        'Plan data separation',
        'Design API contracts'
      ]
    },
    {
      name: 'Preparation',
      agent: prepAgent,
      tasks: [
        'Create new service structure',
        'Set up database',
        'Implement API',
        'Add monitoring'
      ]
    },
    {
      name: 'Migration',
      agent: migrationAgent,
      confirmations: ['database migration', 'traffic routing'],
      tasks: [
        'Migrate data',
        'Deploy service',
        'Route 10% traffic',
        'Monitor metrics'
      ]
    },
    {
      name: 'Validation',
      agent: validationAgent,
      tasks: [
        'Compare responses',
        'Check performance',
        'Verify data consistency',
        'Gradual increase to 100%'
      ]
    }
  ]
};
```

---

## Security & Compliance

### Use Case 11: Security Audit System

**Requirements:**
- Automated security scans
- OWASP compliance
- Vulnerability detection
- Remediation guidance

**Recommended Architecture:** **Specialist Agents + Security Skill**

**Implementation:**
```
Security Audit Coordinator
│
├── OWASP Scanner Agent
│   Load: owasp-security-skill
│   Check: OWASP Top 10 vulnerabilities
│
├── Dependency Scanner Agent
│   Load: dependency-security-skill
│   Check: Vulnerable dependencies
│
├── Code Scanner Agent
│   Load: secure-coding-skill
│   Check: Code vulnerabilities
│
├── Config Scanner Agent
│   Load: secure-config-skill
│   Check: Insecure configurations
│
└── Report Agent
    Aggregate: All findings
    Prioritize: By severity
    Recommend: Remediation steps
```

**Security Skill Structure:**
```
owasp-security-skill/
├── SKILL.md
├── references/
│   ├── owasp_top_10_2024.md
│   ├── vulnerability_patterns.md
│   ├── remediation_guides.md
│   └── secure_coding_practices.md
└── checklist/
    ├── injection.md
    ├── authentication.md
    ├── sensitive_data.md
    └── ...
```

---

## DevOps & Automation

### Use Case 12: CI/CD Pipeline Generator

**Requirements:**
- Generate CI/CD pipelines
- Multiple platforms (GitHub, GitLab, etc.)
- Best practices built-in
- Customizable workflows

**Recommended Architecture:** **Skills**

**Implementation:**

```
cicd-generator-skill/
├── SKILL.md
├── references/
│   ├── pipeline_patterns.md
│   ├── best_practices.md
│   └── optimization_tips.md
├── templates/
│   ├── github_actions/
│   │   ├── basic.yml
│   │   ├── advanced.yml
│   │   └── monorepo.yml
│   ├── gitlab_ci/
│   └── jenkins/
└── scripts/
    └── generate_pipeline.sh
```

**Usage:**
```
Using cicd-generator-skill, generate GitHub Actions pipeline for:

Project type: Node.js API
Requirements:
- Lint on PR
- Run tests (unit, integration)
- Build Docker image
- Deploy to staging (on main branch)
- Deploy to production (on release tag)
- Security scanning
- Code coverage reports

Include:
- Caching for faster builds
- Parallel jobs where possible
- Proper secrets management
```

**Generated Pipeline:**
```yaml
name: CI/CD Pipeline

on:
  pull_request:
    branches: [main]
  push:
    branches: [main]
    tags: ['v*']

jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: '18'
          cache: 'npm'
      - run: npm ci
      - run: npm run lint

  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: '18'
          cache: 'npm'
      - run: npm ci
      - run: npm test -- --coverage
      - uses: codecov/codecov-action@v3

  security:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - run: npm audit
      - uses: snyk/actions/node@master

  # ... more jobs
```

---

## Data Analysis

### Use Case 13: Log Analysis and Insights

**Requirements:**
- Analyze application logs
- Identify patterns
- Detect anomalies
- Generate insights

**Recommended Architecture:** **Agents + Progressive Disclosure Skill**

**Implementation:**

```
Log Analysis Pipeline

1. Collection Agent
   - Gather logs from various sources
   - Normalize formats
   - Filter relevant entries

2. Pattern Recognition Agent
   Load: log-analysis-patterns-skill
   - Identify error patterns
   - Find performance bottlenecks
   - Detect security threats
   - Track user behavior

3. Anomaly Detection Agent
   - Compare against baselines
   - Flag unusual patterns
   - Assess severity

4. Insights Agent
   - Aggregate findings
   - Generate recommendations
   - Create visualizations
   - Prioritize actions
```

**Log Analysis Skill:**
```
log-analysis-patterns-skill/
├── patterns/
│   ├── error_patterns.md
│   ├── performance_patterns.md
│   ├── security_patterns.md
│   └── user_behavior_patterns.md
└── insights/
    ├── common_issues.md
    └── remediation_steps.md
```

---

## Content Generation

### Use Case 14: Technical Blog Post Generator

**Requirements:**
- Generate blog posts from features
- SEO optimized
- Brand voice consistency
- Code examples included

**Recommended Architecture:** **Skills**

**Implementation:**

```
technical-blog-generator-skill/
├── SKILL.md
├── references/
│   ├── brand_voice.md
│   ├── seo_guidelines.md
│   ├── blog_structure.md
│   └── code_example_formats.md
├── templates/
│   ├── feature_announcement.md
│   ├── tutorial.md
│   ├── deep_dive.md
│   └── comparison.md
└── examples/
    └── published_posts.md
```

**Usage:**
```
Using technical-blog-generator-skill, create a blog post about
our new API rate limiting feature:

Target audience: Backend developers
Tone: Technical but accessible
Include:
- Why rate limiting matters
- How to implement
- Code examples (Node.js, Python)
- Best practices
- Common pitfalls

SEO keywords: API rate limiting, request throttling, API security
```

---

## Summary

**Key Patterns by Use Case:**

| Use Case | Architecture | Why |
|----------|-------------|-----|
| Code Review | Skills + Prompts | Reusable standards, simple workflow |
| Feature Development | Specialist Agents + Skills | Complex, multi-layer, parallel work |
| Documentation | Progressive Disclosure Skill | Large knowledge base, context efficiency |
| Testing | Agents + Skills | Autonomous generation, quality standards |
| Refactoring | Multi-Phase Agents | Complex, risky, needs validation |
| Security | Specialist Agents + Skills | Multiple scan types, expertise needed |
| CI/CD | Skills | Template generation, best practices |
| Data Analysis | Agents + Skills | Pattern recognition, insights |
| Content | Skills | Brand consistency, SEO requirements |

**Decision Framework:**
1. Analyze your requirements
2. Match to similar use case
3. Adapt architecture pattern
4. Implement and iterate
5. Measure and optimize

**Remember:** These are starting points. Adapt based on your specific needs and constraints.
