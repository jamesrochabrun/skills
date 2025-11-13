#!/bin/bash

# Trading Plan Generation Script
# Interactive workflow for creating comprehensive trading plans

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

# Header
echo -e "${BLUE}╔══════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║         Trading Plan Generator                   ║${NC}"
echo -e "${BLUE}╚══════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${YELLOW}⚠️  IMPORTANT: This generates a framework, not financial advice${NC}"
echo -e "${YELLOW}   Trading involves substantial risk of loss${NC}"
echo ""

# Helper function for prompts
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

# Step 1: Trading Style and Goals
echo -e "${MAGENTA}━━━ Step 1: Trading Style & Goals ━━━${NC}"
echo ""

echo "Select your primary trading style:"
echo "1) Day Trading (close all positions same day)"
echo "2) Swing Trading (hold 2-10 days)"
echo "3) Position Trading (hold weeks to months)"
echo "4) Options Trading (directional or income)"
echo "5) Mix of styles"
echo ""

prompt_input "Enter number (1-5):" STYLE_NUM true

case $STYLE_NUM in
    1) TRADING_STYLE="Day Trading" ;;
    2) TRADING_STYLE="Swing Trading" ;;
    3) TRADING_STYLE="Position Trading" ;;
    4) TRADING_STYLE="Options Trading" ;;
    5) TRADING_STYLE="Mixed Approach" ;;
    *) TRADING_STYLE="Swing Trading" ;;
esac

echo ""
prompt_input "Account size (USD):" ACCOUNT_SIZE true
prompt_input "Monthly return target (%):" MONTHLY_TARGET false
prompt_input "Time commitment (hours/day):" TIME_COMMIT false

# Step 2: Risk Management (CRITICAL)
echo ""
echo -e "${MAGENTA}━━━ Step 2: Risk Management (MOST IMPORTANT) ━━━${NC}"
echo ""

echo "Risk per trade (% of account):"
echo "1) 0.5% (Very Conservative)"
echo "2) 1.0% (Recommended for most)"
echo "3) 2.0% (Aggressive)"
echo "4) Custom"
echo ""

prompt_input "Enter number (1-4):" RISK_NUM true

case $RISK_NUM in
    1) RISK_PER_TRADE="0.5" ;;
    2) RISK_PER_TRADE="1.0" ;;
    3) RISK_PER_TRADE="2.0" ;;
    4) prompt_input "Enter custom risk % (e.g., 1.5):" RISK_PER_TRADE true ;;
    *) RISK_PER_TRADE="1.0" ;;
esac

# Calculate dollar risk
DOLLAR_RISK=$(echo "scale=2; $ACCOUNT_SIZE * $RISK_PER_TRADE / 100" | bc)

echo ""
echo -e "${GREEN}✓ Risk per trade: ${RISK_PER_TRADE}% = \$${DOLLAR_RISK}${NC}"
echo ""

prompt_input "Daily loss limit (% of account):" DAILY_LOSS_LIMIT true
prompt_input "Maximum drawdown before break (% of account):" MAX_DRAWDOWN true

echo ""
echo "Minimum Risk:Reward ratio:"
echo "1) 2:1 (Conservative)"
echo "2) 3:1 (Recommended)"
echo "3) 1.5:1 (Aggressive)"
echo ""

prompt_input "Enter number (1-3):" RR_NUM true

case $RR_NUM in
    1) MIN_RR="2:1" ;;
    2) MIN_RR="3:1" ;;
    3) MIN_RR="1.5:1" ;;
    *) MIN_RR="2:1" ;;
esac

# Step 3: Markets and Instruments
echo ""
echo -e "${MAGENTA}━━━ Step 3: Markets & Instruments ━━━${NC}"
echo ""

echo "Primary market:"
echo "1) US Stocks"
echo "2) Options"
echo "3) Forex"
echo "4) Crypto"
echo "5) Futures"
echo "6) Multiple"
echo ""

prompt_input "Enter number (1-6):" MARKET_NUM true

case $MARKET_NUM in
    1) PRIMARY_MARKET="US Stocks" ;;
    2) PRIMARY_MARKET="Options" ;;
    3) PRIMARY_MARKET="Forex" ;;
    4) PRIMARY_MARKET="Crypto" ;;
    5) PRIMARY_MARKET="Futures" ;;
    6) PRIMARY_MARKET="Multiple markets" ;;
    *) PRIMARY_MARKET="US Stocks" ;;
esac

prompt_input "Sector focus (or 'Any'):" SECTOR_FOCUS false
prompt_input "Minimum liquidity (avg daily volume):" MIN_LIQUIDITY false
prompt_input "Price range preference (e.g., \$20-200):" PRICE_RANGE false

# Step 4: Entry Strategy
echo ""
echo -e "${MAGENTA}━━━ Step 4: Entry Strategy ━━━${NC}"
echo ""

echo "Primary setup type:"
echo "1) Breakouts"
echo "2) Pullbacks/Retracements"
echo "3) Reversals"
echo "4) Pattern completion"
echo "5) Multiple setups"
echo ""

prompt_input "Enter number (1-5):" SETUP_NUM false

case $SETUP_NUM in
    1) SETUP_TYPE="Breakouts" ;;
    2) SETUP_TYPE="Pullbacks/Retracements" ;;
    3) SETUP_TYPE="Reversals" ;;
    4) SETUP_TYPE="Pattern completion" ;;
    5) SETUP_TYPE="Multiple setup types" ;;
    *) SETUP_TYPE="TBD" ;;
esac

prompt_input "Primary timeframe for analysis:" TIMEFRAME false
prompt_input "Required confirmation signals:" CONFIRMATIONS false
prompt_input "Entry order type (Market/Limit):" ORDER_TYPE false

# Step 5: Exit Strategy
echo ""
echo -e "${MAGENTA}━━━ Step 5: Exit Strategy ━━━${NC}"
echo ""

echo "Stop-loss method:"
echo "1) Fixed percentage (e.g., 2% below entry)"
echo "2) Technical level (support/resistance)"
echo "3) ATR-based (1.5x-2x ATR)"
echo "4) Combination"
echo ""

prompt_input "Enter number (1-4):" STOP_NUM true

case $STOP_NUM in
    1) STOP_METHOD="Fixed percentage" ;;
    2) STOP_METHOD="Technical level" ;;
    3) STOP_METHOD="ATR-based" ;;
    4) STOP_METHOD="Combination approach" ;;
    *) STOP_METHOD="Fixed percentage" ;;
esac

echo ""
echo "Take-profit strategy:"
echo "1) Fixed R multiple (e.g., 2R, 3R)"
echo "2) Technical target"
echo "3) Trailing stop"
echo "4) Partial profits (scale out)"
echo ""

prompt_input "Enter number (1-4):" TP_NUM false

case $TP_NUM in
    1) TP_STRATEGY="Fixed R multiple" ;;
    2) TP_STRATEGY="Technical target" ;;
    3) TP_STRATEGY="Trailing stop" ;;
    4) TP_STRATEGY="Partial profits" ;;
    *) TP_STRATEGY="Fixed R multiple" ;;
esac

prompt_input "Do you allow position scaling in/out? (Yes/No):" SCALING false

# Step 6: Psychology and Discipline
echo ""
echo -e "${MAGENTA}━━━ Step 6: Psychology & Discipline ━━━${NC}"
echo ""

prompt_input "Pre-market routine duration (minutes):" ROUTINE_TIME false
prompt_input "Maximum trades per day:" MAX_TRADES_DAY false
prompt_input "Cool-down period after loss (minutes/hours):" COOLDOWN false

echo ""
echo "Conditions when you MUST NOT trade:"
echo "(e.g., 'After 2 losses in a row', 'When tired', 'Before major news')"
echo ""
prompt_input "No-trade condition 1:" NO_TRADE_1 false
prompt_input "No-trade condition 2:" NO_TRADE_2 false
prompt_input "No-trade condition 3:" NO_TRADE_3 false

# Step 7: Performance Tracking
echo ""
echo -e "${MAGENTA}━━━ Step 7: Performance Tracking ━━━${NC}"
echo ""

echo "Trade journal method:"
echo "1) Spreadsheet"
echo "2) Trading platform"
echo "3) Dedicated software"
echo "4) Paper notebook"
echo ""

prompt_input "Enter number (1-4):" JOURNAL_NUM false

case $JOURNAL_NUM in
    1) JOURNAL_METHOD="Spreadsheet" ;;
    2) JOURNAL_METHOD="Trading platform" ;;
    3) JOURNAL_METHOD="Dedicated software (e.g., Edgewonk)" ;;
    4) JOURNAL_METHOD="Paper notebook" ;;
    *) JOURNAL_METHOD="Spreadsheet" ;;
esac

echo ""
echo "Review frequency:"
echo "1) Daily only"
echo "2) Daily + Weekly"
echo "3) Daily + Weekly + Monthly"
echo ""

prompt_input "Enter number (1-3):" REVIEW_NUM false

case $REVIEW_NUM in
    1) REVIEW_FREQ="Daily" ;;
    2) REVIEW_FREQ="Daily and Weekly" ;;
    3) REVIEW_FREQ="Daily, Weekly, and Monthly" ;;
    *) REVIEW_FREQ="Daily and Weekly" ;;
esac

# Generate filename
FILENAME="trading_plan_$(date +%Y%m%d).md"

# Output directory
OUTPUT_DIR="."
if [ ! -z "$1" ]; then
    OUTPUT_DIR="$1"
fi

OUTPUT_FILE="$OUTPUT_DIR/$FILENAME"

# Generate the plan
echo ""
echo -e "${BLUE}Generating your trading plan...${NC}"
echo ""

cat > "$OUTPUT_FILE" << EOF
# Trading Plan

**Created:** $(date +%Y-%m-%d)
**Account Size:** \$${ACCOUNT_SIZE}
**Trading Style:** ${TRADING_STYLE}

---

## ⚠️ CRITICAL DISCLAIMER

This trading plan is a personal framework for managing trading decisions. It does NOT constitute financial advice. Trading involves substantial risk of loss. Only trade with capital you can afford to lose.

---

## 1. Trading Goals & Philosophy

### Financial Goals
- **Account Size:** \$${ACCOUNT_SIZE}
- **Monthly Target:** ${MONTHLY_TARGET:-TBD}%
- **Focus:** Consistent execution over returns

### Time Commitment
- **Daily Time:** ${TIME_COMMIT:-TBD} hours
- **Trading Style:** ${TRADING_STYLE}
- **Market Hours:** [Specify your trading hours]

### Trading Philosophy
[Write your personal trading philosophy - what you believe about markets, why you trade this way, your edge]

**Example:**
"I believe markets trend, and I have an edge in identifying early-stage trends with technical analysis. My success comes from discipline, not prediction. I focus on process over profits."

---

## 2. Risk Management (MOST IMPORTANT)

### Position Sizing Rules

**Risk Per Trade: ${RISK_PER_TRADE}%**
- Maximum risk per position: \$${DOLLAR_RISK}
- NEVER exceed this amount on a single trade
- Calculate position size BEFORE entering

**Position Size Formula:**
\`\`\`
Shares = Risk Amount / (Entry Price - Stop Price)
      = \$${DOLLAR_RISK} / (Entry - Stop)
\`\`\`

**Example:**
- Entry: \$100
- Stop: \$98
- Risk per share: \$2
- Position: \$${DOLLAR_RISK} / \$2 = $(echo "scale=0; $DOLLAR_RISK / 2" | bc) shares

### Daily Loss Limit

**HARD STOP at -${DAILY_LOSS_LIMIT}% daily loss**

- Maximum daily loss: \$$(echo "scale=2; $ACCOUNT_SIZE * $DAILY_LOSS_LIMIT / 100" | bc)
- When hit: STOP TRADING immediately
- Close all positions
- Step away from computer
- Review what went wrong
- Resume next day with clear head

**No exceptions. This rule protects your account.**

### Maximum Drawdown

**Break from trading at -${MAX_DRAWDOWN}% drawdown**

- Stop trading if account drops ${MAX_DRAWDOWN}% from peak
- Take minimum 1 week break
- Paper trade only
- Review all trades
- Identify systematic issues
- Resume only when mentally ready

### Risk:Reward Requirements

**Minimum R:R: ${MIN_RR}**

- Only take trades with ${MIN_RR} or better
- Measure before entry
- If R:R doesn't meet minimum → skip trade
- Quality over quantity

### Stop-Loss Rules

**EVERY trade MUST have a stop-loss**

- **Method:** ${STOP_METHOD}
- Set stop BEFORE entry
- Enter stop order immediately after fill
- NEVER move stop further from entry
- Accept the loss if stopped out

### Position Concentration

**Maximum positions:**
- Day trading: [Specify max concurrent positions]
- Swing trading: [Specify max concurrent positions]
- Maximum sector exposure: [e.g., 30% in any one sector]

---

## 3. Markets & Instruments

### Primary Market
**${PRIMARY_MARKET}**

### Specific Criteria
- **Sector Focus:** ${SECTOR_FOCUS:-Any sector}
- **Minimum Liquidity:** ${MIN_LIQUIDITY:-1M+ shares daily volume}
- **Price Range:** ${PRICE_RANGE:-\$20-500}
- **Market Cap:** [Specify if relevant]

### What I Trade
- [List specific criteria]
- [Examples of ideal stocks/instruments]

### What I DON'T Trade
- [ ] Penny stocks (< \$5)
- [ ] Illiquid stocks (< 500K volume)
- [ ] IPOs in first month
- [ ] Earnings day (specify approach)
- [ ] Biotech binary events
- [ ] [Add other exclusions]

---

## 4. Entry Strategy

### Primary Setup
**${SETUP_TYPE}**

### Setup Criteria

**Must-have conditions:**
1. [Specific technical condition]
2. [Specific technical condition]
3. [Specific technical condition]

**Confirmation signals:**
- ${CONFIRMATIONS:-Volume confirmation, trend alignment}
- [Additional confirmations]

**Timeframes:**
- **Analysis:** ${TIMEFRAME:-Daily}
- **Entry:** [Entry timeframe]
- **Filter:** [Higher timeframe trend]

### Entry Rules

**Order Type:** ${ORDER_TYPE:-Limit order}

**Exact entry trigger:**
1. [Specific price level or signal]
2. [Confirmation requirement]
3. [Additional filters]

**Position sizing:**
- Calculate using formula in Section 2
- Risk: \$${DOLLAR_RISK} per trade
- Size accordingly

**Time restrictions:**
- ${TRADING_STYLE} specific timing
- [e.g., "No entries in first 15 minutes" for day trading]
- [e.g., "No entries Friday afternoon" for swing trading]

---

## 5. Exit Strategy

### Stop-Loss

**Method:** ${STOP_METHOD}

**Rules:**
- Set immediately after entry
- Use stop order (not mental stop)
- NEVER move stop further from entry
- Can move to break-even after [specify when]
- Accept losses without hesitation

**Stop placement:**
- [Specific methodology]
- Example: [Concrete example]

### Take-Profit

**Strategy:** ${TP_STRATEGY}

**Specific targets:**
- Primary target: [e.g., 2R or specific level]
- Secondary target: [if scaling out]
- Trail: [trailing stop method if applicable]

**Scaling out:** ${SCALING:-Not allowed}
- [If yes, specify scale-out rules]

### Trade Management

**When to exit early:**
- [ ] Loss of momentum
- [ ] Reversal pattern
- [ ] Time stop hit (no progress in X days)
- [ ] Market condition change
- [ ] Better opportunity elsewhere

**When to add to position:**
- [ ] ${SCALING} (specify if allowed)

**When to trail stop:**
- [Specific rules]

---

## 6. Market Filters

### When TO Trade

**Market conditions:**
- [ ] Clear trend present
- [ ] Volatility in normal range (e.g., VIX < 30)
- [ ] Volume above average
- [ ] My setups present
- [ ] No major news pending

**Personal conditions:**
- [ ] Well-rested
- [ ] Calm and focused
- [ ] Following plan
- [ ] No external stress
- [ ] Within risk limits

### When NOT TO Trade

**Market conditions:**
- [ ] Choppy, rangebound market
- [ ] Extreme volatility
- [ ] Major news pending (FOMC, etc.)
- [ ] Low volume (holidays)
- [ ] Gap and crap environment

**Personal conditions:**
- ${NO_TRADE_1}
- ${NO_TRADE_2}
- ${NO_TRADE_3}
- [ ] Emotional/tilting
- [ ] Hit daily loss limit
- [ ] Consecutive losses (specify number)

---

## 7. Psychology & Discipline

### Pre-Market Routine

**Time required:** ${ROUTINE_TIME:-30} minutes

**Daily checklist:**
- [ ] Review previous day's trades
- [ ] Check overnight news and catalysts
- [ ] Identify key support/resistance levels
- [ ] Mark potential setups
- [ ] Set risk limits in trading platform
- [ ] Emotional state check (calm and focused?)
- [ ] Hydrated and alert?

### Trading Rules

**Maximum trades per day:** ${MAX_TRADES_DAY:-3-5 trades}

**Cool-down period:** ${COOLDOWN:-30 minutes after any loss}

**Break requirements:**
- After 2 consecutive losses: 1 hour break
- After 3 consecutive losses: Done for the day
- After hitting daily loss limit: Done for the day

### Tilt Recognition

**Warning signs I'm tilting:**
- Increasing position size
- Abandoning stops
- Taking marginal setups
- Checking P&L constantly
- Feeling anxious or desperate
- Anger at market

**When tilting:**
1. Close ALL positions immediately
2. Stop trading for the day
3. Physical activity (walk, gym)
4. Review what triggered it
5. Don't resume until calm

### Emotional State Check

**Before each trade ask:**
- Am I calm and rational?
- Am I following my plan?
- Is this revenge trading?
- Would I take this if starting fresh today?

**If any answer is concerning → SKIP THE TRADE**

---

## 8. Performance Tracking

### Trade Journal

**Method:** ${JOURNAL_METHOD}

**Required for each trade:**
- [ ] Date and time
- [ ] Ticker/symbol
- [ ] Setup type
- [ ] Entry price and size
- [ ] Stop-loss and target
- [ ] Exit price and reason
- [ ] P&L (\$ and %)
- [ ] R multiple (1R, 2R, etc.)
- [ ] Market condition
- [ ] Emotional state (1-10)
- [ ] Mistakes made
- [ ] What I did right
- [ ] Lessons learned
- [ ] Screenshot of chart

### Metrics to Track

**Weekly:**
- Total P&L
- Win rate
- Average win vs average loss
- Profit factor
- Best trade
- Worst trade
- Rule compliance %

**Monthly:**
- All weekly metrics
- Maximum drawdown
- Sharpe ratio
- Expectancy
- Number of trades
- Best setup type
- Time-of-day analysis

### Review Schedule

**${REVIEW_FREQ}**

**Daily Review (15 minutes):**
- Review all trades
- Calculate P&L
- Note rule violations
- Identify improvements
- Plan for next day

**Weekly Review (30 minutes):**
- Calculate weekly metrics
- Identify patterns (what works/doesn't)
- Best and worst trades analysis
- Rule compliance check
- Adjustments needed?

**Monthly Review (1 hour):**
- Full performance analysis
- Goal progress check
- Strategy refinement
- Mindset and discipline assessment
- Plan for next month

---

## 9. Plan Compliance

### Rules I Will NEVER Break

1. **NEVER trade without a stop-loss**
2. **NEVER risk more than ${RISK_PER_TRADE}% per trade**
3. **NEVER trade past daily loss limit (-${DAILY_LOSS_LIMIT}%)**
4. **NEVER move stops further from entry**
5. **NEVER add to losing positions**
6. **NEVER trade when emotional**
7. **NEVER skip the trade journal**

### Accountability

**How I'll stay accountable:**
- [ ] Trading journal review
- [ ] Weekly performance check
- [ ] Trading buddy/mentor check-ins
- [ ] [Other accountability measures]

**Consequences for breaking rules:**
- 1 violation: Document why and how to prevent
- 2 violations in a week: Reduce size 50%
- 3 violations: Paper trade only for 1 week

---

## 10. Plan Evolution

### When to Review This Plan
- Monthly minimum
- After major changes in performance
- After strategy adjustments
- After market regime change

### When to Adjust This Plan
- Consistent profitability → consider increasing risk slightly
- Consistent losses → reduce risk, review everything
- Market conditions change → adapt filters
- Personal circumstances change → adjust time commitment

### What Never Changes
- Risk management discipline
- Trade journal requirement
- Stop-loss mandate
- Daily loss limit

---

## Appendix A: Position Size Calculator

**Quick reference:**

| Entry - Stop | Position Size (for \$${DOLLAR_RISK} risk) |
|--------------|-------------------------------------------|
| \$1 | $(echo "scale=0; $DOLLAR_RISK / 1" | bc) shares |
| \$2 | $(echo "scale=0; $DOLLAR_RISK / 2" | bc) shares |
| \$3 | $(echo "scale=0; $DOLLAR_RISK / 3" | bc) shares |
| \$5 | $(echo "scale=0; $DOLLAR_RISK / 5" | bc) shares |

**Formula:** Shares = \$${DOLLAR_RISK} / (Entry - Stop)

---

## Appendix B: Trade Checklist

**Before EVERY trade:**
- [ ] Setup matches my criteria
- [ ] R:R is ${MIN_RR} or better
- [ ] Position size calculated (risk = \$${DOLLAR_RISK})
- [ ] Stop-loss level identified
- [ ] Within daily loss limit
- [ ] Emotional state good
- [ ] Market conditions favorable
- [ ] No news pending
- [ ] Have clear exit plan

**If ANY box unchecked → DON'T TAKE THE TRADE**

---

## Appendix C: Resources

**Recommended reading:**
- "Trading in the Zone" - Mark Douglas
- "The New Trading for a Living" - Alexander Elder
- "Reminiscences of a Stock Operator" - Edwin Lefèvre

**Tools:**
- Trading platform: [Your platform]
- Charting: [Your charting software]
- Journal: ${JOURNAL_METHOD}
- Screener: [Your screener]

---

## Commitment

I commit to following this trading plan with discipline and consistency. I understand that success comes from process, not individual trades. I will track my performance, learn from mistakes, and continuously improve.

**Signed:** ___________________
**Date:** $(date +%Y-%m-%d)

---

## Plan Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | $(date +%Y-%m-%d) | Initial plan created |

EOF

echo -e "${GREEN}✅ Trading plan generated successfully!${NC}"
echo ""
echo -e "File location: ${BLUE}$OUTPUT_FILE${NC}"
echo ""
echo -e "${YELLOW}━━━ CRITICAL NEXT STEPS ━━━${NC}"
echo ""
echo "1. ${GREEN}READ${NC} the entire plan carefully"
echo "2. ${GREEN}CUSTOMIZE${NC} the [TBD] sections with your specifics"
echo "3. ${GREEN}COMMIT${NC} to following it (sign and date)"
echo "4. ${GREEN}PRINT${NC} and keep it visible while trading"
echo "5. ${GREEN}REVIEW${NC} before every trading session"
echo "6. ${GREEN}TRACK${NC} your compliance daily"
echo ""
echo -e "${RED}⚠️  Remember:${NC}"
echo "   • Trading involves substantial risk"
echo "   • This plan doesn't guarantee profits"
echo "   • Discipline is everything"
echo "   • Protect your capital FIRST"
echo ""
echo -e "${CYAN}Tip: Use validate_plan.sh to check completeness${NC}"
echo ""
