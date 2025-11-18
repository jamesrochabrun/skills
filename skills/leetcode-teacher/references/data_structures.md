# Data Structures Reference

Essential data structures for technical interviews with implementation patterns.

## Arrays

**Use when:** Sequential data, random access needed
**Time:** Access O(1), Search O(n), Insert/Delete O(n)
**Space:** O(n)

### Common Patterns
```python
# Reverse
arr[::-1]

# Two pointers
left, right = 0, len(arr) - 1

# Sliding window
for end in range(len(arr)):
    window.add(arr[end])
    if end >= k:
        window.remove(arr[end - k])
```

### Product Example: Instagram Feed
```python
class InstagramFeed:
    def __init__(self):
        self.posts = []  # Array of posts

    def add_post(self, post):
        self.posts.insert(0, post)  # New posts at beginning

    def get_feed(self, start, limit):
        return self.posts[start:start + limit]
```

## Hash Maps

**Use when:** Fast lookups, counting, caching
**Time:** O(1) average for all operations
**Space:** O(n)

### Common Patterns
```python
# Frequency counter
freq = {}
for item in items:
    freq[item] = freq.get(item, 0) + 1

# Two sum
seen = {}
for i, num in enumerate(nums):
    complement = target - num
    if complement in seen:
        return [seen[complement], i]
    seen[num] = i
```

### Product Example: Twitter Hashtags
```python
class TrendingHashtags:
    def __init__(self):
        self.hashtag_count = {}

    def process_tweet(self, tweet):
        for hashtag in tweet.hashtags:
            self.hashtag_count[hashtag] = \
                self.hashtag_count.get(hashtag, 0) + 1

    def get_trending(self, k):
        return sorted(self.hashtag_count.items(),
                     key=lambda x: x[1], reverse=True)[:k]
```

## Linked Lists

**Use when:** Frequent insertions/deletions, unknown size
**Time:** Access O(n), Insert/Delete O(1) at known position
**Space:** O(n)

### Common Patterns
```python
# Fast & slow pointers (detect cycle)
slow = fast = head
while fast and fast.next:
    slow = slow.next
    fast = fast.next.next
    if slow == fast:
        return True

# Reverse linked list
prev = None
curr = head
while curr:
    next_node = curr.next
    curr.next = prev
    prev = curr
    curr = next_node
```

### Product Example: Browser History
```python
class BrowserHistory:
    def __init__(self):
        self.current = None

    def visit(self, url):
        new_page = Page(url)
        new_page.prev = self.current
        if self.current:
            self.current.next = new_page
        self.current = new_page

    def back(self):
        if self.current and self.current.prev:
            self.current = self.current.prev
        return self.current.url

    def forward(self):
        if self.current and self.current.next:
            self.current = self.current.next
        return self.current.url
```

## Stacks

**Use when:** LIFO, backtracking, parsing
**Time:** O(1) for push/pop
**Space:** O(n)

### Common Patterns
```python
# Valid parentheses
stack = []
pairs = {'(': ')', '[': ']', '{': '}'}

for char in s:
    if char in pairs:
        stack.append(char)
    elif not stack or pairs[stack.pop()] != char:
        return False

return len(stack) == 0
```

### Product Example: Code Editor Undo/Redo
```python
class CodeEditor:
    def __init__(self):
        self.undo_stack = []
        self.redo_stack = []
        self.content = ""

    def type(self, text):
        self.undo_stack.append(self.content)
        self.content += text
        self.redo_stack.clear()

    def undo(self):
        if self.undo_stack:
            self.redo_stack.append(self.content)
            self.content = self.undo_stack.pop()

    def redo(self):
        if self.redo_stack:
            self.undo_stack.append(self.content)
            self.content = self.redo_stack.pop()
```

## Queues

**Use when:** FIFO, BFS, scheduling
**Time:** O(1) for enqueue/dequeue
**Space:** O(n)

### Common Patterns
```python
from collections import deque

# BFS
queue = deque([start])
visited = {start}

while queue:
    node = queue.popleft()
    for neighbor in node.neighbors:
        if neighbor not in visited:
            visited.add(neighbor)
            queue.append(neighbor)
```

### Product Example: Uber Request Queue
```python
from collections import deque

class UberQueue:
    def __init__(self):
        self.requests = deque()

    def add_request(self, rider, location):
        self.requests.append({
            'rider': rider,
            'location': location,
            'timestamp': time.time()
        })

    def match_driver(self, driver):
        if self.requests:
            request = self.requests.popleft()
            return request
        return None
```

## Heaps (Priority Queues)

**Use when:** Top K, median, scheduling by priority
**Time:** O(log n) insert/delete, O(1) peek
**Space:** O(n)

### Common Patterns
```python
import heapq

# Top K elements (min heap)
min_heap = []
for num in nums:
    heapq.heappush(min_heap, num)
    if len(min_heap) > k:
        heapq.heappop(min_heap)

# K closest points (max heap with negation)
max_heap = []
for point in points:
    dist = -distance(point)  # Negative for max heap
    heapq.heappush(max_heap, (dist, point))
    if len(max_heap) > k:
        heapq.heappop(max_heap)
```

### Product Example: Uber Driver Matching
```python
import heapq

class UberMatching:
    def __init__(self):
        self.available_drivers = []  # Min heap by distance

    def add_driver(self, driver, distance):
        heapq.heappush(self.available_drivers, (distance, driver))

    def match_closest_driver(self):
        if self.available_drivers:
            distance, driver = heapq.heappop(self.available_drivers)
            return driver
        return None
```

## Trees (Binary Trees)

**Use when:** Hierarchical data, BST operations
**Time:** O(log n) balanced, O(n) worst case
**Space:** O(h) for recursion

### Common Patterns
```python
# Inorder traversal (DFS)
def inorder(root):
    if not root:
        return []
    return inorder(root.left) + [root.val] + inorder(root.right)

# Level order (BFS)
def levelOrder(root):
    if not root:
        return []
    result, queue = [], deque([root])
    while queue:
        level = []
        for _ in range(len(queue)):
            node = queue.popleft()
            level.append(node.val)
            if node.left: queue.append(node.left)
            if node.right: queue.append(node.right)
        result.append(level)
    return result
```

### Product Example: File System
```python
class FileSystem:
    def __init__(self):
        self.root = Directory("/")

    def create_path(self, path):
        parts = path.split("/")[1:]  # Skip empty first element
        current = self.root

        for part in parts:
            if part not in current.children:
                current.children[part] = Directory(part)
            current = current.children[part]

        return current

    def find(self, path):
        parts = path.split("/")[1:]
        current = self.root

        for part in parts:
            if part not in current.children:
                return None
            current = current.children[part]

        return current
```

## Graphs

**Use when:** Networks, relationships, dependencies
**Time:** BFS/DFS O(V + E)
**Space:** O(V + E) for adjacency list

### Common Patterns
```python
# Adjacency list representation
graph = {
    'A': ['B', 'C'],
    'B': ['D'],
    'C': ['D'],
    'D': []
}

# DFS
def dfs(node, visited=set()):
    if node in visited:
        return
    visited.add(node)
    for neighbor in graph[node]:
        dfs(neighbor, visited)

# BFS
def bfs(start):
    visited = {start}
    queue = deque([start])
    while queue:
        node = queue.popleft()
        for neighbor in graph[node]:
            if neighbor not in visited:
                visited.add(neighbor)
                queue.append(neighbor)
```

### Product Example: Social Network
```python
class SocialNetwork:
    def __init__(self):
        self.friends = {}  # user_id -> [friend_ids]

    def add_friendship(self, user1, user2):
        if user1 not in self.friends:
            self.friends[user1] = []
        if user2 not in self.friends:
            self.friends[user2] = []

        self.friends[user1].append(user2)
        self.friends[user2].append(user1)

    def degrees_of_separation(self, user1, user2):
        """BFS to find shortest path"""
        if user1 == user2:
            return 0

        visited = {user1}
        queue = deque([(user1, 0)])

        while queue:
            current, degree = queue.popleft()

            for friend in self.friends.get(current, []):
                if friend == user2:
                    return degree + 1

                if friend not in visited:
                    visited.add(friend)
                    queue.append((friend, degree + 1))

        return -1  # Not connected
```

## Tries (Prefix Trees)

**Use when:** Autocomplete, prefix matching, dictionary
**Time:** O(m) for word length m
**Space:** O(ALPHABET_SIZE * m * n)

### Common Patterns
```python
class TrieNode:
    def __init__(self):
        self.children = {}
        self.is_end = False

class Trie:
    def __init__(self):
        self.root = TrieNode()

    def insert(self, word):
        node = self.root
        for char in word:
            if char not in node.children:
                node.children[char] = TrieNode()
            node = node.children[char]
        node.is_end = True

    def search(self, word):
        node = self.root
        for char in word:
            if char not in node.children:
                return False
            node = node.children[char]
        return node.is_end

    def starts_with(self, prefix):
        node = self.root
        for char in prefix:
            if char not in node.children:
                return False
            node = node.children[char]
        return True
```

### Product Example: Google Search Autocomplete
```python
class Autocomplete:
    def __init__(self):
        self.trie = Trie()
        self.word_frequency = {}

    def add_search(self, query):
        self.trie.insert(query)
        self.word_frequency[query] = \
            self.word_frequency.get(query, 0) + 1

    def get_suggestions(self, prefix):
        suggestions = []

        def dfs(node, current_word):
            if node.is_end:
                suggestions.append(current_word)

            for char, child_node in node.children.items():
                dfs(child_node, current_word + char)

        # Find prefix node
        node = self.trie.root
        for char in prefix:
            if char not in node.children:
                return []
            node = node.children[char]

        # DFS from prefix node
        dfs(node, prefix)

        # Sort by frequency
        return sorted(suggestions,
                     key=lambda x: self.word_frequency.get(x, 0),
                     reverse=True)[:5]
```

## Summary

Master these data structures with their common patterns:
- Arrays: Two pointers, sliding window
- Hash Maps: Frequency, caching
- Linked Lists: Fast/slow pointers
- Stacks: LIFO, parsing
- Queues: FIFO, BFS
- Heaps: Top K, priority
- Trees: DFS, BFS
- Graphs: Traversal, shortest path
- Tries: Prefix operations

Each data structure has specific use cases - choose the right tool for the problem!
