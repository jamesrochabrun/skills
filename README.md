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
