# Skills Plugin & Marketplace

A comprehensive plugin and marketplace for Claude Code containing 21 custom skills across engineering, product management, design, content, trading, database, QA, educational, and AI architecture domains.

## Overview

This repository provides Claude Code with specialized knowledge and workflows through a curated collection of skills. Each skill includes interactive scripts, comprehensive reference materials, and best practices for specific domains.

**Use as a Marketplace** to browse and select individual skills, or **install as a Plugin** to get all skills at once.

## Skills Index

Quick navigation to all 21 skills organized by category:

### AI & Architecture (2 skills)
- [anthropic-architect](#anthropic-architect) - Determine the best Anthropic architecture for your project
- [anthropic-prompt-engineer](#anthropic-prompt-engineer) - Master Anthropic's prompt engineering techniques

### Engineering (5 skills)
- [openai-prompt-engineer](#openai-prompt-engineer) - Generate and improve prompts using best practices for OpenAI GPT-5
- [git-worktrees](#git-worktrees) - Manage Git worktrees for parallel development
- [llm-router](#llm-router) - Route requests to different LLM providers
- [engineer-expertise-extractor](#engineer-expertise-extractor) - Extract engineering expertise from GitHub
- [engineer-skill-creator](#engineer-skill-creator) - Transform expertise into actionable skills

### Product Management (1 skill)
- [prd-generator](#prd-generator) - Generate Product Requirements Documents

### Product Marketing (1 skill)
- [technical-launch-planner](#technical-launch-planner) - Plan technical product launches

### Design (4 skills)
- [design-brief-generator](#design-brief-generator) - Generate comprehensive design briefs
- [frontend-designer](#frontend-designer) - Build accessible, responsive UIs
- [apple-hig-designer](#apple-hig-designer) - Design native iOS apps
- [book-illustrator](#book-illustrator) - Children's book illustration guide

### Content & Writing (2 skills)
- [content-brief-generator](#content-brief-generator) - Generate SEO-optimized content briefs
- [kids-book-writer](#kids-book-writer) - Write engaging children's books

### Trading & Finance (1 skill)
- [trading-plan-generator](#trading-plan-generator) - Generate trading plans with risk management

### Database & Query (1 skill)
- [query-expert](#query-expert) - Master SQL and database queries

### QA & Testing (1 skill)
- [qa-test-planner](#qa-test-planner) - Generate test plans and bug reports

### Educational & Learning (3 skills)
- [math-teacher](#math-teacher) - Interactive math learning with gamification
- [reading-teacher](#reading-teacher) - Interactive reading teacher for ages 1-10
- [leetcode-teacher](#leetcode-teacher) - Technical interview preparation

---

## Skills

### AI & Architecture Skills

#### anthropic-architect

**Determine the best Anthropic architecture for your project.** Analyze requirements and receive tailored recommendations on the optimal architecture using Skills, Agents, Subagents, Prompts, and SDK primitives based on proven decision rubrics and 2025 best practices.

**Key features:**
- Analyze project requirements and complexity
- Recommend optimal architecture (Skills vs Agents vs Prompts vs SDK)
- Apply comprehensive decision rubrics
- Progressive disclosure design guidance
- Security and performance best practices
- Real-world architectural patterns
- Cost optimization strategies

**Usage:**
- "Using anthropic-architect, determine the best architecture for my code review system"
- "Help me choose between Skills and Agents for this workflow"
- "Analyze my project and recommend the right Anthropic primitives"
- "What's the best architecture for automated testing?"

**The Four Anthropic Primitives:**
- **Skills** - Reusable domain expertise with progressive disclosure
- **Agents/Subagents** - Autonomous task handlers with isolated contexts
- **Direct Prompts** - Simple, clear instructions for straightforward tasks
- **SDK Primitives** - Custom workflows and system integrations

**Decision Framework:**
```
Task Complexity:
  Low (1-3) → Direct Prompts
  Medium (4-6) → Skills
  High (7-9) → Agents/Subagents
  Custom (10) → SDK Primitives

Plus evaluation of:
- Reusability requirements
- Context management needs
- Security & control requirements
- Performance needs
- Maintenance burden
- Time to market
```

**Reference materials:**
- `decision_rubric.md` - Comprehensive 7-dimension decision framework
- `architectural_patterns.md` - 14 proven architecture patterns
- `best_practices.md` - 2025 Anthropic best practices (progressive disclosure, context management, security)
- `use_case_examples.md` - Real-world architectures for common use cases

**Perfect for:**
- Choosing the right Anthropic primitives for your project
- Designing scalable, maintainable AI architectures
- Optimizing context usage and costs
- Following 2025 best practices
- Avoiding common anti-patterns
- Learning when to use Skills vs Agents vs Prompts
- Building production-ready AI systems

**Example Recommendations:**

**Use Case: Code Review System**
```
Recommended: Skills + Direct Prompts
Why: Reusable standards (Skills), simple workflow (Prompts)
Pattern: Load code-review-expert skill, review PRs with prompts
```

**Use Case: Full-Stack Feature**
```
Recommended: Specialist Agents + Skills
Why: Complex multi-layer work, parallel execution, specialized expertise
Pattern: Frontend/Backend/DevOps agents each load relevant skills
```

**Use Case: Simple Bug Fix**
```
Recommended: Direct Prompt
Why: One-time task, minimal complexity, no reusability needed
Pattern: Clear instruction to Claude
```

[View anthropic-architect skill →](./skills/anthropic-architect)

---

#### anthropic-prompt-engineer

**Master Anthropic's prompt engineering techniques for Claude AI models.** Generate new prompts from scratch or improve existing ones using best practices, XML structuring, chain-of-thought reasoning, and progressive disclosure patterns optimized for Claude 4.x.

**Key features:**
- Generate effective prompts from requirements
- Improve existing prompts with proven techniques
- Claude-specific optimizations (XML tags, thinking, prefilling)
- Apply core techniques: clear instructions, few-shot examples, role assignment
- Advanced patterns: progressive disclosure, chain-of-thought, structured output
- Avoid common mistakes and hallucinations
- Production-ready prompt templates

**Usage:**
- "Using anthropic-prompt-engineer, create a prompt for extracting structured data"
- "Improve this prompt using Anthropic best practices"
- "Generate a Claude-optimized prompt for code analysis"
- "Debug why this prompt gives inconsistent results"

**Core Anthropic Techniques:**
- **XML Tags** - Structure prompts with semantic tags like `<instructions>`, `<example>`, `<context>`
- **Chain of Thought** - Ask Claude to think step-by-step for complex reasoning
- **Prefilling** - Start Claude's response to guide format and style
- **Few-Shot Examples** - Provide 2-5 diverse examples showing desired pattern
- **Progressive Disclosure** - Load context incrementally to optimize token usage
- **Clear Instructions** - Claude 4.x excels with explicit, unambiguous direction

**Reference materials:**
- `core_techniques.md` - Essential Anthropic techniques with examples
- `advanced_techniques.md` - Advanced optimization methods
- `common_mistakes.md` - Pitfalls to avoid
- `claude_4_best_practices.md` - Claude 4.x specific guidance
- `prompt_templates.md` - Ready-to-use production templates

**Perfect for:**
- Creating consistent, high-quality prompts for Claude
- Learning Anthropic-specific techniques (vs OpenAI/GPT patterns)
- Optimizing prompts for Claude 4.x models
- Building prompt libraries for your team
- Reducing hallucinations and errors
- Achieving first-try success more often
- Production prompt engineering

**Example Improvements:**

Before:
```
"Analyze this code"
```

After (Anthropic-optimized):
```
<instructions>
Analyze the code below for:
1. Security vulnerabilities
2. Performance issues
3. Code quality concerns

For each issue found:
- Specify exact line number
- Explain the problem
- Provide specific fix recommendation
</instructions>

<code>
[code here]
</code>

<output_format>
Return JSON array:
[{
  "type": "security|performance|quality",
  "line": number,
  "issue": "description",
  "fix": "recommendation"
}]
</output_format>
```

[View anthropic-prompt-engineer skill →](./skills/anthropic-prompt-engineer)

---

### Engineering Skills

#### openai-prompt-engineer

**Generate and improve prompts using cutting-edge techniques for OpenAI GPT-5 and other LLMs.** Apply advanced patterns like chain-of-thought, few-shot prompting, structured output, and progressive disclosure to create effective, consistent prompts.

**Key features:**
- Generate new prompts from specifications
- Improve existing prompts with proven techniques
- Model-specific optimizations (GPT-5 vs Claude)
- Advanced patterns: Chain-of-Thought, Few-Shot, XML structuring
- Prompt quality analysis and debugging
- Comprehensive best practices library

**Usage:**
- "Using openai-prompt-engineer, create a prompt for code review"
- "Improve this prompt for better results"
- "Generate a GPT-5 optimized prompt for data analysis"
- "Analyze this prompt and suggest improvements"

**Techniques covered:**
- **GPT-5 specific**: Structured prompting (role+task+constraints), reasoning effort control, agentic behavior calibration, verbosity management
- **Claude specific**: XML tag structuring, step-by-step thinking, progressive disclosure, long-context optimization
- **Universal**: Chain-of-thought prompting, few-shot learning, zero-shot prompting, self-consistency, role-based prompting

**Reference materials:**
- `gpt5_techniques.md` - GPT-5 specific best practices and patterns
- `claude_techniques.md` - Claude/Anthropic optimization strategies
- `prompt_patterns.md` - Reusable templates for common tasks
- `optimization_strategies.md` - Systematic prompt improvement framework

**Perfect for:**
- Creating consistent, high-quality prompts
- Optimizing prompts for specific models
- Learning advanced prompting techniques
- Reducing API costs through better prompts
- Achieving first-try success more often
- Building prompt libraries for your team

**Example improvements:**

Before:
```
"Write code for authentication"
```

After (GPT-5 optimized):
```
ROLE: Senior TypeScript developer
TASK: Implement JWT-based authentication service
REQUIREMENTS:
- TypeScript with strict mode
- Include refresh token rotation
- Comprehensive error handling
- Unit tests with 80%+ coverage
OUTPUT: Complete implementation with tests and usage example
```

[View openai-prompt-engineer skill →](./skills/openai-prompt-engineer)

---

#### git-worktrees

Manage Git worktrees for parallel Claude Code development. Run multiple Claude Code sessions simultaneously on different branches without conflicts.

**Key features:**
- Super simple scripts for worktree management
- Interactive worktree creation and cleanup
- Automatic sync with main branch
- Best practices and command reference
- Custom slash command template

**Usage:**
- "Create a worktree for feature-api"
- "List all active worktrees"
- "Clean up old worktrees"
- "Sync worktree with main branch"

**Includes:**
- `create_worktree.sh` - Interactive worktree creation
- `list_worktrees.sh` - View all active worktrees
- `cleanup_worktrees.sh` - Remove old worktrees safely
- `sync_worktree.sh` - Keep worktrees up-to-date
- Complete command reference and best practices
- Custom `/worktree` slash command template

**Perfect for:**
- Parallel AI development with multiple Claude sessions
- Hotfixes during feature development
- Code review without context switching
- Experimentation without breaking main work

[View git-worktrees skill →](./skills/git-worktrees)

---

#### llm-router

Route AI requests to different LLM providers using SwiftOpenAI-CLI.

**Supported providers:**
- OpenAI (GPT-4, GPT-5)
- Grok (xAI)
- Groq (Llama, Mixtral)
- DeepSeek
- OpenRouter (300+ models)

**Usage:**
- "Use grok to explain quantum computing"
- "Ask deepseek to solve this problem"
- "Use groq for fast code generation"

[View llm-router skill →](./skills/llm-router)

---

#### engineer-expertise-extractor

**🔥 Extract and replicate engineering expertise from GitHub contributions.** Research any engineer's coding style, patterns, and best practices to create a structured knowledge base that AI agents can use to code like them.

**Key features:**
- GitHub CLI integration for PR analysis
- Automated expertise extraction from code
- Structured knowledge organization by topic
- Coding style documentation (naming, formatting, structure)
- Pattern identification and cataloging
- Best practices extraction
- Architectural decision documentation
- Code review style analysis

**Usage:**
- "Extract expertise from engineer @username"
- "Research coding patterns from their PRs"
- "Document their architectural decisions"
- "Analyze their code review style"
- "Create agent training profile"

**Includes:**
- `extract_engineer.sh` - Full extraction workflow with GitHub CLI
- Organized folder structure (coding_style/, patterns/, best_practices/, architecture/)
- Template documentation files
- PR analysis and pattern recognition
- Profile README generation

**Output Structure:**
```
engineer_profiles/
└── [username]/
    ├── README.md (profile overview)
    ├── coding_style/ (conventions & preferences)
    ├── patterns/ (common solutions & approaches)
    ├── best_practices/ (quality standards)
    ├── architecture/ (design decisions)
    ├── code_review/ (feedback patterns)
    └── examples/ (real code samples)
```

**Perfect for:**
- Creating "digital mentors" from senior engineers
- Training AI agents to code in specific styles
- Onboarding new engineers with real examples
- Preserving knowledge before engineers leave
- Establishing team coding standards
- Code review training materials

**Use Cases:**
- **AI Agent Training:** "Using engineer_profiles/senior_dev/, write code matching their style"
- **Knowledge Transfer:** Extract expertise before engineer leaves
- **Team Standards:** Create evidence-based coding guidelines
- **Onboarding:** Provide real examples from top engineers

**Requirements:** GitHub CLI (`gh`) installed and authenticated

[View engineer-expertise-extractor skill →](./skills/engineer-expertise-extractor)

---

#### engineer-skill-creator

**Transform extracted expertise into actionable skills with progressive disclosure.** Takes engineer profiles from the extractor and creates structured, queryable skills that AI agents can use to find relevant expertise for specific tasks.

**Key features:**
- Progressive disclosure system (show only what's needed)
- Task-based organization (authentication, API design, testing, etc.)
- Language-specific guidance
- Pattern library with examples
- Interactive query tool
- Quick reference guides
- Automatic categorization

**Usage:**
- "Create a skill from engineer profile"
- "Transform expertise into queryable format"
- "Generate progressive disclosure navigation"
- "Package expertise for agent use"

**Workflow:**
```bash
# Step 1: Extract expertise
./extract_engineer.sh senior_dev

# Step 2: Create skill (THIS TOOL)
./create_expert_skill.sh senior_dev

# Step 3: Use with agents
"Using expert-skills/senior-dev-mentor/, implement auth"
```

**Output Structure:**
```
expert-skills/[name]-mentor/
├── SKILL.md (documentation)
├── query_expertise.sh (interactive query)
├── expertise/
│   ├── by_task/ (auth, API, testing, etc.)
│   ├── by_language/ (TypeScript, Python, etc.)
│   ├── by_pattern/ (DI, repository, etc.)
│   └── quick_reference/ (style, naming, etc.)
└── examples/ (real code samples)
```

**Progressive Disclosure:**
Instead of dumping all expertise at once, agents query specific needs:
- "How do they handle authentication?" → Gets only auth patterns
- "TypeScript coding style?" → Gets only TS conventions
- "Repository pattern?" → Gets only that pattern

**Perfect for:**
- Making expertise searchable and queryable
- Enabling task-specific guidance
- Creating AI agent training materials
- Building onboarding resources
- Scaling knowledge across teams

**Use with agents:**
```
"Using expert-skills/senior-dev-mentor/, write a user service
following their patterns and style"

"Using expert-skills/tech-lead-mentor/, review this code using
their standards"
```

**Requirements:** Completed engineer profile from engineer-expertise-extractor

**The Complete Workflow:**
1. **Extract:** `engineer-expertise-extractor` → Creates profile
2. **Create:** `engineer-skill-creator` → Transforms into skill
3. **Use:** Reference skill in agent prompts → Get expert guidance

[View engineer-skill-creator skill →](./skills/engineer-skill-creator)

---

### Product Management Skills

#### prd-generator

Generate comprehensive Product Requirements Documents (PRDs) for product managers.

**Key features:**
- Interactive PRD generation workflow
- Standard PRD templates (full, lean, one-pager)
- User story creation with acceptance criteria
- Success metrics frameworks (AARRR, HEART, North Star, OKRs)
- PRD validation and completeness checking
- Comprehensive reference materials

**Usage:**
- "Create a PRD for user authentication"
- "Generate a lean PRD for dark mode feature"
- "Write requirements for a new dashboard"
- "Help me create user stories for checkout flow"

**Includes:**
- Complete PRD template with all standard sections
- User story examples and best practices
- Metrics frameworks guide (AARRR, HEART, OKRs)
- Interactive generation script
- Validation script for quality checking

[View prd-generator skill →](./skills/prd-generator)

---

### Product Marketing Skills

#### technical-launch-planner

Plan and execute technical product launches for developer tools, APIs, and technical products.

**Key features:**
- Launch tier assessment (Tier 1/2/3 framework)
- Interactive launch plan generation
- Developer enablement checklists
- Technical messaging templates
- Launch readiness validation
- Post-launch tracking

**Usage:**
- "Plan a launch for our new API"
- "Determine the launch tier for this feature"
- "Create a developer enablement checklist"
- "Generate technical launch messaging"
- "Validate launch readiness"

**Includes:**
- `assess_launch_tier.sh` - Determine appropriate launch tier
- `generate_launch_plan.sh` - Create comprehensive launch plan
- `validate_readiness.sh` - Pre-launch readiness checker
- Developer enablement complete checklist
- Technical messaging frameworks and templates
- Launch tier frameworks (GA, Beta, Preview)

**Perfect for:**
- Developer tools and platforms
- API and SDK launches
- Technical infrastructure products
- B2D (Business-to-Developer) products

[View technical-launch-planner skill →](./skills/technical-launch-planner)

---

### Design Skills

#### design-brief-generator

Generate comprehensive design briefs for design projects, ensuring alignment and clarity before design work begins.

**Key features:**
- Interactive design brief generation
- Complete design brief template with all sections
- Accessibility guidelines (WCAG 2.1)
- Design principles framework
- User research methods guide
- Brief validation and completeness checking

**Usage:**
- "Create a design brief for mobile app redesign"
- "Generate a brief for new feature design"
- "Help me document design requirements"
- "Validate my design brief for completeness"
- "What accessibility requirements should I include?"

**Includes:**
- `generate_brief.sh` - Interactive brief generation
- `validate_brief.sh` - Brief completeness validation
- Complete design brief template
- WCAG 2.1 accessibility guidelines
- Design principles creation guide
- User research methods reference

**Perfect for:**
- UX/UI designers planning projects
- Design system work
- Feature design projects
- Redesign initiatives
- Stakeholder alignment

[View design-brief-generator skill →](./skills/design-brief-generator)

---

#### frontend-designer

**Transform frontend design through progressive disclosure skills.** Build accessible, responsive, high-performance user interfaces with modern CSS, design tokens, and component-driven architecture.

**Key features:**
- Component generation with accessibility built-in
- Design system setup with comprehensive tokens
- WCAG 2.1 AA compliance auditing
- Design tokens (colors, typography, spacing, shadows)
- Responsive design patterns
- Component library architecture
- Accessibility-first approach
- Performance optimization

**Usage:**
- "Generate an accessible button component"
- "Set up a design system with tokens"
- "Audit this page for accessibility"
- "Create a responsive card layout"
- "Build a component library"

**Includes:**
- `generate_component.sh` - Create accessible components (React, Vue, Vanilla JS)
- `setup_design_system.sh` - Initialize design system with tokens
- `audit_accessibility.sh` - Comprehensive WCAG 2.1 AA checker
- Design tokens reference (colors, typography, spacing, etc.)
- Accessibility checklist (complete WCAG 2.1 guide)
- Responsive patterns (mobile-first, layouts, grids)
- Component library architecture guide

**Output:**
```
design-system/
├── tokens/
│   ├── colors.css (brand, semantic, neutral)
│   ├── typography.css (fluid type, weights)
│   ├── spacing.css (spacing scale, containers)
│   ├── shadows.css (elevation system)
│   └── borders.css (radius, widths)
└── components/
    └── Button/
        ├── Button.tsx (accessible component)
        ├── Button.test.tsx (unit tests)
        ├── Button.module.css (scoped styles)
        └── Button.stories.tsx (Storybook)
```

**Perfect for:**
- Frontend developers building design systems
- Creating accessible user interfaces
- Implementing responsive layouts
- Component library development
- WCAG 2.1 AA compliance
- Modern CSS architecture
- Design token systems

**Features in depth:**
- **Accessibility:** Focus management, ARIA attributes, keyboard navigation, screen reader support
- **Responsive:** Mobile-first, fluid typography, container queries, responsive images
- **Components:** Button, Input, Card, Modal, Dropdown with variants and states
- **Design Tokens:** CSS custom properties for theming, dark mode support
- **Testing:** Unit tests, accessibility tests, visual regression
- **Performance:** Code splitting, lazy loading, optimized rendering

**Use with Claude:**
```
"Using the frontend-designer skill, create an accessible navigation
component with mobile menu, keyboard support, and WCAG 2.1 compliance"

"Set up a design system with design tokens following the
frontend-designer patterns"

"Audit my landing page for accessibility issues using the
frontend-designer skill"
```

[View frontend-designer skill →](./skills/frontend-designer)

---

#### apple-hig-designer

**Design native iOS apps following Apple's Human Interface Guidelines.** Create accessible, intuitive interfaces for iPhone, iPad, and Apple Watch with SwiftUI and UIKit components that feel truly native.

**Key features:**
- iOS component generation (SwiftUI & UIKit)
- Apple HIG compliance validation
- iOS accessibility auditing (VoiceOver, Dynamic Type)
- San Francisco font system & Dynamic Type
- Semantic colors with automatic dark mode
- 8-point grid system & safe areas
- Native iOS patterns & components
- SF Symbols integration

**Usage:**
- "Generate an iOS button component in SwiftUI"
- "Validate my design against Apple HIG"
- "Audit this view for iOS accessibility"
- "Show me navigation patterns for iOS"
- "Create a list view with proper spacing"

**Includes:**
- `generate_ios_component.sh` - Create SwiftUI/UIKit components
- `validate_design.sh` - Check Apple HIG compliance
- `audit_accessibility.sh` - iOS accessibility checker
- Typography reference (San Francisco, Dynamic Type)
- Colors reference (semantic colors, dark mode)
- Components catalog (buttons, lists, navigation, modals)
- Accessibility guide (VoiceOver, reduce motion, contrast)
- Layout & spacing guide (8pt grid, safe areas, touch targets)

**Perfect for:**
- iOS app developers
- SwiftUI & UIKit development
- Native iOS design
- Apple HIG compliance
- iOS accessibility (VoiceOver, Dynamic Type)
- iPad multitasking support
- Apple Watch app design

**Design Principles:**
- **Clarity:** Clean, focused content
- **Deference:** UI supports content, doesn't compete
- **Depth:** Visual layers and realistic motion

**Components Covered:**
- Navigation: NavigationStack, TabView, Toolbar
- Controls: Button, Toggle, Slider, Picker, TextField
- Content: List, ScrollView, Grid
- Presentations: Sheet, Alert, ConfirmationDialog
- Indicators: ProgressView, Activity Indicator

**Accessibility Features:**
- VoiceOver labels, hints, values
- Dynamic Type (11 size categories)
- Reduce Motion support
- Increase Contrast support
- Minimum 44pt touch targets
- Color contrast validation

**Use with Claude:**
```
"Using apple-hig-designer, create a SwiftUI navigation view
with proper large titles and accessibility support"

"Validate my iOS app design against Apple HIG guidelines"

"Audit this SwiftUI view for VoiceOver and Dynamic Type compliance"
```

[View apple-hig-designer skill →](./skills/apple-hig-designer)

---

#### book-illustrator

**🎨 Expert children's book illustrator guide with 2024-2025 best practices.** Focuses on age-appropriate styles, color theory, character design, and visual storytelling for kids books that captivate young readers.

**Key features:**
- Age-appropriate design (ages 0-12)
- Character development and expressiveness
- Color theory for emotion and mood
- Visual storytelling through composition
- Current illustration trends and timeless techniques
- Professional illustration standards
- Print and digital publishing requirements

**Usage:**
- "Design a character for a children's book about friendship"
- "Create a color palette for a bedtime story"
- "Develop illustration guidelines for ages 4-6"
- "Plan visual storytelling for a picture book"

**Includes:**
- Character design principles
- Color theory and psychology
- Composition and layout techniques
- Illustration style guide
- Age-specific design considerations

**Perfect for:**
- Children's book illustrators
- Graphic designers working on kids content
- Authors self-publishing picture books
- Art directors for children's publishing

[View book-illustrator skill →](./skills/book-illustrator)

---

### Content & Writing Skills

#### content-brief-generator

Generate comprehensive content briefs for writers, ensuring strategic, SEO-optimized content across all formats.

**Key features:**
- Interactive content brief generation
- SEO strategy and keyword research framework
- Content structure frameworks (AIDA, PAS, How-To, etc.)
- Tone and voice development guide
- Brief validation and completeness checking
- Templates for blog posts, documentation, landing pages, and more

**Usage:**
- "Create a blog post brief for JWT authentication"
- "Generate a landing page brief"
- "Help me write a technical documentation brief"
- "What SEO keywords should I target?"
- "Validate my content brief"

**Includes:**
- `generate_brief.sh` - Interactive brief generation
- `validate_brief.sh` - Brief completeness validation
- Complete SEO guidelines and best practices
- Content structure frameworks (AIDA, PAS, storytelling, etc.)
- Tone and voice development guide
- Copywriting formulas and templates

**Perfect for:**
- Content writers and marketers
- Technical writers
- Copywriters
- Content strategists
- SEO specialists

[View content-brief-generator skill →](./skills/content-brief-generator)

---

#### kids-book-writer

**📚 Expert children's book writer creating delightful, engaging books for ages 2-9.** Specializes in rhyming books, stories, songs with proper values, educational content, and age-appropriate language. Crafts books that captivate young readers while teaching important life lessons.

**Key features:**
- Rhyming books with perfect meter and rhythm
- Picture book stories with engaging narratives
- Songs and poems for young learners
- Educational content (phonics, sight words, vocabulary)
- Values and life lessons (kindness, empathy, courage)
- Age-appropriate language for reading stages
- Interactive elements (call-and-response, repetition)
- Illustration guidance for bringing stories to life

**Usage:**
- "Write a rhyming book about sharing for 3-year-olds"
- "Create a bedtime story with a lesson about courage"
- "Generate a phonics song for letter sounds"
- "Write a picture book about making friends"

**Includes:**
- Age-appropriate writing guidelines
- Story structure frameworks
- Rhyming techniques and patterns
- Values and themes reference
- Bestseller elements guide

**Perfect for:**
- Children's book authors
- Parents creating custom stories
- Educators developing reading materials
- Content creators for kids

[View kids-book-writer skill →](./skills/kids-book-writer)

---

### Trading & Finance Skills

#### trading-plan-generator

Generate comprehensive trading plans with risk management, position sizing, and discipline frameworks for consistent, profitable trading.

**Key features:**
- Interactive trading plan generation
- Risk management frameworks (1% rule, daily loss limits)
- Position sizing calculators
- Entry/exit strategy templates
- Trading psychology and discipline guide
- Performance tracking metrics
- Plan validation and compliance checking

**Usage:**
- "Create a trading plan for swing trading"
- "Calculate position size for this trade"
- "What should my daily loss limit be?"
- "Help me set up risk management rules"
- "Validate my trading plan"

**Includes:**
- `generate_plan.sh` - Interactive plan generation (7 steps)
- `validate_plan.sh` - Plan completeness validation
- `position_calculator.sh` - Quick position sizing tool
- Complete risk management guide (1% rule, R:R, stops)
- Trading psychology reference (emotions, discipline, tilt)
- Performance metrics and tracking frameworks

**Perfect for:**
- Day traders
- Swing traders
- Position traders
- Options traders
- Anyone serious about trading discipline

**⚠️ Important:** This provides frameworks, not financial advice. Trading involves substantial risk of loss.

[View trading-plan-generator skill →](./skills/trading-plan-generator)

---

### Database & Query Skills

#### query-expert

**Master SQL and database queries across multiple systems.** Generate optimized queries, analyze performance with EXPLAIN plans, design effective indexes, and troubleshoot slow queries for PostgreSQL, MySQL, MongoDB, and more.

**Key features:**
- Interactive query generation (SQL, MongoDB, GraphQL)
- Query optimization analysis with recommendations
- EXPLAIN plan interpretation guide
- Index strategy recommendations
- Performance troubleshooting
- Multi-database support
- Best practices and anti-patterns
- Automated query scoring

**Usage:**
- "Generate an optimized SELECT query with JOINs"
- "Analyze this slow query and suggest optimizations"
- "How do I interpret this EXPLAIN output?"
- "Create indexes for better performance"
- "Convert this SQL to MongoDB aggregation"

**Includes:**
- `generate_query.sh` - Interactive query generator
- `optimize_query.sh` - Query optimization analyzer
- `analyze_performance.sh` - EXPLAIN plan guide & performance analysis
- SQL patterns reference (SELECT, JOIN, GROUP BY, CTEs, window functions)
- Indexing strategies (composite, covering, partial indexes)
- Query optimization techniques
- NoSQL queries (MongoDB, GraphQL)

**Databases Supported:**
- **SQL:** PostgreSQL, MySQL, SQLite, SQL Server, Oracle
- **NoSQL:** MongoDB, Redis, Elasticsearch, Cassandra
- **Query Languages:** SQL, MongoDB Query Language, GraphQL, Cypher

**Query Patterns:**
- SELECT with JOINs (INNER, LEFT, RIGHT, FULL OUTER)
- Aggregation (GROUP BY, HAVING, aggregates)
- Window functions (ROW_NUMBER, RANK, running totals)
- CTEs (Common Table Expressions)
- Subqueries and correlated subqueries
- MongoDB aggregation pipelines
- GraphQL queries with fragments

**Optimization Techniques:**
- Avoid SELECT * (select only needed columns)
- Index creation on WHERE/JOIN/ORDER BY columns
- Composite index column ordering
- Covering indexes for index-only scans
- EXISTS vs IN for subqueries
- Batch operations
- LIMIT/pagination
- Query plan analysis

**Performance Analysis:**
- PostgreSQL EXPLAIN ANALYZE interpretation
- MySQL EXPLAIN output analysis
- MongoDB explain() stats
- Index usage verification
- Table scan detection
- JOIN type optimization
- Automated performance scoring

**Use with Claude:**
```
"Using query-expert, generate an optimized query to get
top 10 customers by total order value with their details"

"Analyze this query and suggest performance improvements:
SELECT * FROM orders WHERE YEAR(created_at) = 2024"

"Explain what this EXPLAIN ANALYZE output means and
how to optimize the query"
```

[View query-expert skill →](./skills/query-expert)

---

### QA & Testing Skills

#### qa-test-planner

Generate comprehensive test plans, manual test cases, regression suites, and bug reports for QA engineers. Includes Figma MCP integration for design validation.

**Key features:**
- Interactive test case generation
- Test plan templates and strategy
- Regression test suite builder
- Figma design validation (with MCP)
- Bug report templates
- Test coverage analysis
- Test execution tracking

**Usage:**
- "Create test cases for login feature"
- "Generate a regression test suite"
- "Validate UI against Figma design"
- "Create a bug report for payment issue"
- "Build a test plan for new feature"

**Includes:**
- `generate_test_cases.sh` - Interactive test case creation
- `create_bug_report.sh` - Structured bug documentation
- Figma validation guide (design-implementation comparison)
- Regression testing best practices
- Test plan templates and examples
- Bug severity and priority frameworks

**Perfect for:**
- QA Engineers
- Manual testers
- Regression testers
- UI/Visual testers
- Test leads and managers

**🎨 Figma MCP:** When configured, enables design-implementation validation and visual testing.

[View qa-test-planner skill →](./skills/qa-test-planner)

---

### Educational & Learning Skills

#### math-teacher

**🎓 Interactive math teacher that instantly generates playful, gamified learning experiences.** Creates visual playgrounds, interactive artifacts, and engaging games for kids and adults to learn math from basic arithmetic to advanced calculus.

**Key features:**
- Instant playground generation - creates HTML artifacts on demand
- Adaptive learning - scales from elementary to college level
- Visual learning - graphs, animations, interactive visualizations
- Gamification - points, achievements, challenges, progress tracking
- Question-driven - user asks, teacher generates custom experiences
- Playful techniques - engaging animations, rewards, fun challenges
- No setup required - all artifacts work standalone in browser

**Topics covered:**
- **Elementary**: Fractions, multiplication, geometry, patterns, time & money
- **Middle School**: Linear equations, ratios, percentages, statistics, Pythagorean theorem
- **High School**: Quadratics, trigonometry, exponentials, logarithms, polynomials
- **Advanced**: Derivatives, integrals, limits, optimization, differential equations

**Usage:**
- "Help me understand fractions"
- "Show me how derivatives work"
- "I don't understand quadratic functions"
- "Challenge me on mental math"
- "Let me explore the Pythagorean theorem"

**Includes:**
- `generate_playground.sh` - Create interactive math playground
- `generate_game.sh` - Build gamified math challenge
- Complete reference materials (basic_math, algebra, calculus, gamification)
- Interactive visualization templates
- Game mechanics and reward systems

**Perfect for:**
- Students learning math concepts
- Teachers creating interactive lessons
- Parents helping kids with homework
- Adults refreshing math skills
- Anyone wanting to make math fun

**Example artifacts:**
- 🍕 Fraction Pizza Party - visual fraction explorer with sliders
- 📊 Quadratic Explorer - real-time parabola graphing with coefficients
- 📈 Derivative Visualizer - tangent lines and limit animations
- 🎮 Speed Math Challenge - timed game with progressive difficulty
- 🧩 Pattern Finder - discover number sequences interactively

**Use with Claude:**
```
"Using math-teacher, help me understand how integrals work"

"Create an interactive playground for learning quadratic functions"

"Generate a fun math game for practicing multiplication"
```

[View math-teacher skill →](./skills/math-teacher)

---

#### reading-teacher

**📚 Interactive reading teacher that instantly generates playful, engaging learning experiences for children ages 1-10.** Creates visual playgrounds, phonics games, and interactive stories to build reading skills from letter recognition to comprehension.

**Key features:**
- Instant playground generation - creates HTML artifacts on demand
- Age-appropriate content - tailored for ages 1-10 with developmental stages
- Multi-sensory learning - visual, auditory, and interactive elements
- Phonics & sight words - systematic instruction and high-frequency words
- Story building - interactive creation and comprehension activities
- Gamification - stars, badges, rewards, and progress tracking
- Parent/teacher tools - progress reports and customization options

**Reading stages:**
- **Pre-Reading (Ages 1-3)**: Letter recognition, sounds, phonemic awareness
- **Early Reading (Ages 3-5)**: Letter-sound correspondence, CVC words, simple sight words
- **Beginning Readers (Ages 5-7)**: Phonics patterns, expanding sight words, simple sentences
- **Developing Readers (Ages 7-10)**: Advanced phonics, comprehension, vocabulary

**Usage:**
- "Help my toddler learn letters"
- "Practice sight words for first grade"
- "Phonics games for kindergarten"
- "Reading comprehension for 2nd grade"
- "Build a story with my child"

**Includes:**
- `generate_playground.sh` - Create interactive reading playground
- `generate_game.sh` - Build phonics or sight word game
- Complete reference materials (phonics, sight_words, comprehension)
- Interactive activity templates
- Progress tracking systems

**Perfect for:**
- Parents teaching young children
- Homeschool reading instruction
- Early literacy educators
- ESL/ELL learners
- Reading intervention support

**Example artifacts:**
- 🔤 Letter Land Adventure - interactive alphabet with sounds
- 📖 Sight Word Safari - timed recognition challenges
- 🎯 Phonics Matching - CVC word building games
- 📚 Story Builder Studio - create and read stories
- 🧩 Word Family Explorer - rhyming and pattern practice

**Use with Claude:**
```
"Using reading-teacher, help my 4-year-old learn letter sounds"

"Create a sight word practice game for kindergarten"

"Generate an interactive story for reading comprehension"
```

[View reading-teacher skill →](./skills/reading-teacher)

---

#### leetcode-teacher

**🚀 Interactive LeetCode-style teacher for mastering technical interviews.** Generates browser-based coding playgrounds with real product challenges, teaches the 20 essential patterns, supports Python/TypeScript/Kotlin/Swift, and provides progressive difficulty training.

**Key features:**
- Interactive code editor - browser-based with syntax highlighting
- Multi-language support - Python, TypeScript, Kotlin, Swift
- Real product challenges - Instagram, Uber, Netflix, Amazon scenarios
- Pattern recognition - Master the 20 essential coding patterns
- Progressive difficulty - Easy → Medium → Hard → Expert
- Instant feedback - Run tests in real-time with detailed explanations
- Technique teaching - Learn optimization strategies

**Patterns covered:**
- **Arrays**: Two Pointers, Sliding Window, Fast & Slow Pointers
- **Trees & Graphs**: BFS, DFS, Topological Sort
- **Dynamic Programming**: Knapsack, Fibonacci, LCS
- **Advanced**: Binary Search, Top K, Backtracking, Union Find, Tries

**Usage:**
- "Practice two pointers with Instagram example"
- "Generate sliding window problem for Netflix"
- "Teach me BFS with LinkedIn connections"
- "Hard dynamic programming challenge"
- "Show me all heap patterns"

**Includes:**
- `generate_playground.sh` - Create interactive coding environments
- `generate_problem.sh` - Generate specific problem types
- Complete reference materials (patterns, data_structures)
- Multi-language code templates
- Real product scenario examples

**Perfect for:**
- FAANG interview preparation
- Coding pattern mastery
- Algorithm practice
- Technical interview training
- Competitive programming

**Example challenges:**
- 🎯 Two Sum (Instagram Mutual Likes)
- 📊 Top K Elements (Reddit Top Posts)
- 🔗 BFS (LinkedIn Degrees of Connection)
- 📅 Merge Intervals (Google Calendar Slots)
- 🚗 Shortest Path (Uber Driver Matching)

**Use with Claude:**
```
"Using leetcode-teacher, create a two pointers playground for Instagram"

"Generate a BFS problem with LinkedIn connections context"

"Show me sliding window pattern with Netflix recommendations"
```

[View leetcode-teacher skill →](./skills/leetcode-teacher)

---

## Installation

You have two ways to use this skills collection:

### Option 1: Install ALL Skills (Bundle)

Get all 21 skills at once with intelligent routing:

```bash
/plugin marketplace add jamesrochabrun/skills
/plugin install all-skills@skills-marketplace
```

**When to use this:**
- You want access to all skills
- You prefer Claude to automatically choose relevant skills
- You work across multiple domains (engineering, product, design, etc.)

### Option 2: Install Individual Skills

Pick only the skills you need for better performance and focused context:

```bash
# First, add the marketplace
/plugin marketplace add jamesrochabrun/skills

# Then install specific skills
/plugin install anthropic-architect@skills-marketplace
/plugin install prd-generator@skills-marketplace
/plugin install frontend-designer@skills-marketplace
# ... install any skills you need
```

**When to use this:**
- You work in specific domains
- You want optimal performance with smaller context
- You prefer explicit skill activation

### Available Individual Skills

**AI & Architecture:**
- `/plugin install anthropic-architect@skills-marketplace`
- `/plugin install anthropic-prompt-engineer@skills-marketplace`

**Engineering:**
- `/plugin install openai-prompt-engineer@skills-marketplace`
- `/plugin install git-worktrees@skills-marketplace`
- `/plugin install llm-router@skills-marketplace`
- `/plugin install engineer-expertise-extractor@skills-marketplace`
- `/plugin install engineer-skill-creator@skills-marketplace`

**Product Management:**
- `/plugin install prd-generator@skills-marketplace`
- `/plugin install technical-launch-planner@skills-marketplace`

**Design:**
- `/plugin install design-brief-generator@skills-marketplace`
- `/plugin install frontend-designer@skills-marketplace`
- `/plugin install apple-hig-designer@skills-marketplace`
- `/plugin install book-illustrator@skills-marketplace`

**Content & Writing:**
- `/plugin install content-brief-generator@skills-marketplace`
- `/plugin install kids-book-writer@skills-marketplace`

**Trading & Finance:**
- `/plugin install trading-plan-generator@skills-marketplace`

**Database & Query:**
- `/plugin install query-expert@skills-marketplace`

**QA & Testing:**
- `/plugin install qa-test-planner@skills-marketplace`

**Educational & Learning:**
- `/plugin install math-teacher@skills-marketplace`
- `/plugin install reading-teacher@skills-marketplace`
- `/plugin install leetcode-teacher@skills-marketplace`

### Plugin Structure

The plugin follows the standard Claude Code plugin architecture:

```
skills/
├── .claude-plugin/
│   ├── plugin.json          # Plugin metadata
│   └── marketplace.json     # Marketplace configuration (22 plugins: 1 bundle + 21 individual)
├── skills/                   # All skills collection (21 total)
│   ├── anthropic-architect/
│   ├── anthropic-prompt-engineer/
│   ├── openai-prompt-engineer/
│   ├── git-worktrees/
│   ├── llm-router/
│   ├── engineer-expertise-extractor/
│   ├── engineer-skill-creator/
│   ├── prd-generator/
│   ├── technical-launch-planner/
│   ├── design-brief-generator/
│   ├── frontend-designer/
│   ├── apple-hig-designer/
│   ├── book-illustrator/
│   ├── content-brief-generator/
│   ├── kids-book-writer/
│   ├── trading-plan-generator/
│   ├── query-expert/
│   ├── qa-test-planner/
│   ├── math-teacher/
│   ├── reading-teacher/
│   └── leetcode-teacher/
├── README.md                 # This file
└── LICENSE
```

### How It Works

**Marketplace Configuration:**
- The `marketplace.json` exposes 22 installable options
- 1 "all-skills" bundle with `strict: false` (intelligent routing across all 21 skills)
- 21 individual skills with `strict: true` (explicit activation when installed)

**Installation Flexibility:**
- Install the bundle for comprehensive coverage with smart skill selection
- Install individual skills for focused, high-performance context
- Mix and match based on your needs

## Requirements

- Claude Code
- Skills may have their own dependencies (check individual skill README)

## Contributing

Feel free to contribute additional skills or improvements via pull requests.

## License

MIT License - See individual skills for their specific licenses.

## Architecture

This marketplace provides flexible installation options:

### Bundle Installation (all-skills)
- **What:** All 21 skills in one package
- **Behavior:** `strict: false` enables intelligent skill routing
- **Best for:** Users who work across multiple domains and want comprehensive coverage
- **Trade-off:** Larger context window, but Claude automatically selects relevant skills

### Individual Installation
- **What:** Install only specific skills you need
- **Behavior:** `strict: true` ensures explicit skill activation
- **Best for:** Focused workflows in specific domains (e.g., only engineering or only design)
- **Trade-off:** Smaller context window for better performance, but requires manual skill selection

### Technical Details

**marketplace.json structure:**
- 22 total plugin entries
- 1 "all-skills" bundle pointing to root with all 21 skills
- 21 individual plugins, each pointing to a single skill
- All use same repository source (`./`) with different skill paths

**Why this works:**
- No duplication: Skills live in one place (`skills/` directory)
- Flexible installation: Users choose bundle vs individual
- No maintenance burden: No individual `plugin.json` files needed
- Clean architecture: Single source of truth in `marketplace.json`

For more information about Claude Code plugins and marketplaces, visit the [official documentation](https://github.com/anthropics/claude-code/tree/main/plugins).

## Credits

Created by [@jamesrochabrun](https://github.com/jamesrochabrun)

Built for use with [Claude Code](https://claude.ai/code) by Anthropic.

## Version

**Current Version:** 2.0.0

**What's New in 2.0.0:**
- ✨ Individual skill installation support
- 🎯 22 installable options (1 bundle + 21 individual skills)
- ⚡ Better performance with focused skill selection
- 🔧 Smart routing with `strict: false` for bundle, `strict: true` for individual skills

See [marketplace.json](./.claude-plugin/marketplace.json) for complete configuration.
