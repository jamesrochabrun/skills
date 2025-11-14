# Claude Code Skills

A collection of custom skills for Claude Code.

## Skills

### Engineering Skills

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

[View git-worktrees skill →](./git-worktrees)

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

[View llm-router skill →](./llm-router)

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

[View engineer-expertise-extractor skill →](./engineer-expertise-extractor)

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

[View engineer-skill-creator skill →](./engineer-skill-creator)

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

[View prd-generator skill →](./prd-generator)

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

[View technical-launch-planner skill →](./technical-launch-planner)

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

[View design-brief-generator skill →](./design-brief-generator)

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

[View frontend-designer skill →](./frontend-designer)

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

[View apple-hig-designer skill →](./apple-hig-designer)

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

[View content-brief-generator skill →](./content-brief-generator)

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

[View trading-plan-generator skill →](./trading-plan-generator)

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

[View query-expert skill →](./query-expert)

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

[View qa-test-planner skill →](./qa-test-planner)

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

[View math-teacher skill →](./math-teacher)

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

[View reading-teacher skill →](./reading-teacher)

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

[View leetcode-teacher skill →](./leetcode-teacher)

---

#### technical-doc-writer

**📝 Expert technical writing assistant for creating professional documentation, diagrams, and presentations.** Helps engineers write design docs, RFCs, ADRs, API documentation, post-mortems, and more. Generates Mermaid diagrams and exports to Google Drive, Notion, Quip, and Confluence.

**Key features:**
- Complete document templates - Design docs, RFCs, ADRs, API docs, runbooks, post-mortems
- Diagram generation - Architecture, sequence, flowchart, ERD, state, and Gantt charts using Mermaid
- Presentation builder - Technical slides for design reviews, demos, and RFCs
- Writing best practices - Industry-standard guidelines and style guides
- Platform optimization - Formatted for Google Drive, Notion, Quip, Confluence
- Interactive scripts - Generate docs, diagrams, and slides instantly

**Document types:**
- **Design Documents:** System architecture with API contracts and trade-offs
- **RFCs:** Proposals with problem statements and alternatives
- **ADRs:** Architecture decision records with consequences
- **API Documentation:** Complete API specs with examples and error codes
- **Post-Mortems:** Incident analysis with timeline and action items
- **Runbooks:** Operational procedures and troubleshooting guides
- **Presentations:** Technical slides for reviews and demos

**Diagram types:**
- **Architecture:** System components and data flows
- **Sequence:** Component interactions over time
- **Flowchart:** Process flows and decision trees
- **ERD:** Database schema and relationships
- **State:** State machines and transitions
- **Gantt:** Project timelines and milestones

**Usage:**
- "Create a design doc for [feature/system]"
- "Generate an architecture diagram for [system]"
- "Write API documentation for [endpoint]"
- "Create a post-mortem for [incident]"
- "Build a presentation about [topic]"
- "Generate a sequence diagram for [flow]"

**Includes:**
- `generate_doc.sh` - Interactive document generator
- `generate_diagram.sh` - Mermaid diagram creator
- `generate_slides.sh` - Technical presentation builder
- Complete reference materials (best practices, templates, diagram guide, presentation tips)
- Real-world examples for all document types
- Multi-platform export guidance

**Perfect for:**
- Software engineers writing technical docs
- Engineering managers creating proposals
- Technical leads documenting architecture
- DevOps teams building runbooks
- Product engineers documenting APIs
- Teams conducting post-mortems

**Example outputs:**
- 📋 Design Document - Complete system design with architecture diagrams
- 📜 RFC - Proposal with trade-offs and alternatives
- 🏛️ ADR - Architectural decision with context and consequences
- 📡 API Docs - RESTful API reference with code examples
- 🔍 Post-Mortem - Incident analysis with 5 Whys and action items
- 📊 Architecture Diagram - System components with data flows
- 🔄 Sequence Diagram - Service interactions over time
- 🎤 Presentation - Technical slides with diagrams and metrics

**Use with Claude:**
```
"Using technical-doc-writer, create a design doc for a real-time notification system"

"Generate an architecture diagram for a microservices e-commerce platform"

"Create API documentation for the user authentication endpoints"

"Build a presentation for our design review next week"

"Write a post-mortem for the database outage"
```

[View technical-doc-writer skill →](./technical-doc-writer)

---

## Installation

### Install All Skills

Clone this repository to your Claude Code skills directory:

```bash
git clone https://github.com/jamesrochabrun/skills.git ~/.claude/skills/custom
```

### Install Individual Skills

Download the specific skill directory you want and place it in `~/.claude/skills/`:

```bash
# Example: Install llm-router
cp -r llm-router ~/.claude/skills/
```

## Requirements

- Claude Code
- Skills may have their own dependencies (check individual skill README)

## Contributing

Feel free to contribute additional skills or improvements via pull requests.

## License

MIT License - See individual skills for their specific licenses.

## Credits

Created by [@jamesrochabrun](https://github.com/jamesrochabrun)

Built for use with [Claude Code](https://claude.ai/code) by Anthropic.
