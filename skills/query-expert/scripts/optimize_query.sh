#!/bin/bash

# Query Expert - Query Optimizer
# Analyze and optimize SQL queries

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
NC='\033[0m'

PASS_COUNT=0
WARN_COUNT=0
FAIL_COUNT=0

print_success() {
    echo -e "${GREEN}✓ GOOD${NC} $1"
    ((PASS_COUNT++))
}

print_warning() {
    echo -e "${YELLOW}⚠ IMPROVE${NC} $1"
    ((WARN_COUNT++))
}

print_error() {
    echo -e "${RED}✗ ISSUE${NC} $1"
    ((FAIL_COUNT++))
}

print_info() {
    echo -e "${BLUE}ℹ INFO${NC} $1"
}

print_section() {
    echo ""
    echo -e "${MAGENTA}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${MAGENTA}$1${NC}"
    echo -e "${MAGENTA}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
}

echo ""
echo "╔════════════════════════════════════════════════════════════╗"
echo "║                                                            ║"
echo "║            Query Expert - Query Optimizer                 ║"
echo "║                                                            ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""

if [ -z "$1" ]; then
    print_info "Usage: $0 <query-file.sql>"
    print_info "Example: $0 slow_query.sql"
    exit 1
fi

QUERY_FILE="$1"

if [ ! -f "$QUERY_FILE" ]; then
    echo -e "${RED}File not found: $QUERY_FILE${NC}"
    exit 1
fi

QUERY=$(cat "$QUERY_FILE")

# Section 1: SELECT * Detection
print_section "1. COLUMN SELECTION"

if echo "$QUERY" | grep -qi "SELECT \*"; then
    print_error "Using SELECT * (selects all columns)"
    echo "         Fix: SELECT only needed columns"
    echo "         SELECT user_id, name, email FROM users;"
else
    print_success "Selecting specific columns"
fi

# Section 2: Index Usage
print_section "2. INDEX OPPORTUNITIES"

if echo "$QUERY" | grep -qi "WHERE"; then
    WHERE_COLS=$(echo "$QUERY" | grep -oi "WHERE [^;]*" | grep -o "[a-zA-Z_][a-zA-Z0-9_]*\s*=" | awk '{print $1}')
    
    if [ -n "$WHERE_COLS" ]; then
        print_info "Columns in WHERE clause should have indexes:"
        for col in $WHERE_COLS; do
            echo "         CREATE INDEX idx_table_$col ON table($col);"
        done
    fi
fi

if echo "$QUERY" | grep -qi "JOIN.*ON"; then
    print_info "JOIN columns should have indexes:"
    echo "         CREATE INDEX idx_table_join_col ON table(join_col);"
fi

if echo "$QUERY" | grep -qi "ORDER BY"; then
    print_info "ORDER BY columns benefit from indexes:"
    echo "         Consider composite index with WHERE + ORDER BY columns"
fi

# Section 3: JOIN Analysis
print_section "3. JOIN OPTIMIZATION"

if echo "$QUERY" | grep -qi "LEFT JOIN" && echo "$QUERY" | grep -qi "WHERE"; then
    print_warning "LEFT JOIN with WHERE on right table"
    echo "         Consider using INNER JOIN instead"
fi

if echo "$QUERY" | grep -qi "WHERE.*IN\s*(SELECT"; then
    print_error "Using IN with subquery"
    echo "         Fix: Use EXISTS or JOIN instead"
    echo "         WHERE EXISTS (SELECT 1 FROM ...)"
fi

# Section 4: Function Usage
print_section "4. FUNCTION ON COLUMNS"

if echo "$QUERY" | grep -Eqi "WHERE.*(LOWER|UPPER|SUBSTRING|DATE|YEAR|MONTH)\s*\("; then
    print_error "Function on indexed column in WHERE"
    echo "         Fix: Use functional index or avoid function"
    echo "         CREATE INDEX idx_table_lower_col ON table(LOWER(col));"
fi

# Section 5: DISTINCT Usage
print_section "5. DISTINCT USAGE"

if echo "$QUERY" | grep -qi "SELECT DISTINCT"; then
    print_warning "Using DISTINCT (potentially expensive)"
    echo "         Consider: Is DISTINCT necessary?"
    echo "         Alternative: Use GROUP BY if aggregating"
fi

# Section 6: Subqueries
print_section "6. SUBQUERY OPTIMIZATION"

SUBQUERY_COUNT=$(echo "$QUERY" | grep -oi "SELECT" | wc -l)
if [ "$SUBQUERY_COUNT" -gt 1 ]; then
    if echo "$QUERY" | grep -qi "FROM.*SELECT"; then
        print_info "Contains subqueries - consider CTEs for readability"
        echo "         WITH cte AS (SELECT ...) SELECT ... FROM cte"
    fi
fi

# Section 7: LIMIT Usage
print_section "7. RESULT SET SIZE"

if ! echo "$QUERY" | grep -qi "LIMIT\|TOP\|FETCH FIRST"; then
    print_warning "No LIMIT clause found"
    echo "         Add LIMIT to prevent large result sets"
    echo "         SELECT ... LIMIT 100;"
fi

# Section 8: Sorting
print_section "8. SORTING"

if echo "$QUERY" | grep -qi "ORDER BY"; then
    if ! echo "$QUERY" | grep -qi "LIMIT"; then
        print_warning "ORDER BY without LIMIT"
        echo "         Consider adding LIMIT to reduce sort cost"
    fi
fi

# Summary
echo ""
echo "╔════════════════════════════════════════════════════════════╗"
echo "║                  Optimization Summary                      ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""
echo -e "${GREEN}✓ Good practices:  $PASS_COUNT${NC}"
echo -e "${YELLOW}⚠ Improvements:    $WARN_COUNT${NC}"
echo -e "${RED}✗ Issues found:    $FAIL_COUNT${NC}"
echo ""

TOTAL=$((PASS_COUNT + FAIL_COUNT + WARN_COUNT))
if [ $TOTAL -gt 0 ]; then
    SCORE=$(( ((PASS_COUNT * 2 + WARN_COUNT) * 100) / (TOTAL * 2) ))
    echo "Query Score: $SCORE%"
    echo ""
fi

print_info "Recommended Next Steps:"
echo "  1. Run EXPLAIN ANALYZE on this query"
echo "  2. Create recommended indexes"
echo "  3. Test query performance before/after"
echo "  4. Monitor query in production"
echo ""

print_info "EXPLAIN Commands:"
echo "  PostgreSQL: EXPLAIN ANALYZE <query>"
echo "  MySQL:      EXPLAIN <query>"
echo "  MongoDB:    db.collection.find().explain('executionStats')"
echo ""

[ $FAIL_COUNT -gt 0 ] && exit 1 || exit 0
