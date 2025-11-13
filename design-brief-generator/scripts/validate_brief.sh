#!/bin/bash

# Design Brief Validation Script
# Checks design brief completeness and quality

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Check if file provided
if [ $# -lt 1 ]; then
    echo "Usage: $0 <brief_file.md>"
    exit 1
fi

BRIEF_FILE="$1"

# Check if file exists
if [ ! -f "$BRIEF_FILE" ]; then
    echo -e "${RED}✗ Error: File not found: $BRIEF_FILE${NC}"
    exit 1
fi

echo -e "${BLUE}╔════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║       Design Brief Validation Report          ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "File: ${BLUE}$BRIEF_FILE${NC}"
echo ""

# Counters
ISSUES_FOUND=0
WARNINGS=0
CHECKS_PASSED=0

# Function to check section exists
check_section() {
    local section_name="$1"
    local section_pattern="$2"
    local required="$3"

    if grep -q "$section_pattern" "$BRIEF_FILE"; then
        echo -e "${GREEN}✓${NC} $section_name section found"
        ((CHECKS_PASSED++))
        return 0
    else
        if [ "$required" = "true" ]; then
            echo -e "${RED}✗${NC} $section_name section missing (REQUIRED)"
            ((ISSUES_FOUND++))
        else
            echo -e "${YELLOW}⚠${NC} $section_name section missing (recommended)"
            ((WARNINGS++))
        fi
        return 1
    fi
}

echo -e "${BLUE}━━━ Required Sections ━━━${NC}"
echo ""

# Check required sections
check_section "Project Overview" "##.*Project Overview\|##.*Overview" true
check_section "Design Goals" "##.*Design Goals\|##.*Goals.*Objectives" true
check_section "Target Users" "##.*Target Users\|##.*Users" true
check_section "Scope" "##.*Scope" true
check_section "Success Criteria/Metrics" "##.*Success\|##.*Metrics" true

echo ""
echo -e "${BLUE}━━━ Recommended Sections ━━━${NC}"
echo ""

# Check recommended sections
check_section "Design Principles" "##.*Design Principles\|##.*Principles" false
check_section "User Flows" "##.*User Flows\|##.*Flows" false
check_section "Deliverables" "##.*Deliverables" false
check_section "Timeline" "##.*Timeline" false
check_section "Accessibility" "##.*Accessibility\|##.*a11y\|##.*WCAG" false

echo ""
echo -e "${BLUE}━━━ Content Quality Checks ━━━${NC}"
echo ""

# Check for placeholder text
if grep -q "\[.*\]" "$BRIEF_FILE"; then
    echo -e "${YELLOW}⚠${NC} Contains placeholder brackets - fill in all placeholders"
    ((WARNINGS++))
else
    echo -e "${GREEN}✓${NC} No placeholders remaining"
    ((CHECKS_PASSED++))
fi

# Check for TBD/TODO
if grep -qi "TBD\|TODO\|FIXME" "$BRIEF_FILE"; then
    echo -e "${YELLOW}⚠${NC} Contains TBD/TODO markers - resolve open items"
    ((WARNINGS++))
else
    echo -e "${GREEN}✓${NC} No TBD markers"
    ((CHECKS_PASSED++))
fi

# Check for empty sections
if grep -q "^##.*\n\n##" "$BRIEF_FILE"; then
    echo -e "${YELLOW}⚠${NC} Empty sections detected"
    ((WARNINGS++))
else
    echo -e "${GREEN}✓${NC} No empty sections"
    ((CHECKS_PASSED++))
fi

# Check for specific design content
echo ""
echo -e "${BLUE}━━━ Design-Specific Checks ━━━${NC}"
echo ""

# Check for user mentions
if grep -qi "user\|persona" "$BRIEF_FILE"; then
    echo -e "${GREEN}✓${NC} Users/personas mentioned"
    ((CHECKS_PASSED++))
else
    echo -e "${RED}✗${NC} No users or personas defined"
    ((ISSUES_FOUND++))
fi

# Check for success metrics
if grep -qi "metric\|measure\|KPI\|success" "$BRIEF_FILE"; then
    echo -e "${GREEN}✓${NC} Success metrics mentioned"
    ((CHECKS_PASSED++))
else
    echo -e "${RED}✗${NC} Success metrics not clearly defined"
    ((ISSUES_FOUND++))
fi

# Check for accessibility
if grep -qi "accessibility\|a11y\|WCAG" "$BRIEF_FILE"; then
    echo -e "${GREEN}✓${NC} Accessibility considerations included"
    ((CHECKS_PASSED++))
else
    echo -e "${YELLOW}⚠${NC} No accessibility requirements mentioned"
    ((WARNINGS++))
fi

# Check for scope definition
IN_SCOPE=false
OUT_SCOPE=false

if grep -qi "in scope\|in-scope" "$BRIEF_FILE"; then
    echo -e "${GREEN}✓${NC} In-scope defined"
    IN_SCOPE=true
    ((CHECKS_PASSED++))
else
    echo -e "${YELLOW}⚠${NC} In-scope not clearly defined"
    ((WARNINGS++))
fi

if grep -qi "out of scope\|out-of-scope" "$BRIEF_FILE"; then
    echo -e "${GREEN}✓${NC} Out-of-scope defined"
    OUT_SCOPE=true
    ((CHECKS_PASSED++))
else
    echo -e "${YELLOW}⚠${NC} Out-of-scope not defined (prevents scope creep)"
    ((WARNINGS++))
fi

# Check for design principles
if grep -qi "principle\|guideline" "$BRIEF_FILE"; then
    echo -e "${GREEN}✓${NC} Design principles mentioned"
    ((CHECKS_PASSED++))
else
    echo -e "${YELLOW}⚠${NC} Consider adding guiding design principles"
    ((WARNINGS++))
fi

# Document quality
echo ""
echo -e "${BLUE}━━━ Document Quality ━━━${NC}"
echo ""

# Check word count
WORD_COUNT=$(wc -w < "$BRIEF_FILE")
echo -e "Word count: $WORD_COUNT"

if [ "$WORD_COUNT" -lt 400 ]; then
    echo -e "${YELLOW}⚠${NC} Brief seems short (< 400 words)"
    ((WARNINGS++))
elif [ "$WORD_COUNT" -gt 3000 ]; then
    echo -e "${YELLOW}⚠${NC} Brief is very long (> 3000 words) - consider condensing"
    ((WARNINGS++))
else
    echo -e "${GREEN}✓${NC} Brief length appropriate"
    ((CHECKS_PASSED++))
fi

# Check for proper heading structure
if grep -q "^#\s" "$BRIEF_FILE"; then
    echo -e "${GREEN}✓${NC} Proper heading structure"
    ((CHECKS_PASSED++))
else
    echo -e "${YELLOW}⚠${NC} Check heading hierarchy (should start with # not ##)"
    ((WARNINGS++))
fi

# Final Summary
echo ""
echo -e "${BLUE}╔════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║           Validation Summary                   ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "Checks passed:  ${GREEN}$CHECKS_PASSED${NC}"
echo -e "Warnings:       ${YELLOW}$WARNINGS${NC}"
echo -e "Issues found:   ${RED}$ISSUES_FOUND${NC}"
echo ""

# Recommendations
echo -e "${BLUE}━━━ Recommendations ━━━${NC}"
echo ""
echo "1. Ensure all required sections are complete"
echo "2. Fill in all placeholder text marked with [brackets]"
echo "3. Define clear, measurable success criteria"
echo "4. Include accessibility requirements (WCAG level)"
echo "5. Clearly define what's in and out of scope"
echo "6. Add user flows for key interactions"
echo "7. Review with stakeholders before starting design work"
echo ""

# Exit code
if [ "$ISSUES_FOUND" -gt 0 ]; then
    echo -e "${RED}❌ Design brief validation failed${NC}"
    echo -e "   Address $ISSUES_FOUND critical issue(s) before proceeding"
    exit 1
elif [ "$WARNINGS" -gt 0 ]; then
    echo -e "${YELLOW}⚠ Design brief validation passed with warnings${NC}"
    echo -e "   Consider addressing $WARNINGS warning(s) to improve quality"
    exit 0
else
    echo -e "${GREEN}✅ Design brief validation passed!${NC}"
    echo -e "   Brief looks ready for stakeholder review"
    exit 0
fi
