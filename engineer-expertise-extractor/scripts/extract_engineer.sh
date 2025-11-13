#!/bin/bash

# Engineer Expertise Extractor
# Research and document an engineer's coding style, patterns, and best practices

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${BLUE}╔══════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║      Engineer Expertise Extractor                ║${NC}"
echo -e "${BLUE}╚══════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${YELLOW}Extract coding style, patterns, and best practices from GitHub${NC}"
echo ""

# Check for gh CLI
if ! command -v gh &> /dev/null; then
    echo -e "${RED}Error: GitHub CLI (gh) is not installed${NC}"
    echo "Install from: https://cli.github.com/"
    exit 1
fi

# Check authentication
if ! gh auth status &> /dev/null; then
    echo -e "${RED}Error: Not authenticated with GitHub CLI${NC}"
    echo "Run: gh auth login"
    exit 1
fi

# Helper function
prompt_input() {
    local prompt_text="$1"
    local var_name="$2"
    local required="$3"

    while true; do
        echo -e "${CYAN}${prompt_text}${NC}"
        read -r input

        if [ -n "$input" ]; then
            eval "$var_name=\"$input\""
            break
        elif [ "$required" != "true" ]; then
            eval "$var_name=\"\""
            break
        else
            echo -e "${RED}This field is required.${NC}"
        fi
    done
}

# Step 1: Engineer Info
echo -e "${MAGENTA}━━━ Step 1: Engineer Information ━━━${NC}"
echo ""

prompt_input "GitHub username to research:" ENGINEER_USERNAME true

# Verify user exists
echo -e "${BLUE}Verifying GitHub user...${NC}"
if ! gh api users/$ENGINEER_USERNAME > /dev/null 2>&1; then
    echo -e "${RED}Error: GitHub user '$ENGINEER_USERNAME' not found${NC}"
    exit 1
fi

# Get user info
USER_INFO=$(gh api users/$ENGINEER_USERNAME)
USER_NAME=$(echo "$USER_INFO" | grep '"name"' | cut -d'"' -f4)
USER_BIO=$(echo "$USER_INFO" | grep '"bio"' | cut -d'"' -f4)

echo -e "${GREEN}✓ Found: $USER_NAME${NC}"
[ -n "$USER_BIO" ] && echo -e "  Bio: $USER_BIO"
echo ""

# Step 2: Scope
echo -e "${MAGENTA}━━━ Step 2: Research Scope ━━━${NC}"
echo ""

prompt_input "Organization to focus on (or 'all'):" ORG_FILTER false
ORG_FILTER=${ORG_FILTER:-all}

echo ""
echo "How many PRs to analyze?"
echo "1) Recent 20 (quick scan)"
echo "2) Recent 50 (good coverage)"
echo "3) Recent 100 (comprehensive)"
echo "4) Custom"
echo ""

prompt_input "Select (1-4):" PR_COUNT_NUM true

case $PR_COUNT_NUM in
    1) PR_LIMIT=20 ;;
    2) PR_LIMIT=50 ;;
    3) PR_LIMIT=100 ;;
    4) prompt_input "Enter custom number:" PR_LIMIT true ;;
    *) PR_LIMIT=50 ;;
esac

# Step 3: Focus Areas
echo ""
echo -e "${MAGENTA}━━━ Step 3: Focus Areas ━━━${NC}"
echo ""

echo "What to extract? (y/n for each)"
echo ""

prompt_input "Extract coding style? (y/n):" EXTRACT_STYLE false
EXTRACT_STYLE=${EXTRACT_STYLE:-y}

prompt_input "Extract common patterns? (y/n):" EXTRACT_PATTERNS false
EXTRACT_PATTERNS=${EXTRACT_PATTERNS:-y}

prompt_input "Extract best practices? (y/n):" EXTRACT_PRACTICES false
EXTRACT_PRACTICES=${EXTRACT_PRACTICES:-y}

prompt_input "Extract code review style? (y/n):" EXTRACT_REVIEWS false
EXTRACT_REVIEWS=${EXTRACT_REVIEWS:-y}

prompt_input "Extract architectural decisions? (y/n):" EXTRACT_ARCH false
EXTRACT_ARCH=${EXTRACT_ARCH:-y}

# Create output directory
OUTPUT_DIR="engineer_profiles/${ENGINEER_USERNAME}"
mkdir -p "$OUTPUT_DIR"
mkdir -p "$OUTPUT_DIR/coding_style"
mkdir -p "$OUTPUT_DIR/patterns"
mkdir -p "$OUTPUT_DIR/best_practices"
mkdir -p "$OUTPUT_DIR/architecture"
mkdir -p "$OUTPUT_DIR/code_review"
mkdir -p "$OUTPUT_DIR/examples/notable_prs"
mkdir -p "$OUTPUT_DIR/raw_data"

echo ""
echo -e "${BLUE}━━━ Starting Extraction ━━━${NC}"
echo ""

# Step 4: Fetch Pull Requests
echo -e "${YELLOW}Fetching pull requests...${NC}"

# Build search query
SEARCH_QUERY="is:pr author:$ENGINEER_USERNAME"
if [ "$ORG_FILTER" != "all" ]; then
    SEARCH_QUERY="$SEARCH_QUERY org:$ORG_FILTER"
fi

# Fetch PRs
echo "Query: $SEARCH_QUERY (limit: $PR_LIMIT)"
gh search prs "$SEARCH_QUERY" --limit $PR_LIMIT --json number,title,repository,createdAt,state,url > "$OUTPUT_DIR/raw_data/prs.json"

PR_COUNT=$(cat "$OUTPUT_DIR/raw_data/prs.json" | grep -c '"number"' || echo "0")
echo -e "${GREEN}✓ Found $PR_COUNT pull requests${NC}"
echo ""

if [ "$PR_COUNT" -eq 0 ]; then
    echo -e "${RED}No PRs found. Exiting.${NC}"
    exit 1
fi

# Step 5: Analyze PRs
echo -e "${YELLOW}Analyzing pull requests...${NC}"
echo "This may take a while..."
echo ""

# Create PR analysis file
PR_ANALYSIS_FILE="$OUTPUT_DIR/raw_data/pr_analysis.md"
echo "# Pull Request Analysis: $ENGINEER_USERNAME" > "$PR_ANALYSIS_FILE"
echo "" >> "$PR_ANALYSIS_FILE"
echo "Total PRs analyzed: $PR_COUNT" >> "$PR_ANALYSIS_FILE"
echo "Generated: $(date)" >> "$PR_ANALYSIS_FILE"
echo "" >> "$PR_ANALYSIS_FILE"

# Analyze top N PRs in detail (limit to avoid rate limiting)
DETAILED_ANALYSIS_LIMIT=20
if [ "$PR_COUNT" -lt "$DETAILED_ANALYSIS_LIMIT" ]; then
    DETAILED_ANALYSIS_LIMIT=$PR_COUNT
fi

echo "Performing detailed analysis on $DETAILED_ANALYSIS_LIMIT PRs..."

# Extract PR numbers and iterate
cat "$OUTPUT_DIR/raw_data/prs.json" | grep '"number"' | head -$DETAILED_ANALYSIS_LIMIT | while read -r line; do
    PR_NUMBER=$(echo "$line" | grep -o '[0-9]*' | head -1)
    REPO=$(cat "$OUTPUT_DIR/raw_data/prs.json" | grep -B5 "\"number\": $PR_NUMBER" | grep '"nameWithOwner"' | cut -d'"' -f4 | head -1)

    if [ -n "$PR_NUMBER" ] && [ -n "$REPO" ]; then
        echo "  Analyzing PR #$PR_NUMBER in $REPO..."

        # Fetch PR details
        gh pr view $PR_NUMBER --repo $REPO --json title,body,files,comments > "$OUTPUT_DIR/raw_data/pr_${PR_NUMBER}.json" 2>/dev/null || continue

        # Extract to analysis file
        TITLE=$(cat "$OUTPUT_DIR/raw_data/pr_${PR_NUMBER}.json" | grep '"title"' | cut -d'"' -f4)
        echo "## PR #$PR_NUMBER: $TITLE" >> "$PR_ANALYSIS_FILE"
        echo "**Repository:** $REPO" >> "$PR_ANALYSIS_FILE"
        echo "**URL:** https://github.com/$REPO/pull/$PR_NUMBER" >> "$PR_ANALYSIS_FILE"
        echo "" >> "$PR_ANALYSIS_FILE"

        # Get file changes
        FILES_CHANGED=$(cat "$OUTPUT_DIR/raw_data/pr_${PR_NUMBER}.json" | grep '"path"' | wc -l)
        echo "**Files Changed:** $FILES_CHANGED" >> "$PR_ANALYSIS_FILE"

        # List languages (from file extensions)
        cat "$OUTPUT_DIR/raw_data/pr_${PR_NUMBER}.json" | grep '"path"' | grep -o '\.[a-z]*"' | sort | uniq | head -5 >> "$PR_ANALYSIS_FILE"
        echo "" >> "$PR_ANALYSIS_FILE"

        sleep 1  # Rate limiting
    fi
done

echo -e "${GREEN}✓ Detailed analysis complete${NC}"
echo ""

# Step 6: Extract Code Review Comments
if [ "$EXTRACT_REVIEWS" = "y" ]; then
    echo -e "${YELLOW}Extracting code review patterns...${NC}"

    REVIEW_FILE="$OUTPUT_DIR/code_review/review_patterns.md"
    echo "# Code Review Patterns: $ENGINEER_USERNAME" > "$REVIEW_FILE"
    echo "" >> "$REVIEW_FILE"
    echo "Extracted from $PR_COUNT pull requests" >> "$REVIEW_FILE"
    echo "" >> "$REVIEW_FILE"
    echo "## Common Review Comments" >> "$REVIEW_FILE"
    echo "" >> "$REVIEW_FILE"
    echo "[To be populated with actual review comments from PRs where they are reviewer]" >> "$REVIEW_FILE"
    echo "" >> "$REVIEW_FILE"
    echo "## Review Focus Areas" >> "$REVIEW_FILE"
    echo "- Code quality" >> "$REVIEW_FILE"
    echo "- Testing coverage" >> "$REVIEW_FILE"
    echo "- Performance considerations" >> "$REVIEW_FILE"
    echo "- Security practices" >> "$REVIEW_FILE"
    echo "" >> "$REVIEW_FILE"

    echo -e "${GREEN}✓ Review patterns documented${NC}"
fi

# Step 7: Create Profile README
echo ""
echo -e "${YELLOW}Creating profile documentation...${NC}"

README_FILE="$OUTPUT_DIR/README.md"
cat > "$README_FILE" << EOF
# Engineer Profile: $ENGINEER_USERNAME

**Name:** ${USER_NAME:-$ENGINEER_USERNAME}
${USER_BIO:+**Bio:** $USER_BIO}
**GitHub:** https://github.com/$ENGINEER_USERNAME
**Profile Created:** $(date +%Y-%m-%d)
**PRs Analyzed:** $PR_COUNT

---

## Overview

This profile contains extracted coding expertise from analyzing $ENGINEER_USERNAME's GitHub contributions.

## Contents

### 📝 Coding Style
Location: \`coding_style/\`

Documents coding conventions, naming patterns, and formatting preferences.

**Key files:**
- \`naming_conventions.md\` - Variable, function, class naming
- \`code_structure.md\` - File organization and structure
- \`formatting_preferences.md\` - Code formatting style

### 🔧 Patterns
Location: \`patterns/\`

Common solutions, design patterns, and recurring approaches.

**Key files:**
- \`common_solutions.md\` - Frequently used solutions
- \`design_patterns.md\` - Applied design patterns
- \`examples/\` - Code examples

### ✅ Best Practices
Location: \`best_practices/\`

Quality standards, testing approaches, and guidelines.

**Key files:**
- \`code_quality.md\` - Quality standards
- \`testing_approach.md\` - Testing strategy
- \`performance.md\` - Performance practices
- \`security.md\` - Security considerations

### 🏗️ Architecture
Location: \`architecture/\`

Design decisions, technology choices, and system design.

**Key files:**
- \`design_decisions.md\` - Architectural choices
- \`tech_choices.md\` - Technology selections
- \`trade_offs.md\` - Decision trade-offs

### 👀 Code Review
Location: \`code_review/\`

Code review style, common feedback, and review approach.

**Key files:**
- \`feedback_style.md\` - How they provide feedback
- \`common_suggestions.md\` - Recurring suggestions
- \`review_checklist.md\` - What they look for

### 📚 Examples
Location: \`examples/\`

Real code examples from notable pull requests.

**Contents:**
- \`notable_prs/\` - Significant PRs and their patterns

---

## Using This Profile

### For Learning
1. Start with \`coding_style/\` to understand conventions
2. Review \`patterns/\` for common solutions
3. Study \`best_practices/\` for quality standards
4. Read \`examples/\` for real-world applications

### For AI Agents
Provide this profile as context when asking agents to:
- Write code matching this engineer's style
- Review code using their standards
- Apply their patterns and practices
- Make architectural decisions in their approach

**Example prompt:**
\`\`\`
Using the engineer profile at engineer_profiles/$ENGINEER_USERNAME/,
write a user authentication service following their coding style,
patterns, and best practices.
\`\`\`

### For Team Alignment
- Use as reference for team coding standards
- Share patterns for consistency
- Adopt best practices across team
- Train new engineers with real examples

---

## Expertise Areas

Based on analyzed PRs:

EOF

# Extract languages from PR data
echo "### Languages" >> "$README_FILE"
cat "$OUTPUT_DIR/raw_data/prs.json" | grep '"path"' | grep -o '\.[a-z]*"' | sed 's/"//g' | sort | uniq -c | sort -rn | head -10 | while read -r count ext; do
    echo "- $ext files ($count occurrences)" >> "$README_FILE"
done

echo "" >> "$README_FILE"
echo "### Repositories Contributed To" >> "$README_FILE"
cat "$OUTPUT_DIR/raw_data/prs.json" | grep '"nameWithOwner"' | cut -d'"' -f4 | sort | uniq | head -10 | while read -r repo; do
    echo "- $repo" >> "$README_FILE"
done

cat >> "$README_FILE" << EOF

---

## Data Sources

- **Pull Requests:** $PR_COUNT PRs analyzed
- **Time Range:** Most recent contributions
- **Scope:** ${ORG_FILTER:-All repositories}
- **Analysis Date:** $(date +%Y-%m-%d)

---

## Maintenance

### Updating This Profile

\`\`\`bash
./scripts/update_profile.sh $ENGINEER_USERNAME
\`\`\`

### Adding Custom Documentation

Feel free to enhance this profile with:
- Additional examples
- Team-specific practices
- Personal notes and observations
- Meeting discussions and decisions

---

## Notes

This profile is automatically generated from GitHub contributions.
It captures public coding patterns and should be used as a learning
resource and reference, not as a rigid rulebook.

**Privacy:** Only public GitHub contributions are analyzed.
**Accuracy:** Patterns are inferred from code; always verify with engineer.
**Currency:** Update regularly as coding practices evolve.

EOF

echo -e "${GREEN}✓ Profile README created${NC}"

# Step 8: Create Template Files
echo ""
echo -e "${YELLOW}Creating template structure...${NC}"

# Coding Style Templates
cat > "$OUTPUT_DIR/coding_style/naming_conventions.md" << 'EOF'
# Naming Conventions

Based on analysis of pull requests.

## Variables

### General Rules
- Descriptive names preferred
- Avoid abbreviations
- Use camelCase (or language convention)

### Examples
```
// From PR analysis
const userAuthentication = ...  // not ua
const isActive = ...             // boolean prefix
const totalAmount = ...          // clear purpose
```

## Functions

### General Rules
- Verb-first naming
- Single responsibility
- Descriptive of action

### Examples
```
// From PR analysis
getUserById(id)
validateInput(data)
calculateTotal(items)
```

## Classes

### General Rules
- PascalCase
- Noun-based
- Clear purpose

### Examples
```
// From PR analysis
UserService
PaymentProcessor
AuthenticationManager
```

---

**Note:** Fill in with specific patterns found in engineer's code.
EOF

cat > "$OUTPUT_DIR/patterns/common_solutions.md" << 'EOF'
# Common Solutions

Recurring patterns and solutions found in PRs.

## Pattern 1: [To be extracted]

**Problem:** [What problem does this solve]

**Solution:**
```
[Code example from PRs]
```

**Why:** [Reasoning from PR discussions]

**When to use:** [Applicable scenarios]

---

## Pattern 2: [To be extracted]

[Continue documenting patterns found in analysis]

---

**Note:** Populate with actual patterns from PR analysis.
EOF

cat > "$OUTPUT_DIR/best_practices/testing_approach.md" << 'EOF'
# Testing Approach

Testing strategies and patterns extracted from PRs.

## Test Structure

[Document testing patterns from analyzed PRs]

## Coverage Standards

[Extract coverage expectations from PRs]

## Test Types

### Unit Tests
[Patterns found]

### Integration Tests
[Patterns found]

### E2E Tests
[Patterns found]

---

**Note:** Fill in based on test files in analyzed PRs.
EOF

cat > "$OUTPUT_DIR/architecture/design_decisions.md" << 'EOF'
# Design Decisions

Architectural decisions extracted from PRs and discussions.

## Decision Template

### Decision: [Name]

**Context:** [What problem or need]

**Decision:** [What was decided]

**Reasoning:** [Why this approach]

**Alternatives Considered:** [Other options]

**Trade-offs:** [Pros and cons]

**Outcome:** [Results]

---

## Decisions Extracted from PRs

[To be populated with decisions found in PR descriptions and discussions]

---

**Note:** Extract from PR descriptions, discussions, and code comments.
EOF

echo -e "${GREEN}✓ Template files created${NC}"

# Step 9: Generate Summary
echo ""
echo -e "${BLUE}╔════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║          Extraction Complete!                  ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${GREEN}Profile created at: ${BLUE}$OUTPUT_DIR${NC}"
echo ""
echo -e "${YELLOW}━━━ Summary ━━━${NC}"
echo "Engineer: $ENGINEER_USERNAME"
echo "PRs Analyzed: $PR_COUNT"
echo "Detailed Analysis: $DETAILED_ANALYSIS_LIMIT PRs"
echo ""
echo -e "${YELLOW}━━━ Created Structure ━━━${NC}"
echo "├── README.md (profile overview)"
echo "├── coding_style/ (conventions and preferences)"
echo "├── patterns/ (common solutions)"
echo "├── best_practices/ (quality standards)"
echo "├── architecture/ (design decisions)"
echo "├── code_review/ (feedback patterns)"
echo "├── examples/ (code samples)"
echo "└── raw_data/ (source PR data)"
echo ""
echo -e "${CYAN}━━━ Next Steps ━━━${NC}"
echo ""
echo "1. Review the generated profile:"
echo -e "   ${BLUE}cat $OUTPUT_DIR/README.md${NC}"
echo ""
echo "2. Review PR analysis:"
echo -e "   ${BLUE}cat $OUTPUT_DIR/raw_data/pr_analysis.md${NC}"
echo ""
echo "3. Enhance documentation with specific findings:"
echo "   - Add code examples to patterns/"
echo "   - Document specific conventions in coding_style/"
echo "   - Extract best practices from notable PRs"
echo "   - Add architectural decisions from PR discussions"
echo ""
echo "4. Use with AI agents:"
echo -e "   ${BLUE}\"Using engineer_profiles/$ENGINEER_USERNAME/, write code matching their style\"${NC}"
echo ""
echo -e "${YELLOW}💡 Tip: Manually review PRs and add specific examples to strengthen profile${NC}"
echo ""
