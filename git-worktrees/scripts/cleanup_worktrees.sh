#!/bin/bash

# Git Worktree Cleanup
# Interactive removal of old/merged worktrees

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
GRAY='\033[0;90m'
NC='\033[0m' # No Color

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo -e "${RED}✗ Error: Not in a git repository${NC}"
    exit 1
fi

REPO_ROOT=$(git rev-parse --show-toplevel)
REPO_NAME=$(basename "$REPO_ROOT")

echo -e "${BLUE}╔════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║       Git Worktree Cleanup Tool               ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════╝${NC}"
echo ""

# Get list of worktrees (excluding main)
WORKTREES=$(git worktree list --porcelain | grep -v "^$" | grep -v "^HEAD" | grep -v "^bare")

if [ -z "$WORKTREES" ]; then
    echo -e "${YELLOW}No feature worktrees found${NC}"
    echo "Only the main worktree exists."
    exit 0
fi

# Arrays to store worktree info
declare -a PATHS
declare -a BRANCHES
declare -a STATUSES
declare -a MERGED_FLAGS
COUNT=0

# Parse worktrees
CURRENT_PATH=""
CURRENT_BRANCH=""

while IFS= read -r line; do
    if [[ $line == worktree* ]]; then
        CURRENT_PATH=$(echo "$line" | awk '{print $2}')
    elif [[ $line == branch* ]]; then
        CURRENT_BRANCH=$(echo "$line" | awk '{print $2}' | sed 's|refs/heads/||')

        # Skip main worktree
        if [ "$CURRENT_PATH" != "$REPO_ROOT" ] && [ -n "$CURRENT_BRANCH" ]; then
            PATHS[$COUNT]="$CURRENT_PATH"
            BRANCHES[$COUNT]="$CURRENT_BRANCH"

            # Check if branch is merged into main
            cd "$REPO_ROOT"
            if git branch --merged main | grep -q "^[* ]*${CURRENT_BRANCH}$"; then
                MERGED_FLAGS[$COUNT]="merged"
                STATUSES[$COUNT]="${GREEN}✓ Merged to main${NC}"
            else
                MERGED_FLAGS[$COUNT]="not-merged"

                # Check if worktree is clean
                cd "$CURRENT_PATH"
                if git diff-index --quiet HEAD -- 2>/dev/null; then
                    STATUSES[$COUNT]="${YELLOW}⚠ Not merged, clean${NC}"
                else
                    CHANGE_COUNT=$(git status --short | wc -l | tr -d ' ')
                    STATUSES[$COUNT]="${RED}⚠ Not merged, $CHANGE_COUNT changes${NC}"
                fi
            fi

            ((COUNT++))
        fi

        CURRENT_PATH=""
        CURRENT_BRANCH=""
    fi
done <<< "$WORKTREES"

if [ $COUNT -eq 0 ]; then
    echo -e "${YELLOW}No feature worktrees to clean up${NC}"
    exit 0
fi

# Display worktrees
echo -e "${CYAN}Found $COUNT feature worktree(s):${NC}"
echo ""

for i in "${!PATHS[@]}"; do
    echo -e "${CYAN}[$((i+1))]${NC} ${BRANCHES[$i]}"
    echo -e "    Path:   ${GRAY}${PATHS[$i]}${NC}"
    echo -e "    Status: ${STATUSES[$i]}"
    echo ""
done

# Prompt for selection
echo -e "${YELLOW}Which worktrees would you like to remove?${NC}"
echo -e "  Enter numbers separated by spaces (e.g., '1 3 4')"
echo -e "  Enter 'merged' to remove all merged worktrees"
echo -e "  Enter 'all' to remove all worktrees"
echo -e "  Press Enter to cancel"
echo ""
read -p "Selection: " SELECTION

# Parse selection
if [ -z "$SELECTION" ]; then
    echo -e "${GRAY}Cancelled${NC}"
    exit 0
fi

# Build list of indices to remove
declare -a TO_REMOVE

if [ "$SELECTION" = "all" ]; then
    for i in "${!PATHS[@]}"; do
        TO_REMOVE+=($i)
    done
elif [ "$SELECTION" = "merged" ]; then
    for i in "${!PATHS[@]}"; do
        if [ "${MERGED_FLAGS[$i]}" = "merged" ]; then
            TO_REMOVE+=($i)
        fi
    done
    if [ ${#TO_REMOVE[@]} -eq 0 ]; then
        echo -e "${YELLOW}No merged worktrees found${NC}"
        exit 0
    fi
else
    # Parse space-separated numbers
    for num in $SELECTION; do
        # Validate number
        if [[ "$num" =~ ^[0-9]+$ ]] && [ "$num" -ge 1 ] && [ "$num" -le "$COUNT" ]; then
            TO_REMOVE+=($((num - 1)))
        else
            echo -e "${RED}Invalid selection: $num${NC}"
            exit 1
        fi
    done
fi

# Confirmation
echo ""
echo -e "${YELLOW}About to remove ${#TO_REMOVE[@]} worktree(s):${NC}"
echo ""
for idx in "${TO_REMOVE[@]}"; do
    echo -e "  ${RED}✗${NC} ${BRANCHES[$idx]}"
    echo -e "    ${GRAY}${PATHS[$idx]}${NC}"
done
echo ""

# Extra warning for non-merged branches
HAS_UNMERGED=false
for idx in "${TO_REMOVE[@]}"; do
    if [ "${MERGED_FLAGS[$idx]}" != "merged" ]; then
        HAS_UNMERGED=true
        break
    fi
done

if [ "$HAS_UNMERGED" = true ]; then
    echo -e "${RED}⚠ WARNING: Some branches are NOT merged!${NC}"
    echo -e "${RED}   You may lose uncommitted work.${NC}"
    echo ""
fi

read -p "Are you sure? (yes/no): " CONFIRM

if [ "$CONFIRM" != "yes" ]; then
    echo -e "${GRAY}Cancelled${NC}"
    exit 0
fi

# Remove worktrees
echo ""
echo -e "${BLUE}Removing worktrees...${NC}"
echo ""

cd "$REPO_ROOT"

for idx in "${TO_REMOVE[@]}"; do
    WORKTREE_PATH="${PATHS[$idx]}"
    BRANCH_NAME="${BRANCHES[$idx]}"

    echo -e "${CYAN}→${NC} Removing worktree: ${BRANCH_NAME}"

    # Remove worktree
    if git worktree remove "$WORKTREE_PATH" --force 2>/dev/null; then
        echo -e "  ${GREEN}✓${NC} Worktree removed"
    else
        # Try manual removal if git worktree remove fails
        if [ -d "$WORKTREE_PATH" ]; then
            rm -rf "$WORKTREE_PATH"
            git worktree prune
            echo -e "  ${GREEN}✓${NC} Worktree removed (manual cleanup)"
        else
            echo -e "  ${YELLOW}⚠${NC} Worktree already removed"
        fi
    fi

    # Ask about deleting the branch
    if [ "${MERGED_FLAGS[$idx]}" = "merged" ]; then
        # Auto-delete merged branches
        git branch -d "$BRANCH_NAME" 2>/dev/null && \
            echo -e "  ${GREEN}✓${NC} Branch deleted" || \
            echo -e "  ${GRAY}Branch already deleted or doesn't exist${NC}"
    else
        # Prompt for unmerged branches
        echo -e "  ${YELLOW}Branch '$BRANCH_NAME' is not merged.${NC}"
        read -p "  Delete branch anyway? (y/n): " DELETE_BRANCH
        if [[ "$DELETE_BRANCH" =~ ^[Yy]$ ]]; then
            git branch -D "$BRANCH_NAME" 2>/dev/null && \
                echo -e "  ${GREEN}✓${NC} Branch force-deleted" || \
                echo -e "  ${GRAY}Could not delete branch${NC}"
        else
            echo -e "  ${GRAY}Branch kept${NC}"
        fi
    fi

    echo ""
done

# Prune any stale references
echo -e "${CYAN}→${NC} Cleaning up stale references..."
git worktree prune
echo -e "${GREEN}✓${NC} Done"
echo ""

# Summary
echo -e "${GREEN}✓ Cleanup complete!${NC}"
echo ""
echo -e "${BLUE}═══════════════════════════════════════════════${NC}"
echo -e "Removed: ${CYAN}${#TO_REMOVE[@]}${NC} worktree(s)"
echo -e "${BLUE}═══════════════════════════════════════════════${NC}"
echo ""

# Show remaining worktrees
REMAINING=$(git worktree list | wc -l)
if [ $REMAINING -gt 1 ]; then
    echo -e "${CYAN}Remaining worktrees: $((REMAINING - 1))${NC}"
    echo -e "${GRAY}Run 'scripts/list_worktrees.sh' to see them${NC}"
else
    echo -e "${CYAN}No feature worktrees remaining${NC}"
fi
echo ""
