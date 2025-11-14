#!/bin/bash

# Query Expert - Query Generator
# Generate optimized database queries with best practices

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Helper functions
print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

prompt_input() {
    local prompt="$1"
    local var_name="$2"
    local required="${3:-false}"

    while true; do
        echo -e "${BLUE}${prompt}${NC}"
        read -r input

        if [ -z "$input" ] && [ "$required" = true ]; then
            echo -e "${RED}This field is required.${NC}"
            continue
        fi

        eval "$var_name='$input'"
        break
    done
}

prompt_select() {
    local prompt="$1"
    local var_name="$2"
    shift 2
    local options=("$@")

    echo -e "${BLUE}${prompt}${NC}"
    PS3="Select (1-${#options[@]}): "
    select opt in "${options[@]}"; do
        if [ -n "$opt" ]; then
            eval "$var_name='$opt'"
            break
        else
            echo -e "${RED}Invalid selection.${NC}"
        fi
    done
}

# Banner
echo ""
echo "╔════════════════════════════════════════════════════════════╗"
echo "║                                                            ║"
echo "║              Query Expert - Query Generator               ║"
echo "║                                                            ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""

# Step 1: Database Type
print_info "Step 1/5: Database Type"
prompt_select "Which database?" DB_TYPE \
    "PostgreSQL" \
    "MySQL" \
    "SQLite" \
    "SQL Server" \
    "MongoDB" \
    "GraphQL"

# Step 2: Query Type
print_info "Step 2/5: Query Type"

case $DB_TYPE in
    "MongoDB")
        prompt_select "What type of query?" QUERY_TYPE \
            "Find" \
            "Aggregation" \
            "Update" \
            "Insert" \
            "Delete"
        ;;
    "GraphQL")
        prompt_select "What type of query?" QUERY_TYPE \
            "Query" \
            "Mutation" \
            "Subscription"
        ;;
    *)
        prompt_select "What type of query?" QUERY_TYPE \
            "SELECT" \
            "INSERT" \
            "UPDATE" \
            "DELETE" \
            "JOIN" \
            "Aggregate (GROUP BY)" \
            "Window Function" \
            "CTE (WITH)"
        ;;
esac

# Step 3: Table/Collection
print_info "Step 3/5: Target Table/Collection"
if [ "$DB_TYPE" = "MongoDB" ]; then
    prompt_input "Collection name (e.g., users, orders):" TABLE_NAME true
else
    prompt_input "Table name (e.g., users, orders):" TABLE_NAME true
fi

# Step 4: Columns/Fields
print_info "Step 4/5: Columns/Fields"
prompt_input "Columns to select (comma-separated, or * for all):" COLUMNS
COLUMNS=${COLUMNS:-"*"}

# Step 5: Conditions
print_info "Step 5/5: Conditions (optional)"
prompt_input "WHERE conditions (e.g., status = 'active'):" CONDITIONS

# Generate query based on selections
generate_sql_select() {
    cat << EOF

-- Generated SELECT Query
-- Database: $DB_TYPE
-- Optimized for performance

SELECT
    ${COLUMNS//,/,${'\n'}    }
FROM $TABLE_NAME
EOF

    if [ -n "$CONDITIONS" ]; then
        echo "WHERE $CONDITIONS"
    fi

    cat << 'EOF'
-- Optional: Add ORDER BY
-- ORDER BY created_at DESC
-- Optional: Add LIMIT
-- LIMIT 100;
EOF

    echo ""
    print_info "Optimization Tips:"
    echo "  • Select only needed columns (avoid SELECT *)"
    echo "  • Add index on WHERE columns: CREATE INDEX idx_${TABLE_NAME}_${CONDITIONS%% *} ON $TABLE_NAME(${CONDITIONS%% *})"
    echo "  • Use LIMIT for large result sets"
    echo "  • Add ORDER BY for consistent results"
}

generate_sql_join() {
    prompt_input "Second table name:" TABLE2
    prompt_input "JOIN column (e.g., customer_id):" JOIN_COL

    cat << EOF

-- Generated JOIN Query
-- Database: $DB_TYPE

SELECT
    ${TABLE_NAME:0:1}.${COLUMNS//,/,${'\n'}    ${TABLE_NAME:0:1}.}
FROM $TABLE_NAME ${TABLE_NAME:0:1}
INNER JOIN $TABLE2 ${TABLE2:0:1}
    ON ${TABLE_NAME:0:1}.$JOIN_COL = ${TABLE2:0:1}.$JOIN_COL
EOF

    if [ -n "$CONDITIONS" ]; then
        echo "WHERE $CONDITIONS"
    fi

    echo ";"
    echo ""
    print_info "JOIN Types:"
    echo "  • INNER JOIN - Only matching rows"
    echo "  • LEFT JOIN - All left rows + matching right"
    echo "  • RIGHT JOIN - All right rows + matching left"
    echo "  • FULL OUTER JOIN - All rows from both"
    echo ""
    print_info "Optimization:"
    echo "  • Add indexes on JOIN columns"
    echo "  • Filter early with WHERE"
    echo "  • Use INNER JOIN when possible"
}

generate_sql_aggregate() {
    prompt_input "GROUP BY columns (comma-separated):" GROUP_COLS
    prompt_input "Aggregate function (e.g., COUNT(*), SUM(amount)):" AGG_FUNC

    cat << EOF

-- Generated Aggregate Query
-- Database: $DB_TYPE

SELECT
    ${GROUP_COLS//,/,${'\n'}    },
    $AGG_FUNC AS total
FROM $TABLE_NAME
EOF

    if [ -n "$CONDITIONS" ]; then
        echo "WHERE $CONDITIONS"
    fi

    cat << EOF
GROUP BY ${GROUP_COLS//,/,${'\n'}    }
-- Optional: Add HAVING for aggregate filters
-- HAVING COUNT(*) > 10
ORDER BY total DESC;
EOF

    echo ""
    print_info "Aggregate Functions:"
    echo "  • COUNT(*) - Count rows"
    echo "  • SUM(column) - Sum values"
    echo "  • AVG(column) - Average"
    echo "  • MIN/MAX(column) - Min/Max values"
}

generate_sql_cte() {
    cat << EOF

-- Generated CTE (Common Table Expression)
-- Database: $DB_TYPE

WITH ${TABLE_NAME}_filtered AS (
    SELECT
        ${COLUMNS//,/,${'\n'}        }
    FROM $TABLE_NAME
EOF

    if [ -n "$CONDITIONS" ]; then
        echo "    WHERE $CONDITIONS"
    fi

    cat << 'EOF'
)
SELECT *
FROM table_filtered
-- Add JOINs or additional filtering here
;
EOF

    echo ""
    print_info "CTE Benefits:"
    echo "  • Improves readability"
    echo "  • Reusable within same query"
    echo "  • Supports recursion"
    echo "  • Better than subqueries in many cases"
}

generate_mongodb_find() {
    cat << EOF

// Generated MongoDB Find Query
// Collection: $TABLE_NAME

db.$TABLE_NAME.find(
EOF

    if [ -n "$CONDITIONS" ]; then
        echo "    { $CONDITIONS },"
    else
        echo "    {},"
    fi

    if [ "$COLUMNS" != "*" ]; then
        echo "    { ${COLUMNS//,/: 1, }: 1, _id: 0 }"
    else
        echo "    {}"
    fi

    cat << 'EOF'
)
.sort({ created_at: -1 })
.limit(100);
EOF

    echo ""
    print_info "MongoDB Optimization:"
    echo "  • Create index: db.$TABLE_NAME.createIndex({ field: 1 })"
    echo "  • Use projection to limit fields"
    echo "  • Add sort and limit for performance"
    echo "  • Use explain(): .explain('executionStats')"
}

generate_mongodb_aggregation() {
    cat << EOF

// Generated MongoDB Aggregation Pipeline
// Collection: $TABLE_NAME

db.$TABLE_NAME.aggregate([
    // Stage 1: Match (filter)
    { \$match: {
EOF

    if [ -n "$CONDITIONS" ]; then
        echo "        $CONDITIONS"
    fi

    cat << 'EOF'
    }},

    // Stage 2: Group (aggregate)
    { $group: {
        _id: '$field',
        count: { $sum: 1 },
        total: { $sum: '$amount' },
        average: { $avg: '$amount' }
    }},

    // Stage 3: Sort
    { $sort: { total: -1 } },

    // Stage 4: Limit
    { $limit: 10 }
]);
EOF

    echo ""
    print_info "Aggregation Stages:"
    echo "  • \$match - Filter documents"
    echo "  • \$group - Group and aggregate"
    echo "  • \$project - Reshape documents"
    echo "  • \$lookup - JOIN collections"
    echo "  • \$sort - Sort results"
    echo "  • \$limit - Limit results"
}

generate_graphql_query() {
    cat << EOF

# Generated GraphQL Query

query Get${TABLE_NAME^} {
  $TABLE_NAME {
    ${COLUMNS//,/
    }
  }
}

# With variables:
query Get${TABLE_NAME^}(\$id: ID!) {
  ${TABLE_NAME}(id: \$id) {
    ${COLUMNS//,/
    }
  }
}
EOF

    echo ""
    print_info "GraphQL Best Practices:"
    echo "  • Request only needed fields"
    echo "  • Use fragments for reusable fields"
    echo "  • Implement DataLoader to avoid N+1"
    echo "  • Add pagination (first, after)"
}

# Generate based on query type
case $DB_TYPE in
    "MongoDB")
        case $QUERY_TYPE in
            "Find")
                generate_mongodb_find
                ;;
            "Aggregation")
                generate_mongodb_aggregation
                ;;
        esac
        ;;
    "GraphQL")
        generate_graphql_query
        ;;
    *)
        case $QUERY_TYPE in
            "SELECT")
                generate_sql_select
                ;;
            "JOIN")
                generate_sql_join
                ;;
            "Aggregate (GROUP BY)")
                generate_sql_aggregate
                ;;
            "CTE (WITH)")
                generate_sql_cte
                ;;
        esac
        ;;
esac

# Summary
echo ""
echo "╔════════════════════════════════════════════════════════════╗"
echo "║                    Query Generated                         ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""
print_success "Query generated for $DB_TYPE"
print_success "Type: $QUERY_TYPE"
echo ""
print_info "Next steps:"
echo "  1. Review and test the query"
echo "  2. Add appropriate indexes"
echo "  3. Use EXPLAIN to analyze performance"
echo "  4. Add error handling in production"
echo "  5. Monitor query performance"
echo ""
print_info "Performance Tools:"
case $DB_TYPE in
    "PostgreSQL")
        echo "  • EXPLAIN ANALYZE query"
        echo "  • pg_stat_statements extension"
        ;;
    "MySQL")
        echo "  • EXPLAIN query"
        echo "  • SHOW PROFILE"
        ;;
    "MongoDB")
        echo "  • query.explain('executionStats')"
        echo "  • db.collection.getIndexes()"
        ;;
esac
echo ""
