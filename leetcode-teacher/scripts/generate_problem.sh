#!/bin/bash

# LeetCode Teacher - Problem Generator
# Quick problem generator for specific patterns

set -e

GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

print_success() { echo -e "${GREEN}✓ $1${NC}"; }
print_info() { echo -e "${BLUE}ℹ $1${NC}"; }

echo ""
echo "╔════════════════════════════════════════════════════════════╗"
echo "║        LeetCode Teacher - Quick Problem Generator          ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""

print_info "Generate a coding problem to practice a specific pattern"
echo ""
echo "Examples:"
echo "  ./generate_problem.sh two-pointers easy instagram"
echo "  ./generate_problem.sh sliding-window medium netflix"
echo "  ./generate_problem.sh bfs hard linkedin"
echo ""

PATTERN=${1:-"two-pointers"}
DIFFICULTY=${2:-"easy"}
PRODUCT=${3:-"instagram"}

print_info "Generating: $PATTERN ($DIFFICULTY) - $PRODUCT context"

OUTPUT_FILE="${PATTERN}-${DIFFICULTY}-${PRODUCT}.md"
OUTPUT_DIR="./problems"
mkdir -p "$OUTPUT_DIR"

cat > "$OUTPUT_DIR/$OUTPUT_FILE" << 'EOF'
# PROBLEM_TITLE

**Difficulty:** DIFFICULTY_LEVEL
**Pattern:** PATTERN_NAME
**Product Context:** PRODUCT_NAME
**Topics:** Arrays, Hash Map

## Real Product Scenario

PRODUCT_SCENARIO_DESCRIPTION

## Problem Statement

PROBLEM_DESCRIPTION

**Example 1:**
```
Input: [input_example]
Output: [output_example]
Explanation: [explanation]
```

**Constraints:**
- Constraint 1
- Constraint 2
- Constraint 3

## Pattern Hint

This problem uses the **PATTERN_NAME** pattern.

**Template:**
```python
def solve(input):
    # Pattern-specific template
    pass
```

## Approach

1. **Brute Force:** O(n²) approach
2. **Optimized:** O(n) using PATTERN_NAME

## Solution (Python)

```python
def solution(nums):
    """
    Optimized solution using PATTERN_NAME.

    Time: O(n)
    Space: O(1)
    """
    # Implementation
    pass
```

## Solution (TypeScript)

```typescript
function solution(nums: number[]): number[] {
    // Implementation
}
```

## Complexity Analysis

- **Time:** O(n)
- **Space:** O(1)

## Follow-up

- Can you solve it in one pass?
- What if the input is very large?

---

**Practice Tips:**
1. Draw out the example
2. Identify the pattern
3. Code the brute force
4. Optimize using the pattern template
5. Test with edge cases
EOF

print_success "Problem created: $OUTPUT_DIR/$OUTPUT_FILE"
echo ""
print_info "Next steps:"
echo "  1. Read the problem carefully"
echo "  2. Try solving without looking at hints"
echo "  3. Use generate_playground.sh for interactive coding"
echo ""
