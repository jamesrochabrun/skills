# Swift Concurrency Fundamentals

## async/await

An async function is one that might need to pause. Mark it with `async`, and when calling it, use `await` to indicate "pause here until this finishes":

```swift
func fetchUser(id: Int) async throws -> User {
  let url = URL(string: "https://api.example.com/users/\(id)")!
  let (data, _) = try await URLSession.shared.data(from: url)  // Suspends here
  return try JSONDecoder().decode(User.self, from: data)
}

// Calling it
let user = try await fetchUser(id: 123)
// Code here runs after fetchUser completes
```

Code pauses at each `await` - this is called **suspension**. When the work finishes, code resumes right where it left off. Suspension gives Swift the opportunity to do other work while waiting.

**Key insight**: `await` can only be used inside an `async` function.

## Parallel Execution with async let

Sequential awaits are slow - each waits for the previous one to finish:

```swift
// SLOW: Sequential
let avatar = try await fetchImage("avatar.jpg")
let banner = try await fetchImage("banner.jpg")
let bio = try await fetchBio()
```

Use `async let` to run them in parallel:

```swift
func loadProfile() async throws -> Profile {
  async let avatar = fetchImage("avatar.jpg")
  async let banner = fetchImage("banner.jpg")
  async let bio = fetchBio()

  // All three are fetching in parallel!
  return Profile(
    avatar: try await avatar,
    banner: try await banner,
    bio: try await bio
  )
}
```

Each `async let` starts immediately. The `await` collects the results.

## Tasks

A Task is a unit of async work you can manage. It's how you start async code from synchronous code, and it gives you control over that work: wait for its result, cancel it, or let it run in the background.

### The .task Modifier (SwiftUI)

Load data when a view appears. Auto-cancels when the view disappears:

```swift
struct ProfileView: View {
  @State private var avatar: Image?

  var body: some View {
    avatar
      .task { avatar = await downloadAvatar() }
  }
}
```

Reload when a value changes with `.task(id:)`:

```swift
struct ProfileView: View {
  var userID: String
  @State private var avatar: Image?

  var body: some View {
    avatar
      .task(id: userID) { avatar = await downloadAvatar(for: userID) }
  }
}
```

### Manual Task Creation

For user actions:

```swift
Button("Save") {
  Task { await saveProfile() }
}
```

**Important**: `Task { }` inherits isolation from where it's created. Inside a MainActor context, the Task body also runs on MainActor.

### Task.detached

Explicitly opts out of isolation inheritance:

```swift
@MainActor
class ViewModel {
  func doHeavyWork() {
    Task.detached {
      // No actor isolation, runs on cooperative pool
      let result = await self.expensiveCalculation()
      await MainActor.run {
        self.data = result  // Explicitly hop back
      }
    }
  }
}
```

**Warning**: `Task.detached` is usually wrong. It doesn't inherit priority, task-local values, or actor context. Prefer regular `Task` or mark functions `@concurrent` for CPU-intensive work.

## TaskGroup

For dynamic parallel work:

```swift
try await withThrowingTaskGroup(of: Void.self) { group in
  group.addTask { avatar = try await downloadAvatar(for: userID) }
  group.addTask { bio = try await fetchBio(for: userID) }
  group.addTask { stats = try await fetchStats(for: userID) }
  try await group.waitForAll()
}
```

Tasks inside a group are **child tasks**, linked to the parent:

- **Cancellation propagates**: Cancel the parent, and all children get cancelled too
- **Errors**: A thrown error cancels siblings and rethrows (only when you consume results with `next()`, `waitForAll()`, or iteration)
- **Completion order**: Results arrive as tasks finish, not the order you added them
- **Waits for all**: The group doesn't return until every child completes or is cancelled

This is **structured concurrency**: work organized in a tree that's easy to reason about and clean up.

## Cancellation

Tasks can be cancelled. Long-running operations should check:

```swift
func processItems(_ items: [Item]) async throws {
  for item in items {
    try Task.checkCancellation()  // Throws if cancelled
    // or
    guard !Task.isCancelled else { return }  // Check without throwing

    await process(item)
  }
}
```

## Continuations

Bridge callback-based code to async/await:

```swift
func fetchUser(id: Int) async throws -> User {
  try await withCheckedThrowingContinuation { continuation in
    legacyFetchUser(id: id) { result in
      continuation.resume(with: result)
    }
  }
}
```

**Critical**: Resume exactly once. Multiple resumes crash. No resume hangs forever.

Variants:
- `withCheckedContinuation` / `withCheckedThrowingContinuation` - Debug checks
- `withUnsafeContinuation` / `withUnsafeThrowingContinuation` - No checks, faster

## Most Apps Just Wait

Most app code is I/O-bound: fetch data from a network, await a response, decode it, display it. The actual CPU work is minimal. The main thread can handle this fine because `await` suspends without blocking.

CPU-bound work (parsing giant JSON, processing images, complex calculations) is different. It doesn't wait for anything external. If you run it on the main thread, your UI freezes.

**Solution**: Use `@concurrent` (Swift 6.2+) or `Task.detached` for CPU-intensive work.
