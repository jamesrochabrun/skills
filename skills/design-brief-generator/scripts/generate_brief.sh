#!/bin/bash

# Design Brief Generator
# Interactive workflow for creating design project briefs

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${BLUE}╔════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║     Design Brief Generator                     ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════╝${NC}"
echo ""

# Function to prompt for input
prompt_input() {
    local prompt="$1"
    local var_name="$2"
    local required="$3"

    while true; do
        echo -e "${YELLOW}${prompt}${NC}"
        read -r input

        if [ -n "$input" ]; then
            eval "$var_name='$input'"
            break
        elif [ "$required" != "true" ]; then
            eval "$var_name=''"
            break
        else
            echo -e "${RED}This field is required. Please provide a value.${NC}"
        fi
    done
}

# Gather basic information
echo -e "${GREEN}Step 1: Project Basics${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

prompt_input "Project Name:" PROJECT_NAME true
prompt_input "One-line Description:" DESCRIPTION true
prompt_input "Output Filename (default: ${PROJECT_NAME// /_}_brief.md):" OUTPUT_FILE false

# Set default output file if not provided
if [ -z "$OUTPUT_FILE" ]; then
    OUTPUT_FILE="${PROJECT_NAME// /_}_brief.md"
    OUTPUT_FILE=$(echo "$OUTPUT_FILE" | tr '[:upper:]' '[:lower:]')
fi

echo ""
echo -e "${GREEN}Step 2: Project Context${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

prompt_input "What problem are you solving?" PROBLEM true
prompt_input "Who are the primary users?" PRIMARY_USERS true
prompt_input "What are the business goals?" BUSINESS_GOALS true

echo ""
echo -e "${GREEN}Step 3: Design Goals${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

prompt_input "Primary design goal:" DESIGN_GOAL true
prompt_input "How will you measure success?" SUCCESS_METRICS true

echo ""
echo -e "${GREEN}Step 4: Scope & Constraints${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

prompt_input "What's in scope (platforms, screens, features)?" IN_SCOPE true
prompt_input "What's explicitly out of scope?" OUT_OF_SCOPE false
prompt_input "Key constraints (timeline, tech, budget)?" CONSTRAINTS false

echo ""
echo -e "${GREEN}Step 5: Project Type${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Select project type:"
echo "  1) New feature design"
echo "  2) Redesign"
echo "  3) Design system"
echo "  4) Brand/Visual design"
echo ""

while true; do
    read -p "Enter choice (1-4): " project_type
    case $project_type in
        1) PROJECT_TYPE="New Feature Design"; break;;
        2) PROJECT_TYPE="Redesign"; break;;
        3) PROJECT_TYPE="Design System"; break;;
        4) PROJECT_TYPE="Brand/Visual Design"; break;;
        *) echo -e "${RED}Invalid choice. Please enter 1, 2, 3, or 4.${NC}";;
    esac
done

# Generate brief
echo ""
echo -e "${BLUE}Generating design brief...${NC}"
echo ""

# Create brief from template
cat > "$OUTPUT_FILE" << EOF
# Design Brief: $PROJECT_NAME

**Project Type:** $PROJECT_TYPE
**Designer:** $(whoami)
**Date:** $(date +%Y-%m-%d)
**Last Updated:** $(date +%Y-%m-%d)
**Status:** Draft

---

## Executive Summary

$DESCRIPTION

This design brief outlines the approach for $PROJECT_NAME, addressing the need to $PROBLEM for $PRIMARY_USERS.

---

## Project Overview

### Background

$PROBLEM

### Business Objectives

$BUSINESS_GOALS

### Why Now?

[Add context about timing and strategic importance]

---

## Design Goals & Objectives

### Primary Goal

$DESIGN_GOAL

### Secondary Goals

- [Goal 2]
- [Goal 3]

### Success Criteria

$SUCCESS_METRICS

**Specific Metrics:**
- [Metric 1]: [Target]
- [Metric 2]: [Target]
- [Metric 3]: [Target]

---

## Target Users

### Primary User: $PRIMARY_USERS

**Demographics:**
- Age range: [Range]
- Role/Context: [Description]
- Tech proficiency: [Low/Medium/High]

**User Needs:**
- [Need 1]
- [Need 2]
- [Need 3]

**Pain Points:**
- [Current frustration 1]
- [Current frustration 2]
- [Current frustration 3]

**User Quote:**
_"[Include actual user feedback if available]"_

### Secondary Users

[Add if applicable]

---

## Design Principles

Core principles guiding this project:

1. **[Principle 1]** - [Description]
2. **[Principle 2]** - [Description]
3. **[Principle 3]** - [Description]
4. **[Principle 4]** - [Description]

---

## Scope

### In Scope

$IN_SCOPE

- [Additional scope item]
- [Additional scope item]

### Out of Scope

$OUT_OF_SCOPE

- [Additional exclusion]
- [Future consideration]

### Constraints

$CONSTRAINTS

**Technical Constraints:**
- [Technical limitation]

**Timeline Constraints:**
- [Deadline or milestone]

**Resource Constraints:**
- [Budget, team size, etc.]

---

## Key User Flows

### Flow 1: [Primary User Flow]

1. [Entry point]
2. [Step 1]
3. [Step 2]
4. [Decision point]
5. [Success state]

**Alternative Paths:**
- [Error state]
- [Alternative completion]

### Flow 2: [Secondary Flow]

[Define flow]

---

## Design Requirements

### Visual Design

- Style: [Minimalist/Bold/Playful/etc.]
- Mood: [Professional/Friendly/Energetic/etc.]
- Visual references: [Links to inspiration]

### Interaction Design

- Primary interaction patterns: [Tap/Swipe/Hover/etc.]
- Animations: [Yes/No, what kind]
- Feedback mechanisms: [How system responds]

### Accessibility

- **WCAG Level:** [A/AA/AAA]
- **Required:**
  - [ ] Keyboard navigation
  - [ ] Screen reader support
  - [ ] Color contrast (4.5:1 minimum)
  - [ ] Touch targets (44x44px)
  - [ ] Focus indicators
  - [ ] Alternative text for images

### Responsive Design

- **Platforms:** [Web/iOS/Android]
- **Breakpoints:**
  - Mobile: 320px - 767px
  - Tablet: 768px - 1023px
  - Desktop: 1024px+

---

## Deliverables & Timeline

### Design Deliverables

**Research Phase:**
- [ ] Competitive analysis
- [ ] User research findings (if applicable)
- [ ] Current state analysis (if redesign)

**Design Phase:**
- [ ] User flows
- [ ] Wireframes (low-fi)
- [ ] High-fidelity mockups
- [ ] Interactive prototype
- [ ] Design specifications
- [ ] Component documentation
- [ ] Accessibility annotations

**Handoff Phase:**
- [ ] Developer handoff session
- [ ] Asset export
- [ ] Design QA checklist

### Timeline

| Phase | Duration | Deliverables | Due Date |
|-------|----------|-------------|----------|
| Discovery & Research | [X weeks] | Research, flows | [Date] |
| Wireframes | [X weeks] | Low-fi designs | [Date] |
| High-Fidelity | [X weeks] | Mockups, prototype | [Date] |
| Testing & Iteration | [X weeks] | Refined designs | [Date] |
| Handoff | [X weeks] | Specs, assets | [Date] |

**Key Milestones:**
- [Date]: Design review #1 (wireframes)
- [Date]: Design review #2 (high-fi)
- [Date]: Usability testing
- [Date]: Final design sign-off
- [Date]: Developer handoff

---

## Design Direction

### Visual References

**Inspiration:**
- [Link to mood board]
- [Link to similar products]
- [Link to design explorations]

**What We Like:**
- [Specific element from reference 1]
- [Specific element from reference 2]

**What to Avoid:**
- [Anti-pattern 1]
- [Anti-pattern 2]

---

## Technical Considerations

### Design System

- **Using existing:** [Yes/No, which system]
- **New components needed:** [List]
- **Design tokens:** [Colors, typography, spacing]

### Implementation Notes

- [Technical constraint to consider]
- [Platform-specific considerations]
- [Performance considerations]

---

## Success Metrics

### Usability Testing

**Pre-Launch:**
- [ ] Task success rate: 90%+
- [ ] Time on task: [Target time]
- [ ] SUS score: 75+
- [ ] Accessibility: Zero critical issues

**Test Scenarios:**
1. [Scenario 1]
2. [Scenario 2]
3. [Scenario 3]

### Post-Launch Metrics

**Within 30 days:**
- [Metric 1]: [Target]
- [Metric 2]: [Target]
- [Metric 3]: [Target]

**Within 90 days:**
- [Longer-term metric 1]
- [Longer-term metric 2]

---

## Stakeholders & Roles

| Role | Name | Responsibility | Status |
|------|------|---------------|--------|
| Designer | [Name] | Design execution | Active |
| Design Lead | [Name] | Design approval | Review |
| Product Manager | [Name] | Requirements, priorities | Review |
| Engineering Lead | [Name] | Feasibility, timeline | Review |
| User Researcher | [Name] | Research insights | Support |

**Sign-Off Required:**
- [ ] Design Lead
- [ ] Product Manager
- [ ] Engineering Lead

---

## Risks & Dependencies

### Risks

| Risk | Impact | Mitigation |
|------|--------|-----------|
| [Risk 1] | High/Med/Low | [How to address] |
| [Risk 2] | High/Med/Low | [How to address] |

### Dependencies

- [ ] [Dependency 1: e.g., API availability]
- [ ] [Dependency 2: e.g., Design system update]
- [ ] [Dependency 3]

---

## Open Questions

- [ ] [Question 1]
- [ ] [Question 2]
- [ ] [Question 3]

**Decisions Needed:**
- [ ] [Decision 1] - Owner: [Name], By: [Date]
- [ ] [Decision 2] - Owner: [Name], By: [Date]

---

## References

**Research:**
- [Link to user research]
- [Link to analytics data]

**Design:**
- [Link to Figma file]
- [Link to design system]

**Context:**
- [Link to PRD]
- [Link to technical spec]

---

## Appendix

### Change Log

| Date | Change | Author |
|------|--------|--------|
| $(date +%Y-%m-%d) | Initial draft | $(whoami) |

### Notes

[Additional context, decisions, or important information]

EOF

echo -e "${GREEN}✓ Design brief generated successfully!${NC}"
echo ""
echo -e "Output file: ${BLUE}$OUTPUT_FILE${NC}"
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo "  1. Review and fill in placeholder sections"
echo "  2. Add user flows and design requirements"
echo "  3. Attach visual references or mood boards"
echo "  4. Share with stakeholders for review"
echo "  5. Run validation: scripts/validate_brief.sh $OUTPUT_FILE"
echo ""
echo -e "${GREEN}✓ Done!${NC}"
