#!/bin/bash

# Engineer Skill Creator
# Transform extracted engineer expertise into progressive disclosure skill

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
echo -e "${BLUE}║        Engineer Skill Creator                    ║${NC}"
echo -e "${BLUE}╚══════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${YELLOW}Transform engineer expertise into actionable skill${NC}"
echo ""

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

# Check for profile directory
PROFILES_DIR="engineer_profiles"

if [ ! -d "$PROFILES_DIR" ]; then
    echo -e "${RED}Error: engineer_profiles/ directory not found${NC}"
    echo "Run engineer-expertise-extractor first to create profiles"
    exit 1
fi

# Step 1: Select Engineer Profile
echo -e "${MAGENTA}━━━ Step 1: Select Engineer Profile ━━━${NC}"
echo ""

echo "Available engineer profiles:"
ls -1 "$PROFILES_DIR" 2>/dev/null | nl || echo "No profiles found"
echo ""

if [ -n "$1" ]; then
    ENGINEER_USERNAME="$1"
else
    prompt_input "Engineer username:" ENGINEER_USERNAME true
fi

PROFILE_DIR="$PROFILES_DIR/$ENGINEER_USERNAME"

if [ ! -d "$PROFILE_DIR" ]; then
    echo -e "${RED}Error: Profile not found: $PROFILE_DIR${NC}"
    echo "Available profiles:"
    ls -1 "$PROFILES_DIR"
    exit 1
fi

echo -e "${GREEN}✓ Found profile: $ENGINEER_USERNAME${NC}"

# Read engineer name from profile README
if [ -f "$PROFILE_DIR/README.md" ]; then
    ENGINEER_NAME=$(grep "^**Name:**" "$PROFILE_DIR/README.md" | cut -d: -f2 | xargs || echo "$ENGINEER_USERNAME")
else
    ENGINEER_NAME="$ENGINEER_USERNAME"
fi

echo "  Name: $ENGINEER_NAME"
echo ""

# Step 2: Skill Configuration
echo -e "${MAGENTA}━━━ Step 2: Skill Configuration ━━━${NC}"
echo ""

# Skill name (sanitized)
SKILL_NAME="${ENGINEER_USERNAME}-mentor"
SKILL_NAME=$(echo "$SKILL_NAME" | tr '[:upper:]' '[:lower:]' | tr '_' '-')

prompt_input "Skill name [$SKILL_NAME]:" CUSTOM_SKILL_NAME false
SKILL_NAME="${CUSTOM_SKILL_NAME:-$SKILL_NAME}"

echo ""
echo "Focus areas (leave empty for all):"
prompt_input "Specific areas to include (e.g., 'api,testing,auth'):" FOCUS_AREAS false

# Create output directory
OUTPUT_DIR="expert-skills/$SKILL_NAME"
mkdir -p "$OUTPUT_DIR"
mkdir -p "$OUTPUT_DIR/expertise/by_task"
mkdir -p "$OUTPUT_DIR/expertise/by_language"
mkdir -p "$OUTPUT_DIR/expertise/by_pattern"
mkdir -p "$OUTPUT_DIR/expertise/quick_reference"
mkdir -p "$OUTPUT_DIR/examples"

echo ""
echo -e "${BLUE}━━━ Creating Skill ━━━${NC}"
echo ""

# Step 3: Create Skill README
echo -e "${YELLOW}Generating skill documentation...${NC}"

cat > "$OUTPUT_DIR/SKILL.md" << EOF
---
name: $SKILL_NAME
description: Expert guidance from $ENGINEER_NAME's coding expertise. Progressive disclosure for task-specific patterns, best practices, and real code examples.
---

# $ENGINEER_NAME - Expert Mentor Skill

Learn from $ENGINEER_NAME's proven patterns and best practices. This skill provides progressive disclosure of their expertise, showing only what's relevant for your current task.

## How to Use This Skill

### Quick Query
\`\`\`
"Using this skill, how do I implement [feature]?"
\`\`\`

### Task-Specific
\`\`\`
"Using this skill, show me authentication patterns"
"Using this skill, TypeScript coding style"
"Using this skill, repository pattern implementation"
\`\`\`

### Code Generation
\`\`\`
"Using this skill, write a service following their style"
"Using this skill, review this code using their standards"
\`\`\`

## Expertise Areas

Based on analysis of $ENGINEER_NAME's GitHub contributions:

EOF

# List expertise areas from profile
if [ -d "$PROFILE_DIR/patterns" ]; then
    echo "### Patterns" >> "$OUTPUT_DIR/SKILL.md"
    find "$PROFILE_DIR/patterns" -name "*.md" -type f | while read -r file; do
        basename "$file" .md | sed 's/_/ /g' | sed 's/^/- /' >> "$OUTPUT_DIR/SKILL.md"
    done
    echo "" >> "$OUTPUT_DIR/SKILL.md"
fi

if [ -d "$PROFILE_DIR/best_practices" ]; then
    echo "### Best Practices" >> "$OUTPUT_DIR/SKILL.md"
    find "$PROFILE_DIR/best_practices" -name "*.md" -type f | while read -r file; do
        basename "$file" .md | sed 's/_/ /g' | sed 's/^/- /' >> "$OUTPUT_DIR/SKILL.md"
    done
    echo "" >> "$OUTPUT_DIR/SKILL.md"
fi

cat >> "$OUTPUT_DIR/SKILL.md" << EOF

## Structure

This skill uses **progressive disclosure** - you get only what's needed:

\`\`\`
expertise/
├── by_task/          # Query by what you're building
│   ├── authentication.md
│   ├── api_design.md
│   ├── database_design.md
│   └── testing.md
├── by_language/      # Query by language
│   ├── typescript.md
│   ├── python.md
│   └── [others].md
├── by_pattern/       # Query by design pattern
│   ├── dependency_injection.md
│   ├── repository_pattern.md
│   └── [others].md
└── quick_reference/  # Quick lookups
    ├── coding_style.md
    ├── naming_conventions.md
    └── best_practices.md
\`\`\`

## Interactive Query

Use the query tool for guided navigation:

\`\`\`bash
./query_expertise.sh
\`\`\`

## Examples

Real code examples from their work:

\`\`\`
examples/
├── [language]_examples/
└── [pattern]_examples/
\`\`\`

## Quick Reference

For fast lookups:
- **Coding Style:** expertise/quick_reference/coding_style.md
- **Naming:** expertise/quick_reference/naming_conventions.md
- **Best Practices:** expertise/quick_reference/best_practices.md

## Source

Expertise extracted from: \`engineer_profiles/$ENGINEER_USERNAME/\`

Generated: $(date +%Y-%m-%d)

---

**Use this skill to code like $ENGINEER_NAME - progressive, focused, and effective.**
EOF

echo -e "${GREEN}✓ Skill documentation created${NC}"

# Step 4: Organize by Task
echo -e "${YELLOW}Organizing expertise by task...${NC}"

# Create task-based docs
cat > "$OUTPUT_DIR/expertise/by_task/authentication.md" << 'EOF'
# Authentication & Authorization

## Overview
Authentication and authorization patterns from analyzed code.

## Preferred Approach
[Extract from profile's architecture/ and patterns/ folders]

## Implementation
[Code examples from examples/ folder]

## Testing Strategy
[From best_practices/testing_approach.md]

## Security Considerations
[From best_practices/security.md]

## Examples
See: ../../examples/

---
**Note:** Populate with specific patterns from engineer profile
EOF

cat > "$OUTPUT_DIR/expertise/by_task/api_design.md" << 'EOF'
# API Design

## Overview
API design patterns and conventions.

## REST API Design
[Extract from architecture/ and patterns/]

## Error Handling
[From patterns/error_handling.md]

## Validation
[Input validation patterns]

## Documentation
[API documentation approach]

## Examples
See: ../../examples/

---
**Note:** Populate with specific patterns from engineer profile
EOF

cat > "$OUTPUT_DIR/expertise/by_task/testing.md" << 'EOF'
# Testing Approach

## Overview
Testing strategies and patterns.

## Test Structure
[From best_practices/testing_approach.md]

## Unit Testing
[Unit test patterns]

## Integration Testing
[Integration test patterns]

## Test Coverage
[Coverage standards]

## Examples
See: ../../examples/

---
**Note:** Populate with specific patterns from engineer profile
EOF

echo -e "${GREEN}✓ Task-based organization created${NC}"

# Step 5: Create Quick Reference
echo -e "${YELLOW}Creating quick reference guides...${NC}"

# Copy coding style if available
if [ -f "$PROFILE_DIR/coding_style/naming_conventions.md" ]; then
    cp "$PROFILE_DIR/coding_style/naming_conventions.md" "$OUTPUT_DIR/expertise/quick_reference/"
fi

if [ -f "$PROFILE_DIR/coding_style/code_structure.md" ]; then
    cp "$PROFILE_DIR/coding_style/code_structure.md" "$OUTPUT_DIR/expertise/quick_reference/"
fi

# Create coding style summary
cat > "$OUTPUT_DIR/expertise/quick_reference/coding_style.md" << EOF
# Coding Style - Quick Reference

## Overview
Fast reference for $ENGINEER_NAME's coding conventions.

## Naming Conventions

$([ -f "$PROFILE_DIR/coding_style/naming_conventions.md" ] && cat "$PROFILE_DIR/coding_style/naming_conventions.md" || echo "See full profile for details")

## Code Structure

$([ -f "$PROFILE_DIR/coding_style/code_structure.md" ] && cat "$PROFILE_DIR/coding_style/code_structure.md" || echo "See full profile for details")

## Source
Full details: \`engineer_profiles/$ENGINEER_USERNAME/coding_style/\`

---
Generated: $(date +%Y-%m-%d)
EOF

echo -e "${GREEN}✓ Quick reference created${NC}"

# Step 6: Create Query Tool
echo -e "${YELLOW}Creating interactive query tool...${NC}"

cat > "$OUTPUT_DIR/query_expertise.sh" << 'QUERYEOF'
#!/bin/bash

# Interactive expertise query tool

GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${BLUE}╔══════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║     Expert Guidance Query                       ║${NC}"
echo -e "${BLUE}╚══════════════════════════════════════════════════╝${NC}"
echo ""

echo "What are you working on?"
echo ""
echo "1) Authentication"
echo "2) API Design"
echo "3) Database Design"
echo "4) Testing"
echo "5) Error Handling"
echo "6) Quick Reference (coding style)"
echo "7) Browse all expertise"
echo ""

read -p "Select (1-7): " CHOICE

case $CHOICE in
    1)
        echo ""
        echo -e "${GREEN}=== Authentication Expertise ===${NC}"
        cat expertise/by_task/authentication.md
        ;;
    2)
        echo ""
        echo -e "${GREEN}=== API Design Expertise ===${NC}"
        cat expertise/by_task/api_design.md
        ;;
    3)
        echo ""
        echo -e "${GREEN}=== Database Design Expertise ===${NC}"
        [ -f expertise/by_task/database_design.md ] && cat expertise/by_task/database_design.md || echo "Not available"
        ;;
    4)
        echo ""
        echo -e "${GREEN}=== Testing Expertise ===${NC}"
        cat expertise/by_task/testing.md
        ;;
    5)
        echo ""
        echo -e "${GREEN}=== Error Handling Expertise ===${NC}"
        [ -f expertise/by_task/error_handling.md ] && cat expertise/by_task/error_handling.md || echo "Not available"
        ;;
    6)
        echo ""
        echo -e "${GREEN}=== Quick Reference ===${NC}"
        cat expertise/quick_reference/coding_style.md
        ;;
    7)
        echo ""
        echo -e "${GREEN}=== All Expertise Areas ===${NC}"
        find expertise/ -name "*.md" -type f | sort
        ;;
    *)
        echo "Invalid selection"
        exit 1
        ;;
esac

echo ""
echo -e "${CYAN}━━━ Related Resources ━━━${NC}"
echo "Examples: ./examples/"
echo "Full profile: engineer_profiles/$ENGINEER_USERNAME/"
echo ""
QUERYEOF

chmod +x "$OUTPUT_DIR/query_expertise.sh"

echo -e "${GREEN}✓ Query tool created${NC}"

# Step 7: Copy Examples
echo -e "${YELLOW}Copying code examples...${NC}"

if [ -d "$PROFILE_DIR/examples" ]; then
    cp -r "$PROFILE_DIR/examples/"* "$OUTPUT_DIR/examples/" 2>/dev/null || true
    EXAMPLES_COUNT=$(find "$OUTPUT_DIR/examples" -type f | wc -l)
    echo -e "${GREEN}✓ Copied $EXAMPLES_COUNT example files${NC}"
else
    echo -e "${YELLOW}⚠ No examples found in profile${NC}"
fi

# Step 8: Create Usage Guide
echo -e "${YELLOW}Creating usage guide...${NC}"

cat > "$OUTPUT_DIR/HOW_TO_USE.md" << EOF
# How to Use This Expert Skill

## For AI Agents

### Basic Usage
\`\`\`
"Using the skill at expert-skills/$SKILL_NAME/, help me implement
user authentication"
\`\`\`

### Language-Specific
\`\`\`
"Using expert-skills/$SKILL_NAME/, write a TypeScript service
following their coding style"
\`\`\`

### Pattern-Specific
\`\`\`
"Using expert-skills/$SKILL_NAME/, show me how they implement
the repository pattern"
\`\`\`

### Code Review
\`\`\`
"Using expert-skills/$SKILL_NAME/, review this code using their
standards and best practices"
\`\`\`

## For Humans

### Interactive Query
\`\`\`bash
cd expert-skills/$SKILL_NAME
./query_expertise.sh
\`\`\`

### Browse by Task
\`\`\`bash
cat expertise/by_task/authentication.md
cat expertise/by_task/api_design.md
cat expertise/by_task/testing.md
\`\`\`

### Quick Reference
\`\`\`bash
cat expertise/quick_reference/coding_style.md
cat expertise/quick_reference/naming_conventions.md
\`\`\`

### View Examples
\`\`\`bash
ls examples/
cat examples/[filename]
\`\`\`

## Progressive Disclosure

This skill shows only what you need:

1. **Ask specific question** → Get specific answer
2. **Request by task** → Get task-specific patterns
3. **Query by language** → Get language-specific style
4. **Search by pattern** → Get pattern implementation

## Tips

- Start with quick_reference/ for overview
- Use query tool for guided exploration
- Reference specific tasks for focused guidance
- Check examples/ for real code samples

## Source Profile

Full engineer profile: \`engineer_profiles/$ENGINEER_USERNAME/\`

Last updated: $(date +%Y-%m-%d)
EOF

echo -e "${GREEN}✓ Usage guide created${NC}"

# Step 9: Generate Summary
echo ""
echo -e "${BLUE}╔════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║          Skill Creation Complete!             ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${GREEN}Expert skill created: ${BLUE}$OUTPUT_DIR${NC}"
echo ""
echo -e "${YELLOW}━━━ Skill Details ━━━${NC}"
echo "Skill Name: $SKILL_NAME"
echo "Engineer: $ENGINEER_NAME"
echo "Source Profile: $PROFILE_DIR"
echo ""
echo -e "${YELLOW}━━━ Structure Created ━━━${NC}"
echo "├── SKILL.md (skill documentation)"
echo "├── HOW_TO_USE.md (usage guide)"
echo "├── query_expertise.sh (interactive query)"
echo "├── expertise/"
echo "│   ├── by_task/ (task-specific guidance)"
echo "│   ├── by_language/ (language-specific style)"
echo "│   ├── by_pattern/ (design patterns)"
echo "│   └── quick_reference/ (fast lookups)"
echo "└── examples/ (code samples)"
echo ""
echo -e "${CYAN}━━━ Next Steps ━━━${NC}"
echo ""
echo "1. Review the skill:"
echo -e "   ${BLUE}cat $OUTPUT_DIR/SKILL.md${NC}"
echo ""
echo "2. Test the query tool:"
echo -e "   ${BLUE}cd $OUTPUT_DIR && ./query_expertise.sh${NC}"
echo ""
echo "3. Enhance with profile content:"
echo "   - Populate by_task/ docs with specific patterns"
echo "   - Add language-specific guides to by_language/"
echo "   - Document patterns in by_pattern/"
echo ""
echo "4. Use with AI agents:"
echo -e "   ${BLUE}\"Using expert-skills/$SKILL_NAME/, implement authentication\"${NC}"
echo ""
echo -e "${YELLOW}💡 Tip: The skill provides progressive disclosure - agents get only${NC}"
echo -e "${YELLOW}   what's needed for their specific task${NC}"
echo ""
echo -e "${GREEN}✅ Skill is ready to use!${NC}"
echo ""
