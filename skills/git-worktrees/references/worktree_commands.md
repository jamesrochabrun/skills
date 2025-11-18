# Git Worktree Command Reference

Complete reference for `git worktree` commands.

---

## Basic Commands

### Create a New Worktree

```bash
# Create worktree with new branch
git worktree add <path> -b <new-branch>

# Create worktree from existing branch
git worktree add <path> <existing-branch>

# Create worktree from specific commit
git worktree add <path> <commit-hash>
```

**Examples:**
```bash
# New feature branch
git worktree add ../myapp-feature-api -b feature-api

# Use existing branch
git worktree add ../myapp-hotfix hotfix-login

# From specific commit
git worktree add ../myapp-review abc123def
```

---

### List All Worktrees

```bash
# Simple list
git worktree list

# Porcelain format (machine-readable)
git worktree list --porcelain

# With verbose output
git worktree list -v
```

**Output format:**
```
/home/user/myapp              abc123 [main]
/home/user/myapp-feature-api  def456 [feature-api]
/home/user/myapp-hotfix       789ghi [hotfix-login]
```

---

### Remove a Worktree

```bash
# Remove worktree (must be clean)
git worktree remove <path>

# Force remove (even with uncommitted changes)
git worktree remove <path> --force
```

**Examples:**
```bash
# Clean removal
git worktree remove ../myapp-feature-api

# Force removal
git worktree remove ../myapp-feature-api --force
```

---

### Move a Worktree

```bash
# Move worktree to new location
git worktree move <old-path> <new-path>
```

**Example:**
```bash
git worktree move ../myapp-feature-api ~/projects/myapp-feature-api
```

---

### Prune Stale References

```bash
# Clean up references to removed worktrees
git worktree prune

# Dry run (show what would be pruned)
git worktree prune --dry-run

# Verbose output
git worktree prune --verbose
```

---

## Advanced Usage

### Lock/Unlock Worktrees

Prevent a worktree from being automatically pruned or removed.

```bash
# Lock a worktree
git worktree lock <path>

# Lock with reason
git worktree lock <path> --reason "Long-running task"

# Unlock a worktree
git worktree unlock <path>
```

**Use cases:**
- Worktrees on removable drives
- Network-mounted worktrees
- Long-running background tasks

---

### Create Detached HEAD Worktrees

Useful for reviewing specific commits without creating a branch.

```bash
# Checkout specific commit
git worktree add <path> --detach <commit>

# Short form
git worktree add <path> --detach HEAD~5
```

**Example:**
```bash
# Review a specific commit
git worktree add ../review-commit --detach abc123def
```

---

### Sparse Checkout in Worktrees

Only check out specific files/directories in a worktree (useful for large repos).

```bash
# Create worktree with sparse-checkout
git worktree add <path> <branch>
cd <path>
git sparse-checkout init
git sparse-checkout set <directory1> <directory2>
```

**Example:**
```bash
# Only checkout src/ and tests/
git worktree add ../myapp-feature-api feature-api
cd ../myapp-feature-api
git sparse-checkout init
git sparse-checkout set src/ tests/
```

---

## Repair Commands

### Repair Worktree

If worktree becomes corrupted or administrative files are damaged.

```bash
# Repair a worktree
git worktree repair

# Repair specific worktree
git worktree repair <path>
```

---

## Configuration Options

### Set Worktree Defaults

```bash
# Default path for worktrees (relative to repo)
git config worktree.guessRemote true

# Automatically set up remote tracking
git config push.default current
```

---

## Common Workflows

### Workflow 1: Parallel Feature Development

```bash
# 1. Create worktree for feature A
git worktree add ../repo-feature-a -b feature-a

# 2. Create worktree for feature B
git worktree add ../repo-feature-b -b feature-b

# 3. Work on both simultaneously
# (open each in separate editor/Claude session)

# 4. When done, merge both
git checkout main
git merge feature-a
git merge feature-b

# 5. Clean up
git worktree remove ../repo-feature-a
git worktree remove ../repo-feature-b
git branch -d feature-a feature-b
```

---

### Workflow 2: Hotfix During Feature Development

```bash
# You're working in a feature worktree
cd ../repo-feature-xyz

# Need to create hotfix
cd <main-repo>
git worktree add ../repo-hotfix -b hotfix-urgent

# Fix the bug
cd ../repo-hotfix
# ... make fixes ...
git add .
git commit -m "Fix urgent bug"

# Merge hotfix
git checkout main
git merge hotfix-urgent
git push

# Continue feature work
cd ../repo-feature-xyz
# ... continue ...
```

---

### Workflow 3: Code Review Without Switching

```bash
# Create worktree for review
git worktree add ../repo-review pr-branch-name

# Review in separate window
cd ../repo-review
# ... review code ...

# Clean up after review
cd <main-repo>
git worktree remove ../repo-review
```

---

## Troubleshooting Commands

### Check Worktree Status

```bash
# List all worktrees with details
git worktree list -v

# Check if directory is a worktree
cd <directory>
git rev-parse --git-dir
```

---

### Find Orphaned Worktrees

```bash
# List worktrees that no longer exist
git worktree list --porcelain | grep "^worktree" | awk '{print $2}' | while read dir; do
  if [ ! -d "$dir" ]; then
    echo "Orphaned: $dir"
  fi
done

# Clean them up
git worktree prune
```

---

### Reset Worktree to Clean State

```bash
# Discard all changes
cd <worktree>
git reset --hard HEAD
git clean -fd

# Reset to specific branch state
git fetch origin
git reset --hard origin/<branch>
```

---

## Integration with Other Git Commands

### Fetch/Pull in Worktrees

```bash
# Fetch applies to all worktrees (shared .git)
git fetch origin

# Pull in specific worktree
cd <worktree>
git pull origin <branch>
```

---

### Stash in Worktrees

```bash
# Stash is per-worktree
cd <worktree>
git stash push -m "My stash"

# List stashes (shared across worktrees)
git stash list

# Apply stash in different worktree
cd <other-worktree>
git stash apply stash@{0}
```

---

### Rebase in Worktrees

```bash
# Each worktree can have independent rebase operations
cd <worktree>
git rebase main
```

---

## Performance Tips

### Limit Number of Worktrees

- **Recommended:** 3-5 active worktrees
- **Maximum:** Depends on disk space and RAM
- **Why:** Each worktree duplicates working files

### Use Sparse Checkout

For large repositories:

```bash
git sparse-checkout set <dir1> <dir2>
```

Reduces disk usage by only checking out necessary files.

---

### Share Object Database

Worktrees automatically share:
- `.git/objects/` (commits, trees, blobs)
- `.git/refs/` (branches, tags)
- `.git/config` (configuration)

**No duplication of:**
- Git history
- Commit objects
- Branch information

**Duplicated:**
- Working directory files
- Index (staging area)
- Worktree-specific config

---

## Safety and Best Practices

### Before Removing Worktrees

```bash
# Check for uncommitted changes
cd <worktree>
git status

# Check if branch is merged
git branch --merged main | grep <branch-name>

# Backup if needed
git stash push -m "Backup before removal"
```

---

### Handling Merge Conflicts

```bash
# During merge in worktree
cd <worktree>
git merge main

# If conflicts occur
git status  # See conflicting files
# Edit files to resolve
git add <resolved-files>
git commit
```

---

## Quick Reference Table

| Command | Purpose | Example |
|---------|---------|---------|
| `git worktree add <path> -b <branch>` | Create with new branch | `git worktree add ../wt -b feat` |
| `git worktree add <path> <branch>` | Create from existing | `git worktree add ../wt main` |
| `git worktree list` | Show all worktrees | - |
| `git worktree remove <path>` | Remove worktree | `git worktree remove ../wt` |
| `git worktree remove <path> --force` | Force remove | `git worktree remove ../wt -f` |
| `git worktree prune` | Clean stale refs | - |
| `git worktree move <old> <new>` | Move worktree | `git worktree move ../wt ~/wt` |
| `git worktree lock <path>` | Prevent pruning | `git worktree lock ../wt` |
| `git worktree unlock <path>` | Allow pruning | `git worktree unlock ../wt` |
| `git worktree repair` | Fix corrupted worktree | - |

---

## Common Error Messages

### "fatal: '<path>' already exists"

**Cause:** Directory exists

**Solution:**
```bash
rm -rf <path>
# or use a different path
```

---

### "fatal: invalid reference: <branch>"

**Cause:** Branch name has invalid characters

**Solution:** Use only alphanumeric and hyphens:
```bash
# Bad: feature/my_feature
# Good: feature-my-feature
```

---

### "fatal: '<path>' is not a working tree"

**Cause:** Trying to operate on non-worktree directory

**Solution:**
```bash
git worktree list  # Find correct path
```

---

### "fatal: '<branch>' is already checked out"

**Cause:** Branch in use by another worktree

**Solution:**
```bash
# Use a different branch name
git worktree add ../wt -b new-branch-name
```

---

## Resources

**Official Documentation:**
- https://git-scm.com/docs/git-worktree

**Pro Git Book:**
- Chapter on worktrees: https://git-scm.com/book/en/v2

**Git Worktree Tutorial:**
- https://git-scm.com/docs/git-worktree#_examples
