# Git Worktrees Best Practices

Proven patterns and recommendations for using worktrees effectively with Claude Code.

---

## Table of Contents

1. [Naming Conventions](#naming-conventions)
2. [Directory Organization](#directory-organization)
3. [When to Use Worktrees](#when-to-use-worktrees)
4. [Lifecycle Management](#lifecycle-management)
5. [Performance Optimization](#performance-optimization)
6. [Team Collaboration](#team-collaboration)
7. [Claude Code Integration](#claude-code-integration)

---

## Naming Conventions

### Branch Names

**Use descriptive, hierarchical names:**

```
<type>-<short-description>

Types:
- feature-*     New features
- refactor-*    Code refactoring
- hotfix-*      Urgent bug fixes
- experiment-*  Experimental changes
- review-*      Code reviews
- test-*        Testing branches
```

**Examples:**
```bash
✅ Good:
- feature-user-authentication
- refactor-api-layer
- hotfix-login-redirect
- experiment-new-db-schema
- review-pr-123

❌ Bad:
- test
- wt1
- fixes
- my-branch
- abc
```

**Why it matters:**
- Easy to identify purpose months later
- Clear for team members
- Searchable and filterable
- Self-documenting

---

### Directory Names

**Match branch names with prefix:**

```bash
# Pattern: <repo-name>-<branch-name>

Example repository: myapp

Worktrees:
- myapp-feature-api
- myapp-refactor-auth
- myapp-hotfix-login
```

**Benefits:**
- Immediately recognize which repo
- See all worktrees with `ls ../`
- Avoid confusion with multiple projects

**Alternative patterns:**
```bash
# By date (for temporary worktrees)
myapp-2025-01-15-hotfix

# By ticket number
myapp-JIRA-1234

# By developer (in shared environments)
myapp-john-feature-api
```

---

## Directory Organization

### Recommended Structure

```
~/projects/
  └── myapp/                    # Main worktree (main branch)
      ├── myapp-feature-api/    # Feature worktree
      ├── myapp-feature-ui/     # Feature worktree
      ├── myapp-refactor-auth/  # Refactor worktree
      └── myapp-hotfix-login/   # Hotfix worktree
```

**Advantages:**
- All related worktrees grouped together
- Easy to find with `ls ../`
- Clean navigation between worktrees

---

### Alternative: Dedicated Worktrees Directory

```
~/projects/
  ├── myapp/                    # Main worktree
  └── worktrees/
      ├── myapp-feature-api/
      ├── myapp-feature-ui/
      └── myapp-refactor-auth/
```

**Use when:**
- Working with many worktrees
- Want clear separation
- Sharing machine with others

---

### What NOT to Do

```
❌ Nested worktrees:
~/projects/
  └── myapp/
      └── feature-api/  # Don't nest inside repo

❌ Unrelated locations:
~/projects/myapp/               # Main
~/Documents/api-feature/        # Confusing!
/tmp/worktree-123/              # Gets deleted

❌ Generic names:
~/projects/myapp/
    ├── wt1/
    ├── temp/
    └── test/
```

---

## When to Use Worktrees

### ✅ Use Worktrees For:

**1. Parallel AI Development**
- Multiple Claude Code sessions on different features
- Long-running Claude tasks while you continue work
- Experimenting with different AI approaches

**2. Context Switching**
- Hotfix needed while working on feature
- Code review without interrupting current work
- Testing changes in isolation

**3. Comparison & Testing**
- Compare two implementations side-by-side
- Test different approaches
- A/B testing code changes

**4. Long-Running Tasks**
- Major refactors
- Database migrations
- Performance optimization

---

### ❌ DON'T Use Worktrees For:

**1. Quick Branch Switches**
```bash
# Just use checkout for quick switches
git checkout other-branch
# Not: git worktree add ../temp other-branch
```

**2. Very Short-Lived Work** (< 1 hour)
```bash
# Use stash instead
git stash push -m "Quick fix"
git checkout main
# ... do fix ...
git checkout original-branch
git stash pop
```

**3. Simple Merges**
```bash
# Direct merge is simpler
git merge feature-branch
# Not: git worktree add ../temp feature-branch
```

**4. Single-Tasking Workflow**
- If you work on one thing at a time, branches are fine
- Worktrees add overhead without benefit

---

## Lifecycle Management

### Creation Checklist

**Before creating:**
- [ ] Is the branch name descriptive?
- [ ] Is this task long enough to warrant a worktree?
- [ ] Will I need to switch contexts during this work?
- [ ] Do I have disk space? (worktrees duplicate files)

**During creation:**
- [ ] Use the create script: `scripts/create_worktree.sh`
- [ ] Note the path for later
- [ ] Add to tracking system if managing many

---

### Active Maintenance

**Daily:**
- Check status: `scripts/list_worktrees.sh`
- Commit progress in each worktree
- Sync with main if needed: `scripts/sync_worktree.sh`

**Weekly:**
- Clean up merged worktrees: `scripts/cleanup_worktrees.sh`
- Review active worktrees
- Archive or delete abandoned experiments

**Monthly:**
- Audit all worktrees
- Remove stale worktrees
- Update documentation/notes

---

### Cleanup Workflow

**When to clean up:**
- ✅ Branch merged to main
- ✅ Task completed
- ✅ Experiment concluded
- ✅ Review finished
- ⚠️  Abandoned (but check for uncommitted work!)

**How to clean up safely:**
```bash
# 1. Check status
cd ../myapp-feature-api
git status

# 2. Check if merged
cd <main-repo>
git branch --merged main | grep feature-api

# 3. If merged, safe to remove
scripts/cleanup_worktrees.sh
# Select the worktree

# 4. Verify removal
scripts/list_worktrees.sh
```

---

## Performance Optimization

### Disk Space Management

**Monitor usage:**
```bash
# Check worktree sizes
du -sh ../myapp-*

# Check total usage
du -sh ../
```

**Optimization strategies:**

**1. Use Sparse Checkout** (for large repos):
```bash
cd worktree
git sparse-checkout init
git sparse-checkout set src/ tests/
```

**2. Clean Build Artifacts:**
```bash
# Add to .gitignore
node_modules/
target/
build/
*.pyc
```

**3. Limit Concurrent Worktrees:**
- Keep 3-5 active worktrees maximum
- Clean up old ones regularly

---

### Git Performance

**Shared objects are efficient:**
- Git history is shared (not duplicated)
- Only working files are duplicated
- Refs and config are shared

**Keep worktrees healthy:**
```bash
# Prune stale references regularly
git worktree prune

# Garbage collect periodically
git gc --aggressive
```

---

## Team Collaboration

### Communication

**Document active worktrees:**
```markdown
# In your team wiki or README

## Active Worktrees

| Developer | Worktree | Branch | Purpose | Started |
|-----------|----------|--------|---------|---------|
| Alice | feature-api | feature-api | New API endpoints | 2025-01-10 |
| Bob | refactor-db | refactor-db | Database refactor | 2025-01-08 |
```

---

### Sharing Workflow (Not Worktrees!)

**What to share:**
```bash
# Push your branch
cd ../myapp-feature-api
git push origin feature-api

# Teammate creates their own worktree
git worktree add ../myapp-feature-api feature-api
```

**Don't try to:**
- Share worktree directories (they're local)
- Commit worktree paths to git
- Sync worktree locations across machines

---

### Team Conventions

**Establish team standards:**

```yaml
# .github/WORKTREE_GUIDE.md

Naming Convention:
  format: <type>-<description>
  types: feature, refactor, hotfix, experiment

Directory Structure:
  location: Sibling to main repo
  format: <repo-name>-<branch-name>

Cleanup Policy:
  frequency: Weekly
  criteria: Merged branches, abandoned > 30 days

Scripts:
  create: scripts/create_worktree.sh
  list: scripts/list_worktrees.sh
  cleanup: scripts/cleanup_worktrees.sh
```

---

## Claude Code Integration

### Always Run /init

**Critical step when opening a new worktree in Claude Code:**

```
1. Create worktree
2. Open Claude Code in worktree directory
3. Run: /init
4. Give Claude the task
```

**Why `/init` matters:**
- Orients Claude to codebase structure
- Establishes proper context
- Enables correct file navigation
- Prevents confusion about file locations

---

### Optimal Claude Code Workflow

**Pattern 1: Parallel Features**

```bash
# Terminal 1: Create first feature worktree
scripts/create_worktree.sh
# Name: feature-api

# Terminal 2: Create second feature worktree
scripts/create_worktree.sh
# Name: feature-ui

# Claude Session 1: Open feature-api worktree
cd ../myapp-feature-api
code .
# In Claude: /init
# Task: "Build REST API for user management"

# Claude Session 2: Open feature-ui worktree
cd ../myapp-feature-ui
code .
# In Claude: /init
# Task: "Create React UI for user management"

# Monitor both
scripts/list_worktrees.sh
```

---

**Pattern 2: Review + Development**

```bash
# Claude working on feature
cd ../myapp-feature-xyz
# Claude is actively coding

# You need to review a PR
scripts/create_worktree.sh
# Name: review-pr-123

# Open separate editor for review
cd ../myapp-review-pr-123
code .

# No context switching needed!
# Claude continues in feature worktree
# You review in review worktree
```

---

### Managing Multiple Claude Sessions

**Track active sessions:**
```
Feature API      → ../myapp-feature-api      → Port 3001
Feature UI       → ../myapp-feature-ui       → Port 3002
Refactor Auth    → ../myapp-refactor-auth    → Port 3003
```

**Best practices:**
- Limit to 3-5 concurrent Claude sessions
- Use descriptive terminal/window titles
- Keep a log of what each Claude is working on
- Monitor progress regularly

---

### When Claude Gets "Lost"

**Symptoms:**
- Can't find files
- References wrong paths
- Seems confused about structure

**Solution:**
```
1. Run: /init
2. If that doesn't help, restart Claude session
3. Verify you're in correct worktree: pwd
4. Check git branch: git branch --show-current
```

---

## Common Pitfalls & Solutions

### Pitfall 1: Too Many Worktrees

**Problem:** Managing 10+ worktrees becomes overwhelming

**Solution:**
- Limit to 3-5 active worktrees
- Clean up weekly
- Use projects/issues for tracking longer-term work

---

### Pitfall 2: Forgetting to Sync

**Problem:** Worktree gets far behind main, causing conflicts

**Solution:**
- Set reminder to sync daily
- Use script: `scripts/sync_worktree.sh`
- Keep feature branches short-lived

---

### Pitfall 3: Abandoning Worktrees

**Problem:** Old worktrees with uncommitted work left behind

**Solution:**
- Weekly cleanup ritual
- Use `scripts/list_worktrees.sh` to audit
- Document important worktrees
- Set calendar reminder

---

### Pitfall 4: Wrong Branch Checked Out

**Problem:** Same branch in multiple worktrees (git won't allow)

**Solution:**
- Each worktree needs unique branch
- Use branch naming to avoid confusion
- Check before creating: `git branch`

---

### Pitfall 5: Disk Space Issues

**Problem:** Running out of disk space with many worktrees

**Solution:**
- Use sparse checkout
- Clean build artifacts regularly
- Limit concurrent worktrees
- Monitor with `du -sh ../myapp-*`

---

## Checklists

### Before Creating Worktree

- [ ] Is the task substantial enough?
- [ ] Do I have a clear branch name?
- [ ] Do I have sufficient disk space?
- [ ] Is this better than just using `git checkout`?

---

### After Creating Worktree

- [ ] Opened in editor/IDE
- [ ] Ran `/init` in Claude Code
- [ ] Noted purpose/task
- [ ] Set up environment (npm install, etc.)

---

### Before Removing Worktree

- [ ] Checked for uncommitted changes
- [ ] Verified branch is merged (or don't need it)
- [ ] Pushed any important commits
- [ ] Informed team if collaborative work

---

### Weekly Maintenance

- [ ] Run `scripts/list_worktrees.sh`
- [ ] Run `scripts/cleanup_worktrees.sh`
- [ ] Check disk usage
- [ ] Update documentation

---

## Summary of Best Practices

**Do:**
- ✅ Use descriptive branch/directory names
- ✅ Create worktrees as siblings to main repo
- ✅ Run `/init` when opening Claude in new worktree
- ✅ Clean up regularly (weekly)
- ✅ Limit to 3-5 concurrent worktrees
- ✅ Sync with main frequently
- ✅ Use provided scripts for common tasks

**Don't:**
- ❌ Nest worktrees inside repository
- ❌ Create worktrees for quick tasks
- ❌ Forget to run `/init` in Claude
- ❌ Let worktrees accumulate indefinitely
- ❌ Use generic names (test, temp, wt1)
- ❌ Share worktree directories across machines

---

**Key Principle:**
> Worktrees are a power tool. Use them intentionally for parallel development, not as a replacement for basic branching.
