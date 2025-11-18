#!/bin/bash

# List Git Worktrees
# Shows all active worktrees with clean formatting

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
echo -e "${BLUE}║         Git Worktrees - $REPO_NAME"
printf "${BLUE}║${NC}"
printf "%*s${BLUE}║${NC}\n" $((47 - ${#REPO_NAME})) ""
echo -e "${BLUE}╚════════════════════════════════════════════════╝${NC}"
echo ""

# Get worktree list
WORKTREES=$(git worktree list --porcelain)

if [ -z "$WORKTREES" ]; then
    echo -e "${YELLOW}No worktrees found${NC}"
    exit 0
fi

# Parse and display worktrees
MAIN_WORKTREE=""
FEATURE_WORKTREES=""
WORKTREE_COUNT=0

while IFS= read -r line; do
    if [[ $line == worktree* ]]; then
        CURRENT_PATH=$(echo "$line" | awk '{print $2}')
    elif [[ $line == branch* ]]; then
        CURRENT_BRANCH=$(echo "$line" | awk '{print $2}' | sed 's|refs/heads/||')
    elif [[ $line == "" ]]; then
        # End of worktree block
        if [ -n "$CURRENT_PATH" ]; then
            ((WORKTREE_COUNT++))

            # Get status
            cd "$CURRENT_PATH"
            if git diff-index --quiet HEAD -- 2>/dev/null; then
                STATUS="${GREEN}clean${NC}"
            else
                CHANGE_COUNT=$(git status --short | wc -l | tr -d ' ')
                STATUS="${YELLOW}$CHANGE_COUNT uncommitted changes${NC}"
            fi

            # Get last commit info
            LAST_COMMIT=$(git log -1 --format="%cr" 2>/dev/null || echo "no commits")

            # Check if it's the main worktree
            if [ "$CURRENT_PATH" = "$REPO_ROOT" ]; then
                MAIN_WORKTREE+="📁 ${CYAN}Main Worktree${NC}\n"
                MAIN_WORKTREE+="   Path:   ${GRAY}$CURRENT_PATH${NC}\n"
                MAIN_WORKTREE+="   Branch: ${CYAN}$CURRENT_BRANCH${NC}\n"
                MAIN_WORKTREE+="   Status: $STATUS\n"
                MAIN_WORKTREE+="   Last:   ${GRAY}$LAST_COMMIT${NC}\n"
            else
                FEATURE_WORKTREES+="📦 ${CYAN}$CURRENT_BRANCH${NC}\n"
                FEATURE_WORKTREES+="   Path:   ${GRAY}$CURRENT_PATH${NC}\n"
                FEATURE_WORKTREES+="   Status: $STATUS\n"
                FEATURE_WORKTREES+="   Last:   ${GRAY}$LAST_COMMIT${NC}\n\n"
            fi
        fi

        # Reset for next worktree
        CURRENT_PATH=""
        CURRENT_BRANCH=""
    fi
done <<< "$WORKTREES"

# Display main worktree
if [ -n "$MAIN_WORKTREE" ]; then
    echo -e "$MAIN_WORKTREE"
    echo ""
fi

# Display feature worktrees
if [ -n "$FEATURE_WORKTREES" ]; then
    echo -e "${BLUE}Feature Worktrees:${NC}"
    echo ""
    echo -e "$FEATURE_WORKTREES"
else
    echo -e "${GRAY}No feature worktrees (only main)${NC}"
    echo ""
fi

# Summary
echo -e "${BLUE}═══════════════════════════════════════════════${NC}"
echo -e "Total worktrees: ${CYAN}$WORKTREE_COUNT${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════${NC}"
echo ""

# Tips
if [ $WORKTREE_COUNT -gt 1 ]; then
    echo -e "${GRAY}Tip: Run 'scripts/cleanup_worktrees.sh' to remove old worktrees${NC}"
else
    echo -e "${GRAY}Tip: Run 'scripts/create_worktree.sh' to create a new worktree${NC}"
fi
echo ""
