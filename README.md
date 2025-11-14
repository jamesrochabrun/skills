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
