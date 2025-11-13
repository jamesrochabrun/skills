#!/bin/bash

# Trading Plan Validation Script
# Checks trading plan completeness and critical risk management

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

if [ $# -lt 1 ]; then
    echo "Usage: $0 <trading_plan.md>"
    exit 1
fi

PLAN_FILE="$1"

if [ ! -f "$PLAN_FILE" ]; then
    echo -e "${RED}✗ Error: File not found: $PLAN_FILE${NC}"
    exit 1
fi

echo -e "${BLUE}╔════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║     Trading Plan Validation Report            ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "File: ${BLUE}$PLAN_FILE${NC}"
echo ""

CRITICAL_ISSUES=0
WARNINGS=0
PASSED=0

# Function to check section
check_section() {
    local name="$1"
    local pattern="$2"
    local critical="$3"
    
    if grep -qi "$pattern" "$PLAN_FILE"; then
        echo -e "${GREEN}✓${NC} $name"
        ((PASSED++))
        return 0
    else
        if [ "$critical" = "true" ]; then
            echo -e "${RED}✗${NC} $name - CRITICAL MISSING"
            ((CRITICAL_ISSUES++))
        else
            echo -e "${YELLOW}⚠${NC} $name - recommended"
            ((WARNINGS++))
        fi
        return 1
    fi
}

echo -e "${BLUE}━━━ CRITICAL Risk Management (Must Have) ━━━${NC}"
echo ""

check_section "Risk per trade defined" "Risk Per Trade\|risk.*per.*trade" true
check_section "Daily loss limit set" "Daily Loss Limit\|daily.*loss" true
check_section "Stop-loss methodology" "Stop.*Loss.*Rules\|stop.*loss.*method" true
check_section "Position sizing formula" "Position.*Size.*Formula\|position.*sizing" true
check_section "Maximum drawdown limit" "Maximum Drawdown\|max.*drawdown" true

echo ""
echo -e "${BLUE}━━━ Essential Strategy Components ━━━${NC}"
echo ""

check_section "Trading style defined" "Trading Style\|Day Trading\|Swing Trading\|Position Trading" true
check_section "Entry criteria" "Entry.*Strategy\|Entry.*Rules\|Entry.*Criteria" true
check_section "Exit strategy" "Exit.*Strategy\|Take.*Profit\|Profit.*Target" true
check_section "Market selection" "Markets.*Instruments\|What I Trade" true
check_section "Risk:Reward minimum" "Risk.*Reward\|R:R\|RR.*ratio" true

echo ""
echo -e "${BLUE}━━━ Psychology & Discipline ━━━${NC}"
echo ""

check_section "No-trade conditions" "When NOT to Trade\|No.*Trade.*Condition" false
check_section "Pre-market routine" "Pre.*Market.*Routine\|Daily.*checklist" false
check_section "Tilt recognition" "Tilt\|Emotional.*State.*Check" false
check_section "Trade journal plan" "Trade Journal\|Performance Tracking" true

echo ""
echo -e "${BLUE}━━━ Quality Checks ━━━${NC}"
echo ""

# Check for dangerous patterns
if grep -qi "no stop\|without stop\|mental stop" "$PLAN_FILE"; then
    echo -e "${RED}✗${NC} DANGER: References trading without stops"
    ((CRITICAL_ISSUES++))
else
    echo -e "${GREEN}✓${NC} Requires stop-losses"
    ((PASSED++))
fi

# Check risk percentage
if grep -Eq "[3-9]\.?[0-9]*%.*risk|risk.*[3-9]\.?[0-9]*%" "$PLAN_FILE"; then
    echo -e "${YELLOW}⚠${NC} Risk per trade >3% detected - very aggressive"
    ((WARNINGS++))
elif grep -Eq "[0-9]+\.?[0-9]*%.*risk|risk.*[0-9]+\.?[0-9]*%" "$PLAN_FILE"; then
    echo -e "${GREEN}✓${NC} Risk percentage defined"
    ((PASSED++))
fi

# Check for TBD placeholders
TBD_COUNT=$(grep -c "TBD\|\[Specify\]\|\[Add\]\|\[List\]" "$PLAN_FILE" || true)
if [ "$TBD_COUNT" -gt 5 ]; then
    echo -e "${YELLOW}⚠${NC} $TBD_COUNT placeholder sections need completion"
    ((WARNINGS++))
elif [ "$TBD_COUNT" -gt 0 ]; then
    echo -e "${GREEN}✓${NC} Most sections completed ($TBD_COUNT placeholders remaining)"
    ((PASSED++))
else
    echo -e "${GREEN}✓${NC} All sections completed"
    ((PASSED++))
fi

# Check for signed commitment
if grep -q "Signed:.*___\|Signed:\s*$" "$PLAN_FILE"; then
    echo -e "${YELLOW}⚠${NC} Plan not signed yet"
    ((WARNINGS++))
else
    echo -e "${GREEN}✓${NC} Plan appears to be committed to"
    ((PASSED++))
fi

echo ""
echo -e "${BLUE}╔════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║              Validation Summary                ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "Checks passed:      ${GREEN}$PASSED${NC}"
echo -e "Warnings:           ${YELLOW}$WARNINGS${NC}"
echo -e "Critical issues:    ${RED}$CRITICAL_ISSUES${NC}"
echo ""

if [ "$CRITICAL_ISSUES" -gt 0 ]; then
    echo -e "${RED}❌ TRADING PLAN VALIDATION FAILED${NC}"
    echo ""
    echo -e "${RED}Critical issues MUST be addressed before trading.${NC}"
    echo ""
    echo "Required sections:"
    echo "  • Risk per trade (0.5-2% recommended)"
    echo "  • Daily loss limit (hard stop)"
    echo "  • Stop-loss methodology (mandatory)"
    echo "  • Position sizing formula"
    echo "  • Entry and exit criteria"
    echo ""
    exit 1
elif [ "$WARNINGS" -gt 3 ]; then
    echo -e "${YELLOW}⚠ Plan validation passed with warnings${NC}"
    echo ""
    echo "Address warnings to improve plan quality:"
    echo "  • Complete TBD sections"
    echo "  • Define no-trade conditions"
    echo "  • Add pre-market routine"
    echo "  • Sign and commit to plan"
    echo ""
    exit 0
else
    echo -e "${GREEN}✅ TRADING PLAN VALIDATION PASSED!${NC}"
    echo ""
    echo "Your plan includes critical risk management components."
    echo ""
    echo -e "${BLUE}Next steps:${NC}"
    echo "  1. Print and keep visible while trading"
    echo "  2. Review before every session"
    echo "  3. Track compliance daily"
    echo "  4. Review/adjust monthly"
    echo ""
    echo -e "${YELLOW}Remember: A plan is only valuable if you follow it.${NC}"
    echo ""
    exit 0
fi
