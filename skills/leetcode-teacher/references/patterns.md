# LeetCode Patterns Reference

The 20 essential coding patterns for technical interviews with templates and real product examples.

## Pattern 1: Two Pointers

**When to Use:** Find pairs, triplets, or process sorted arrays
**Time:** O(n), **Space:** O(1)

### Template (Python)
```python
def two_pointers(arr):
    left, right = 0, len(arr) - 1

    while left < right:
        # Process current pair
        if condition:
            # Found solution
            return [left, right]
        elif arr[left] + arr[right] < target:
            left += 1
        else:
            right -= 1

    return []
```

### Real Example: Instagram Mutual Likes
```python
def find_mutual_likes(user_ids, target_sum):
    """Find two users whose IDs sum to target"""
    left, right = 0, len(user_ids) - 1

    while left < right:
        current_sum = user_ids[left] + user_ids[right]

        if current_sum == target_sum:
            return [left, right]
        elif current_sum < target_sum:
            left += 1
        else:
            right -= 1

    return []
```

## Pattern 2: Sliding Window

**When to Use:** Find subarray/substring with property
**Time:** O(n), **Space:** O(k)

### Template (Python)
```python
def sliding_window(arr, k):
    window_start = 0
    max_sum = 0
    window_sum = 0

    for window_end in range(len(arr)):
        window_sum += arr[window_end]

        if window_end >= k - 1:
            max_sum = max(max_sum, window_sum)
            window_sum -= arr[window_start]
            window_start += 1

    return max_sum
```

### Real Example: Twitter Trending Topics
```python
def trending_in_window(tweets, time_window):
    """Find most mentioned hashtag in time window"""
    hashtag_count = {}
    max_count = 0
    trending = ""

    for i, tweet in enumerate(tweets):
        # Add new tweet
        if tweet.hashtag in hashtag_count:
            hashtag_count[tweet.hashtag] += 1
        else:
            hashtag_count[tweet.hashtag] = 1

        # Remove old tweets outside window
        if i >= time_window:
            old_tag = tweets[i - time_window].hashtag
            hashtag_count[old_tag] -= 1
            if hashtag_count[old_tag] == 0:
                del hashtag_count[old_tag]

        # Track max
        for tag, count in hashtag_count.items():
            if count > max_count:
                max_count = count
                trending = tag

    return trending
```

## Pattern 3: Fast & Slow Pointers

**When to Use:** Detect cycles, find middle element
**Time:** O(n), **Space:** O(1)

### Template (Python)
```python
def has_cycle(head):
    slow = fast = head

    while fast and fast.next:
        slow = slow.next
        fast = fast.next.next

        if slow == fast:
            return True

    return False
```

### Real Example: Package Manager Circular Dependency
```python
def detect_circular_dependency(package):
    """Detect if package has circular dependencies"""
    slow = fast = package

    while fast and fast.next_dependency:
        slow = slow.next_dependency
        fast = fast.next_dependency.next_dependency

        if slow == fast:
            return True  # Circular dependency found!

    return False
```

## Pattern 4: Merge Intervals

**When to Use:** Overlapping intervals, scheduling
**Time:** O(n log n), **Space:** O(n)

### Template (Python)
```python
def merge_intervals(intervals):
    if not intervals:
        return []

    intervals.sort(key=lambda x: x[0])
    merged = [intervals[0]]

    for current in intervals[1:]:
        last = merged[-1]

        if current[0] <= last[1]:
            # Overlapping, merge
            merged[-1] = [last[0], max(last[1], current[1])]
        else:
            # Non-overlapping
            merged.append(current)

    return merged
```

### Real Example: Google Calendar Free Slots
```python
def find_free_slots(calendars, duration):
    """Find free meeting slots for all attendees"""
    # Merge all busy times
    busy = []
    for calendar in calendars:
        busy.extend(calendar.busy_times)

    busy.sort()
    merged_busy = merge_intervals(busy)

    # Find gaps >= duration
    free_slots = []
    for i in range(len(merged_busy) - 1):
        gap_start = merged_busy[i][1]
        gap_end = merged_busy[i + 1][0]

        if gap_end - gap_start >= duration:
            free_slots.append([gap_start, gap_end])

    return free_slots
```

## Pattern 5: Binary Search (Modified)

**When to Use:** Search in O(log n), find boundary
**Time:** O(log n), **Space:** O(1)

### Template (Python)
```python
def binary_search_modified(arr, target):
    left, right = 0, len(arr) - 1

    while left <= right:
        mid = (left + right) // 2

        if arr[mid] == target:
            return mid
        elif arr[mid] < target:
            left = mid + 1
        else:
            right = mid - 1

    return -1
```

### Real Example: GitHub Find Bug Introduction Version
```python
def find_first_bad_version(versions):
    """Binary search to find when bug was introduced"""
    left, right = 0, len(versions) - 1
    first_bad = -1

    while left <= right:
        mid = (left + right) // 2

        if is_bad_version(versions[mid]):
            first_bad = mid
            right = mid - 1  # Look for earlier bad version
        else:
            left = mid + 1

    return first_bad
```

## Pattern 6: Top K Elements

**When to Use:** Find top/bottom K items
**Time:** O(n log k), **Space:** O(k)

### Template (Python)
```python
import heapq

def top_k_elements(nums, k):
    # Min heap of size k
    min_heap = []

    for num in nums:
        heapq.heappush(min_heap, num)

        if len(min_heap) > k:
            heapq.heappop(min_heap)

    return min_heap
```

### Real Example: Reddit Top Posts
```python
def get_top_k_posts(posts, k):
    """Get top K posts by upvotes"""
    min_heap = []

    for post in posts:
        heapq.heappush(min_heap, (post.upvotes, post))

        if len(min_heap) > k:
            heapq.heappop(min_heap)

    return [post for (upvotes, post) in sorted(min_heap, reverse=True)]
```

## Pattern 7: BFS (Breadth-First Search)

**When to Use:** Shortest path, level-order traversal
**Time:** O(V + E), **Space:** O(V)

### Template (Python)
```python
from collections import deque

def bfs(root):
    if not root:
        return []

    result = []
    queue = deque([root])

    while queue:
        level_size = len(queue)

        for _ in range(level_size):
            node = queue.popleft()
            result.append(node.val)

            if node.left:
                queue.append(node.left)
            if node.right:
                queue.append(node.right)

    return result
```

### Real Example: LinkedIn Degrees of Connection
```python
def degrees_of_connection(user1, user2):
    """Find shortest connection path between users"""
    if user1 == user2:
        return 0

    visited = {user1}
    queue = deque([(user1, 0)])

    while queue:
        current_user, degree = queue.popleft()

        for connection in current_user.connections:
            if connection == user2:
                return degree + 1

            if connection not in visited:
                visited.add(connection)
                queue.append((connection, degree + 1))

    return -1  # Not connected
```

## Pattern 8: DFS (Depth-First Search)

**When to Use:** Path finding, backtracking
**Time:** O(V + E), **Space:** O(V)

### Template (Python)
```python
def dfs(node, visited=None):
    if visited is None:
        visited = set()

    if node in visited:
        return

    visited.add(node)
    process(node)

    for neighbor in node.neighbors:
        dfs(neighbor, visited)

    return visited
```

### Real Example: File System Path Finding
```python
def find_all_paths(start_dir, target_file):
    """Find all paths to target file"""
    paths = []

    def dfs(current_dir, path):
        if current_dir.name == target_file:
            paths.append(path + [current_dir.name])
            return

        for subdir in current_dir.subdirectories:
            dfs(subdir, path + [current_dir.name])

    dfs(start_dir, [])
    return paths
```

## Pattern 9: Dynamic Programming

**When to Use:** Optimization, counting problems
**Time:** Varies (often O(n²)), **Space:** O(n) or O(n²)

### Template (Python)
```python
def dp_solution(n):
    # Initialize DP array
    dp = [0] * (n + 1)
    dp[0] = base_case

    # Fill DP array
    for i in range(1, n + 1):
        dp[i] = transition(dp[i-1], dp[i-2], ...)

    return dp[n]
```

### Real Example: Minimum Venmo Transactions
```python
def min_transactions(debts):
    """Minimum transactions to settle all debts"""
    # Calculate net balance for each person
    balance = {}
    for payer, payee, amount in debts:
        balance[payer] = balance.get(payer, 0) - amount
        balance[payee] = balance.get(payee, 0) + amount

    # Remove zero balances
    amounts = [v for v in balance.values() if v != 0]

    def dfs(idx):
        # Skip settled accounts
        while idx < len(amounts) and amounts[idx] == 0:
            idx += 1

        if idx == len(amounts):
            return 0

        min_trans = float('inf')

        for i in range(idx + 1, len(amounts)):
            # Try settling idx with i
            if amounts[idx] * amounts[i] < 0:  # Different signs
                amounts[i] += amounts[idx]
                min_trans = min(min_trans, 1 + dfs(idx + 1))
                amounts[i] -= amounts[idx]  # Backtrack

        return min_trans

    return dfs(0)
```

## Pattern 10: Backtracking

**When to Use:** Generate all combinations, permutations
**Time:** Exponential, **Space:** O(n)

### Template (Python)
```python
def backtrack(path, choices):
    if is_solution(path):
        result.append(path[:])
        return

    for choice in choices:
        # Make choice
        path.append(choice)

        # Recurse
        backtrack(path, remaining_choices)

        # Undo choice (backtrack)
        path.pop()
```

### Real Example: Slack Channel Combinations
```python
def generate_team_combinations(members, team_size):
    """Generate all possible teams of given size"""
    teams = []

    def backtrack(start, current_team):
        if len(current_team) == team_size:
            teams.append(current_team[:])
            return

        for i in range(start, len(members)):
            current_team.append(members[i])
            backtrack(i + 1, current_team)
            current_team.pop()

    backtrack(0, [])
    return teams
```

## Summary

Master these 10 core patterns (plus 10 more in advanced practice) and you'll be able to solve 90%+ of LeetCode problems. Focus on:

1. **Recognition**: "I've seen this pattern before"
2. **Template**: "I know the code structure"
3. **Adaptation**: "I can modify for this specific problem"
4. **Optimization**: "I can improve time/space complexity"

Practice each pattern 5-10 times until it becomes second nature!
