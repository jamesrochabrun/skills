#!/bin/bash

# Query Expert - Performance Analyzer
# Analyze EXPLAIN output and provide optimization recommendations

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

echo ""
echo "╔════════════════════════════════════════════════════════════╗"
echo "║                                                            ║"
echo "║          Query Expert - Performance Analyzer              ║"
echo "║                                                            ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""

print_info "Performance Analysis Guide"
echo ""

cat << 'EOF'
## PostgreSQL EXPLAIN Analysis

### Run EXPLAIN
```sql
EXPLAIN ANALYZE
SELECT * FROM orders WHERE customer_id = 123;
```

### What to Look For:

**Seq Scan (Table Scan) ❌**
→ Reading entire table
→ Fix: Add index on filtered column
→ CREATE INDEX idx_orders_customer ON orders(customer_id);

**Index Scan ✅**
→ Using index efficiently
→ Good performance for specific rows

**Bitmap Heap Scan ✅**
→ Good for returning multiple rows
→ Efficient index usage

**Nested Loop ⚠️**
→ Can be slow with large datasets
→ Consider: Hash Join or Merge Join

**Hash Join ✅**
→ Good for large joins
→ Requires memory

**Cost Numbers**
→ Higher = slower
→ Compare before/after optimization
→ cost=0.00..35.50 rows=10

**Actual Time**
→ Real execution time
→ actual time=0.023..0.156 rows=10 loops=1

---

## MySQL EXPLAIN Analysis

### Run EXPLAIN
```sql
EXPLAIN SELECT * FROM orders WHERE customer_id = 123;
```

### Type Column:

**ALL ❌**
→ Full table scan
→ Fix: Add index

**index ⚠️**
→ Full index scan
→ Better than ALL, but could improve

**range ✅**
→ Index range scan
→ Good for WHERE with >, <, BETWEEN

**ref ✅✅**
→ Index lookup
→ Excellent performance

**eq_ref ✅✅✅**
→ Unique index lookup
→ Best performance

**const ✅✅✅**
→ Constant lookup (primary key)
→ Fastest possible

### Extra Column:

**Using filesort ⚠️**
→ Sorting in memory/disk
→ Fix: Add index on ORDER BY columns

**Using temporary ⚠️**
→ Creating temporary table
→ Fix: Optimize GROUP BY or DISTINCT

**Using index ✅**
→ Covering index (index-only scan)
→ Excellent performance

**Using where ✅**
→ Filtering after read
→ Normal for WHERE clauses

---

## MongoDB Explain Analysis

### Run Explain
```javascript
db.orders.find({ customer_id: 123 }).explain("executionStats")
```

### What to Look For:

**COLLSCAN ❌**
→ Full collection scan
→ Fix: Create index
→ db.orders.createIndex({ customer_id: 1 })

**IXSCAN ✅**
→ Index scan
→ Good performance

**executionTimeMillis**
→ Total execution time
→ < 100ms good, > 1000ms needs optimization

**nReturned vs totalDocsExamined**
→ Efficiency ratio
→ Ideally close to 1:1
→ If totalDocsExamined >> nReturned, add index

**Index Usage**
→ indexName: "customer_id_1" ✅
→ indexName: null ❌ (no index used)

---

## Index Recommendations

### When to Create Index:

1. **WHERE Clause**
   CREATE INDEX idx_table_column ON table(column);

2. **JOIN Columns**
   CREATE INDEX idx_table_join_col ON table(join_column);

3. **ORDER BY**
   CREATE INDEX idx_table_sort ON table(sort_column);

4. **Composite Index (order matters!)**
   CREATE INDEX idx_multi ON table(col1, col2, col3);
   → Works for: col1 | col1,col2 | col1,col2,col3
   → NOT for: col2 | col3 | col2,col3

5. **Covering Index**
   CREATE INDEX idx_covering ON table(filter_col) INCLUDE (select_cols);
   → Index contains all needed columns
   → Fastest possible (index-only scan)

### When NOT to Index:

- Small tables (< 1000 rows)
- Columns with low cardinality (few distinct values)
- Frequently updated columns
- Large text/blob columns

---

## Query Optimization Checklist

Performance Issues:
[ ] Check EXPLAIN plan
[ ] Look for table scans (Seq Scan, ALL, COLLSCAN)
[ ] Identify missing indexes
[ ] Check JOIN types (Nested Loop on large tables)
[ ] Look for filesort or temporary tables
[ ] Verify index usage (Using index)

Optimizations:
[ ] Create indexes on WHERE columns
[ ] Create indexes on JOIN columns  
[ ] Use composite indexes (correct order)
[ ] Add covering indexes for frequent queries
[ ] Use LIMIT to reduce result set
[ ] Avoid SELECT * (select only needed columns)
[ ] Avoid functions on indexed columns
[ ] Use EXISTS instead of IN (subqueries)
[ ] Filter early (before JOIN)
[ ] Use appropriate JOIN type

Monitoring:
[ ] Run EXPLAIN ANALYZE before optimization
[ ] Create indexes
[ ] Run EXPLAIN ANALYZE after optimization
[ ] Compare execution time and cost
[ ] Test with production-like data volume
[ ] Monitor slow query log

---

## Example Optimization

### Before (Slow)
```sql
-- EXPLAIN shows: Seq Scan, cost=1000.00
SELECT * FROM orders WHERE customer_id = 123;
```

### Optimization Steps
```sql
-- 1. Create index
CREATE INDEX idx_orders_customer ON orders(customer_id);

-- 2. Optimize query (avoid SELECT *)
SELECT order_id, total, created_at
FROM orders
WHERE customer_id = 123
ORDER BY created_at DESC
LIMIT 100;

-- 3. Check improvement
EXPLAIN ANALYZE
SELECT order_id, total, created_at
FROM orders
WHERE customer_id = 123
ORDER BY created_at DESC
LIMIT 100;
```

### After (Fast)
```
→ Index Scan using idx_orders_customer
→ cost=0.29..15.50 (95% improvement!)
→ actual time=0.015..0.023
```

---

## Tools

**PostgreSQL:**
- EXPLAIN ANALYZE
- pg_stat_statements extension
- pgBadger (log analyzer)

**MySQL:**
- EXPLAIN
- SHOW PROFILE
- MySQL Workbench Performance Dashboard

**MongoDB:**
- explain("executionStats")
- MongoDB Compass (GUI)
- Database Profiler

---

EOF

print_success "Performance analysis guide displayed"
echo ""
print_info "Next Steps:"
echo "  1. Run EXPLAIN on your slow query"
echo "  2. Identify the bottleneck (table scan, no index, etc.)"
echo "  3. Apply recommended optimization"
echo "  4. Re-run EXPLAIN to verify improvement"
echo "  5. Test with production data volume"
echo ""
