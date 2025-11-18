# Custom /worktree Slash Command Template

Create a custom `/worktree` command for Claude Code to streamline worktree creation.

---

## Overview

This template allows you to create a slash command that:
1. Creates a new Git worktree
2. Provides setup instructions
3. Offers to continue the conversation in the new worktree

**Usage after setup:**
```
/worktree feature-new-api
```

Claude will create the worktree and guide you through the next steps.

---

## Setup Instructions

### Step 1: Create Command File

Create a new file in your Claude Code commands directory:

```bash
# For project-specific command
mkdir -p .claude/commands
touch .claude/commands/worktree.md

# For global command (all projects)
mkdir -p ~/.claude/commands
touch ~/.claude/commands/worktree.md
```

---

### Step 2: Add Command Content

Copy this template into `worktree.md`:

```markdown
---
description: Create a new Git worktree for parallel development with Claude Code
---

# Create Git Worktree

{{#if (not args.0)}}
**Usage:** `/worktree <branch-name> [base-branch]`

**Examples:**
- `/worktree feature-api` - Create worktree from main
- `/worktree feature-ui develop` - Create worktree from develop
- `/worktree hotfix-urgent` - Create hotfix worktree

**What this does:**
1. Creates a new Git worktree
2. Sets up the directory structure
3. Provides setup instructions

{{else}}

## Creating Worktree: {{args.0}}

Let me create a new Git worktree for parallel development.

**Branch name:** `{{args.0}}`
{{#if args.1}}
**Base branch:** `{{args.1}}`
{{else}}
**Base branch:** `main` (default)
{{/if}}

### Step 1: Create the Worktree

Run this command in your terminal:

\`\`\`bash
scripts/create_worktree.sh
\`\`\`

When prompted:
- Feature name: **{{args.0}}**
{{#if args.1}}
- Base branch: **{{args.1}}**
{{else}}
- Base branch: **main** (or press Enter for default)
{{/if}}

The script will create the worktree in a sibling directory.

### Step 2: Open in New Claude Code Session

After the script completes:

1. Note the worktree path (shown by the script)
2. Open a new Claude Code window
3. Navigate to the worktree directory
4. **Important:** Run `/init` to orient Claude

### Step 3: Start Development

Once in the new worktree with Claude initialized, I can help you:
- Implement the feature
- Write tests
- Create documentation
- Review code

### Alternative: Manual Creation

If you prefer manual setup:

\`\`\`bash
# Get repository root
REPO_ROOT=$(git rev-parse --show-toplevel)
REPO_NAME=$(basename "$REPO_ROOT")

# Create worktree
{{#if args.1}}
git worktree add ../$REPO_NAME-{{args.0}} -b {{args.0}} {{args.1}}
{{else}}
git worktree add ../$REPO_NAME-{{args.0}} -b {{args.0}} main
{{/if}}

# Open in editor
cd ../$REPO_NAME-{{args.0}}
code .
\`\`\`

### Managing Worktrees

**List all worktrees:**
\`\`\`bash
scripts/list_worktrees.sh
\`\`\`

**Sync with main:**
\`\`\`bash
scripts/sync_worktree.sh
\`\`\`

**Clean up when done:**
\`\`\`bash
scripts/cleanup_worktrees.sh
\`\`\`

---

**Would you like me to help with anything else before you switch to the new worktree?**

{{/if}}
```

---

### Step 3: Test the Command

```bash
# In Claude Code, type:
/worktree feature-new-api

# Or with custom base branch:
/worktree feature-ui develop
```

---

## Advanced Template (With Automatic Creation)

For users who want Claude to automatically create the worktree (not just show instructions):

```markdown
---
description: Create and set up a new Git worktree for parallel development
---

# Create Git Worktree: {{args.0}}

{{#if (not args.0)}}
**Error:** Branch name required

**Usage:** `/worktree <branch-name> [base-branch]`

**Examples:**
- `/worktree feature-api`
- `/worktree feature-ui develop`
{{else}}

I'll create a new Git worktree for `{{args.0}}`.

## Creating Worktree

\`\`\`bash
#!/bin/bash

# Configuration
BRANCH_NAME="{{args.0}}"
{{#if args.1}}
BASE_BRANCH="{{args.1}}"
{{else}}
BASE_BRANCH="main"
{{/if}}

# Get repository info
REPO_ROOT=$(git rev-parse --show-toplevel)
REPO_NAME=$(basename "$REPO_ROOT")
WORKTREE_DIR="$(dirname "$REPO_ROOT")/${REPO_NAME}-${BRANCH_NAME}"

# Validate
if [ ! -d "$REPO_ROOT/.git" ]; then
    echo "Error: Not in a git repository"
    exit 1
fi

# Check if branch exists
if git show-ref --verify --quiet "refs/heads/$BRANCH_NAME"; then
    echo "⚠ Branch $BRANCH_NAME already exists"
    echo "Using existing branch..."
    git worktree add "$WORKTREE_DIR" "$BRANCH_NAME"
else
    echo "✓ Creating new branch from $BASE_BRANCH..."
    git worktree add -b "$BRANCH_NAME" "$WORKTREE_DIR" "$BASE_BRANCH"
fi

echo ""
echo "✓ Worktree created successfully!"
echo ""
echo "Next steps:"
echo "1. Open new Claude Code window"
echo "2. Navigate to: $WORKTREE_DIR"
echo "3. Run: /init"
echo "4. Start development!"
\`\`\`

Run the script above to create the worktree.

## What's Next?

After creating the worktree:

1. **Open in new window:** \`code {{WORKTREE_PATH}}\`
2. **Run /init:** To orient Claude in the new environment
3. **Start coding:** I'll be ready to help with {{args.0}}!

## Useful Commands

**View all worktrees:**
\`\`\`bash
git worktree list
\`\`\`

**When done, merge back:**
\`\`\`bash
git checkout main
git merge {{args.0}}
\`\`\`

**Remove worktree:**
\`\`\`bash
git worktree remove ../{{REPO_NAME}}-{{args.0}}
git branch -d {{args.0}}
\`\`\`

{{/if}}
```

---

## Usage Examples

### Example 1: Simple Feature

```
User: /worktree feature-authentication
```

**Claude's response:**
- Shows worktree creation instructions
- Explains next steps
- Offers to continue in new worktree

---

### Example 2: Custom Base Branch

```
User: /worktree feature-dashboard develop
```

**Claude's response:**
- Creates worktree from `develop` instead of `main`
- Adjusts instructions accordingly

---

### Example 3: List Current Worktrees

```
User: /worktree
```

**Claude's response:**
- Shows usage instructions
- Lists example commands
- Explains what the command does

---

## Customization Options

### Add Project-Specific Logic

Modify the template to include project-specific setup:

```markdown
### Step 4: Project Setup

After creating the worktree, run:

\`\`\`bash
cd {{WORKTREE_PATH}}

# Install dependencies
npm install

# Run database migrations
npm run migrate

# Start dev server
npm run dev
\`\`\`
```

---

### Add Team Conventions

Include your team's specific workflow:

```markdown
### Team Workflow

1. Create worktree with `/worktree <feature-name>`
2. Update Jira ticket status to "In Progress"
3. Create draft PR: `gh pr create --draft`
4. Develop feature
5. Request review when ready
```

---

### Add Validation

Enforce naming conventions:

```markdown
{{#if (not (match args.0 "^(feature|hotfix|refactor|experiment)-"))}}
**Error:** Branch name must start with feature-, hotfix-, refactor-, or experiment-

**Valid examples:**
- feature-user-auth
- hotfix-login-bug
- refactor-api-layer
- experiment-new-db
{{/if}}
```

---

## Troubleshooting

### Command Not Found

**Problem:** `/worktree` command doesn't appear

**Solution:**
1. Check file location: `.claude/commands/worktree.md`
2. Restart Claude Code
3. Verify file has correct frontmatter (YAML header with `description`)

---

### Script Path Issues

**Problem:** Scripts not found

**Solution:**
- Use absolute paths: `<skill-path>/scripts/create_worktree.sh`
- Or add scripts to PATH
- Or check scripts are in correct location

---

### Template Variables Not Working

**Problem:** `{{args.0}}` showing as literal text

**Solution:**
- Ensure proper template syntax
- Check Claude Code version (templates require recent version)
- Verify YAML frontmatter is correct

---

## Complete Example

Here's a fully working example you can copy directly:

**File:** `.claude/commands/worktree.md`

```markdown
---
description: Create a Git worktree for parallel Claude Code development
---

# Git Worktree Manager

{{#if args.0}}

## Creating Worktree: {{args.0}}

I'll help you set up a new Git worktree for parallel development.

### Quick Setup

Run this command:

\`\`\`bash
scripts/create_worktree.sh
\`\`\`

When prompted, enter: **{{args.0}}**

### Next Steps

1. ✓ Script will create the worktree
2. Open new Claude Code window
3. Navigate to the new worktree directory
4. Run \`/init\` to orient me
5. Start development on {{args.0}}!

### Manual Alternative

\`\`\`bash
# Create worktree
git worktree add ../$(basename $(git rev-parse --show-toplevel))-{{args.0}} -b {{args.0}}

# Open it
cd ../$(basename $(git rev-parse --show-toplevel))-{{args.0}}
code .
\`\`\`

**Ready to switch?** See you in the new worktree!

{{else}}

## Git Worktree Command

Create a new worktree for parallel development.

**Usage:**
\`\`\`
/worktree <branch-name>
\`\`\`

**Examples:**
\`\`\`
/worktree feature-api
/worktree refactor-auth
/worktree hotfix-urgent
\`\`\`

**What it does:**
- Creates a new Git worktree in a sibling directory
- Sets up the branch
- Provides setup instructions

**Manage worktrees:**
- List all: \`scripts/list_worktrees.sh\`
- Sync with main: \`scripts/sync_worktree.sh\`
- Clean up: \`scripts/cleanup_worktrees.sh\`

{{/if}}
```

---

## Benefits of Custom Command

**Faster workflow:**
- Type `/worktree feature-name` instead of manual commands
- Consistent setup every time
- Team standardization

**Better documentation:**
- Built-in help
- Examples always available
- Team-specific instructions

**Claude integration:**
- Seamless handoff to new worktree
- Context preservation
- Guided workflow

---

## Summary

1. Create `worktree.md` in `.claude/commands/`
2. Copy template
3. Customize for your team
4. Use `/worktree <branch-name>` in Claude Code
5. Enjoy streamlined parallel development!

**Next level:** Share the command template with your team for consistent workflows.
