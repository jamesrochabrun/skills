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
