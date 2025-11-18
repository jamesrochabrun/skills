#!/bin/bash

# Position Size Calculator
# Quick calculator for trading position sizes

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${BLUE}╔══════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║         Position Size Calculator                 ║${NC}"
echo -e "${BLUE}╚══════════════════════════════════════════════════╝${NC}"
echo ""

# Get inputs
read -p "$(echo -e ${CYAN}"Account size (\$): "${NC})" ACCOUNT_SIZE
read -p "$(echo -e ${CYAN}"Risk per trade (%): "${NC})" RISK_PERCENT
read -p "$(echo -e ${CYAN}"Entry price (\$): "${NC})" ENTRY_PRICE
read -p "$(echo -e ${CYAN}"Stop-loss price (\$): "${NC})" STOP_PRICE

# Calculate
RISK_AMOUNT=$(echo "scale=2; $ACCOUNT_SIZE * $RISK_PERCENT / 100" | bc)
RISK_PER_SHARE=$(echo "scale=4; $ENTRY_PRICE - $STOP_PRICE" | bc)

if (( $(echo "$RISK_PER_SHARE <= 0" | bc -l) )); then
    echo -e "${RED}Error: Stop price must be below entry price${NC}"
    exit 1
fi

POSITION_SIZE=$(echo "scale=0; $RISK_AMOUNT / $RISK_PER_SHARE" | bc)
POSITION_VALUE=$(echo "scale=2; $POSITION_SIZE * $ENTRY_PRICE" | bc)
PERCENT_OF_ACCOUNT=$(echo "scale=2; $POSITION_VALUE / $ACCOUNT_SIZE * 100" | bc)

# Calculate R multiples
TARGET_2R=$(echo "scale=2; $ENTRY_PRICE + ($RISK_PER_SHARE * 2)" | bc)
TARGET_3R=$(echo "scale=2; $ENTRY_PRICE + ($RISK_PER_SHARE * 3)" | bc)

echo ""
echo -e "${BLUE}━━━ Position Size Calculation ━━━${NC}"
echo ""
echo -e "Risk Amount:       ${GREEN}\$${RISK_AMOUNT}${NC} (${RISK_PERCENT}% of account)"
echo -e "Risk Per Share:    \$${RISK_PER_SHARE}"
echo ""
echo -e "${YELLOW}POSITION SIZE:     ${POSITION_SIZE} shares${NC}"
echo ""
echo -e "Position Value:    \$${POSITION_VALUE}"
echo -e "% of Account:      ${PERCENT_OF_ACCOUNT}%"
echo ""

# Warnings
if (( $(echo "$PERCENT_OF_ACCOUNT > 50" | bc -l) )); then
    echo -e "${RED}⚠️  WARNING: Position is ${PERCENT_OF_ACCOUNT}% of account${NC}"
    echo -e "${RED}   This is high concentration - ensure this is intentional${NC}"
    echo ""
fi

echo -e "${BLUE}━━━ Profit Targets (R Multiples) ━━━${NC}"
echo ""
echo -e "2R Target:         \$${TARGET_2R} = ${GREEN}\$$(echo "scale=2; $RISK_AMOUNT * 2" | bc)${NC} profit"
echo -e "3R Target:         \$${TARGET_3R} = ${GREEN}\$$(echo "scale=2; $RISK_AMOUNT * 3" | bc)${NC} profit"
echo ""

echo -e "${BLUE}━━━ Risk:Reward Analysis ━━━${NC}"
echo ""

# Optional: Ask for target price
read -p "$(echo -e ${CYAN}"Enter target price (or press Enter to skip): "${NC})" TARGET_PRICE

if [ -n "$TARGET_PRICE" ]; then
    REWARD=$(echo "scale=2; ($TARGET_PRICE - $ENTRY_PRICE) * $POSITION_SIZE" | bc)
    RR_RATIO=$(echo "scale=2; $REWARD / $RISK_AMOUNT" | bc)
    
    echo ""
    echo -e "Entry:             \$${ENTRY_PRICE}"
    echo -e "Target:            \$${TARGET_PRICE}"
    echo -e "Stop:              \$${STOP_PRICE}"
    echo ""
    echo -e "Potential Reward:  ${GREEN}\$${REWARD}${NC}"
    echo -e "Risk Amount:       ${RED}\$${RISK_AMOUNT}${NC}"
    echo ""
    
    if (( $(echo "$RR_RATIO >= 2" | bc -l) )); then
        echo -e "R:R Ratio:         ${GREEN}${RR_RATIO}:1 ✓${NC}"
        echo -e "   ${GREEN}Good risk:reward ratio${NC}"
    elif (( $(echo "$RR_RATIO >= 1.5" | bc -l) )); then
        echo -e "R:R Ratio:         ${YELLOW}${RR_RATIO}:1${NC}"
        echo -e "   ${YELLOW}Acceptable, but aim for 2:1+${NC}"
    else
        echo -e "R:R Ratio:         ${RED}${RR_RATIO}:1 ✗${NC}"
        echo -e "   ${RED}Poor risk:reward - consider skipping this trade${NC}"
    fi
fi

echo ""
echo -e "${CYAN}━━━ Trade Summary ━━━${NC}"
echo ""
echo "BUY ${POSITION_SIZE} shares at \$${ENTRY_PRICE}"
echo "STOP at \$${STOP_PRICE}"
echo "RISK: \$${RISK_AMOUNT} (${RISK_PERCENT}%)"
echo ""
