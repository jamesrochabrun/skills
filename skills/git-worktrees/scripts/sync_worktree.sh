#!/bin/bash

# Git Worktree Sync
# Keep worktree branch up-to-date with main branch

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
GRAY='\033[0;90m'
NC='\033[0m' # No Color

# Default values
TARGET_WORKTREE=""
BASE_BRANCH="main"

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --base)
            BASE_BRANCH="$2"
            shift 2
            ;;
        -h|--help)
            echo "Usage: $0 [WORKTREE_PATH] [OPTIONS]"
            echo ""
            echo "Syncs a worktree with the latest changes from main (or specified base branch)."
            echo ""
            echo "Arguments:"
            echo "  WORKTREE_PATH      Path to worktree (optional if run from within worktree)"
            echo ""
            echo "Options:"
            echo "  --base <branch>    Base branch to sync from (default: main)"
            echo "  -h, --help         Show this help"
            echo ""
            echo "Examples:"
            echo "  # From within a worktree"
            echo "  $0"
            echo ""
            echo "  # Specify worktree path"
            echo "  $0 ../repo-feature-api"
            echo ""
            echo "  # Sync from develop instead of main"
            echo "  $0 --base develop"
            exit 0
            ;;
        *)
            TARGET_WORKTREE="$1"
            shift
            ;;
    esac
done

echo -e "${BLUE}╔════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║        Git Worktree Sync Tool                 ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════╝${NC}"
echo ""

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo -e "${RED}✗ Error: Not in a git repository${NC}"
    exit 1
fi

# Determine target worktree
if [ -z "$TARGET_WORKTREE" ]; then
    # Use current directory
    TARGET_WORKTREE=$(pwd)
    echo -e "${CYAN}→${NC} Using current directory"
else
    # Use specified path
    if [ ! -d "$TARGET_WORKTREE" ]; then
        echo -e "${RED}✗ Error: Directory not found: $TARGET_WORKTREE${NC}"
        exit 1
    fi
    cd "$TARGET_WORKTREE"
    echo -e "${CYAN}→${NC} Using specified worktree: $TARGET_WORKTREE"
fi

# Verify we're in a git worktree
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo -e "${RED}✗ Error: Not a git worktree: $TARGET_WORKTREE${NC}"
    exit 1
fi

CURRENT_BRANCH=$(git branch --show-current)
REPO_ROOT=$(git rev-parse --show-toplevel)
REPO_NAME=$(basename "$REPO_ROOT")

echo -e "${GREEN}✓${NC} Repository: ${CYAN}$REPO_NAME${NC}"
echo -e "${GREEN}✓${NC} Current branch: ${CYAN}$CURRENT_BRANCH${NC}"
echo ""

# Check if current branch is the base branch
if [ "$CURRENT_BRANCH" = "$BASE_BRANCH" ]; then
    echo -e "${YELLOW}⚠${NC}  You're on the base branch ($BASE_BRANCH)"
    echo "  Nothing to sync!"
    exit 0
fi

# Check for uncommitted changes
if ! git diff-index --quiet HEAD --; then
    echo -e "${YELLOW}⚠ Warning: You have uncommitted changes${NC}"
    echo ""
    git status --short
    echo ""
    read -p "Stash changes and continue? (y/n): " STASH_CHANGES
    if [[ ! "$STASH_CHANGES" =~ ^[Yy]$ ]]; then
        echo -e "${GRAY}Cancelled${NC}"
        exit 1
    fi

    echo -e "${CYAN}→${NC} Stashing changes..."
    git stash push -m "Auto-stash before sync at $(date)"
    STASHED=true
    echo -e "${GREEN}✓${NC} Changes stashed"
    echo ""
else
    STASHED=false
fi

# Fetch latest
echo -e "${CYAN}→${NC} Fetching latest from remote..."
git fetch origin

if [ $? -ne 0 ]; then
    echo -e "${RED}✗ Failed to fetch from remote${NC}"
    if [ "$STASHED" = true ]; then
        echo -e "${CYAN}→${NC} Restoring stashed changes..."
        git stash pop
    fi
    exit 1
fi

echo -e "${GREEN}✓${NC} Fetched latest"
echo ""

# Check if base branch exists locally
if ! git show-ref --verify --quiet "refs/heads/$BASE_BRANCH"; then
    echo -e "${RED}✗ Base branch '$BASE_BRANCH' does not exist locally${NC}"
    if [ "$STASHED" = true ]; then
        echo -e "${CYAN}→${NC} Restoring stashed changes..."
        git stash pop
    fi
    exit 1
fi

# Show what we're about to do
BEHIND_COUNT=$(git rev-list --count HEAD..origin/$BASE_BRANCH 2>/dev/null || echo "0")

if [ "$BEHIND_COUNT" = "0" ]; then
    echo -e "${GREEN}✓${NC} Already up-to-date with $BASE_BRANCH!"
    if [ "$STASHED" = true ]; then
        echo ""
        echo -e "${CYAN}→${NC} Restoring stashed changes..."
        git stash pop
        echo -e "${GREEN}✓${NC} Changes restored"
    fi
    exit 0
fi

echo -e "${YELLOW}Your branch is $BEHIND_COUNT commit(s) behind $BASE_BRANCH${NC}"
echo ""
echo -e "${CYAN}Recent commits in $BASE_BRANCH:${NC}"
git log --oneline HEAD..origin/$BASE_BRANCH | head -5
echo ""

read -p "Merge $BASE_BRANCH into $CURRENT_BRANCH? (y/n): " CONFIRM_MERGE
if [[ ! "$CONFIRM_MERGE" =~ ^[Yy]$ ]]; then
    echo -e "${GRAY}Cancelled${NC}"
    if [ "$STASHED" = true ]; then
        echo -e "${CYAN}→${NC} Restoring stashed changes..."
        git stash pop
    fi
    exit 0
fi

# Perform the merge
echo ""
echo -e "${CYAN}→${NC} Merging $BASE_BRANCH into $CURRENT_BRANCH..."

if git merge origin/$BASE_BRANCH -m "Merge $BASE_BRANCH into $CURRENT_BRANCH"; then
    echo -e "${GREEN}✓${NC} Merge successful!"

    # Show summary
    echo ""
    echo -e "${BLUE}═══════════════════════════════════════════════${NC}"
    echo -e "Branch:  ${CYAN}$CURRENT_BRANCH${NC}"
    echo -e "Status:  ${GREEN}Synced with $BASE_BRANCH${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════${NC}"

    # Restore stashed changes if any
    if [ "$STASHED" = true ]; then
        echo ""
        echo -e "${CYAN}→${NC} Restoring stashed changes..."
        if git stash pop; then
            echo -e "${GREEN}✓${NC} Changes restored successfully"
        else
            echo -e "${RED}✗${NC} Conflicts while restoring stashed changes"
            echo "  Resolve conflicts manually, then run: git stash drop"
            exit 1
        fi
    fi

    echo ""
    echo -e "${GREEN}✓ Sync complete!${NC}"
    echo ""

else
    # Merge failed (likely conflicts)
    echo -e "${RED}✗ Merge conflicts detected${NC}"
    echo ""
    echo -e "${YELLOW}Conflicting files:${NC}"
    git diff --name-only --diff-filter=U
    echo ""
    echo -e "${CYAN}To resolve:${NC}"
    echo "  1. Fix conflicts in the files above"
    echo "  2. Stage resolved files: ${YELLOW}git add <file>${NC}"
    echo "  3. Complete the merge: ${YELLOW}git commit${NC}"

    if [ "$STASHED" = true ]; then
        echo ""
        echo -e "${YELLOW}Note: Stashed changes will be restored after merge is complete${NC}"
        echo "  Run: ${YELLOW}git stash pop${NC}"
    fi

    exit 1
fi
