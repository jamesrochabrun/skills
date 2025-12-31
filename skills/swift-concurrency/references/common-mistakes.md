# Common Swift Concurrency Mistakes

## Critical Mistakes

### Thinking async = background

```swift
// This STILL blocks the main thread!
@MainActor
func slowFunction() async {
  let result = expensiveCalculation()  // Synchronous work = blocking
  data = result
}
```

`async` means "can pause." The actual work still runs wherever it runs. For CPU-heavy work:

```swift
// Swift 6.2+
@concurrent
func processData() async -> Result {
  expensiveCalculation()
}

// Or use Task.detached (less preferred)
Task.detached {
  let result = expensiveCalculation()
  await MainActor.run { self.data = result }
}
```

### Blocking the Cooperative Thread Pool

```swift
// NEVER do this - risks deadlock
func badIdea() async {
  let semaphore = DispatchSemaphore(value: 0)
  Task {
    await doWork()
    semaphore.signal()
  }
  semaphore.wait()  // Blocks a cooperative thread!
}
```

Swift's cooperative thread pool has limited threads (equal to CPU core count). Blocking one with `DispatchSemaphore`, `DispatchGroup.wait()`, or similar calls can cause deadlocks.

**Solution**: Stay fully async. Use `async let` or restructure.

### Creating Too Many Actors

```swift
// Over-engineered
actor NetworkManager { }
actor CacheManager { }
actor DataManager { }

// Better - most things can live on MainActor
@MainActor
class AppState { }
```

Use a custom actor only when ALL conditions are met:
1. You have non-Sendable state
2. That state is referenced from more than one place
3. Operations must be atomic
4. Operations cannot run on MainActor

If you can't justify it, use `@MainActor` instead.

### Non-Sendable Types with Async Methods

```swift
// Problematic - only usable from non-isolated contexts
class MyClass {
  private var state = 0

  func someAsyncFunction() async {
    print(state)  // This only works if caller is non-isolated
  }
}
```

**Solution**: Use isolated parameters:

```swift
class MyClass {
  private var state = 0

  func someAsyncFunction(isolation: isolated (any Actor)? = #isolation) async {
    print(state)  // Works from any isolation context
  }
}
```

## Common Mistakes

### Using MainActor.run When You Don't Need It

```swift
// Unnecessary
Task {
  let data = await fetchData()
  await MainActor.run {
    self.data = data
  }
}

// Better - just make the function @MainActor
@MainActor
func loadData() async {
  self.data = await fetchData()
}
```

`MainActor.run` is rarely the right solution. If you need MainActor isolation, annotate the function with `@MainActor` instead.

### Creating Unnecessary Tasks

```swift
// Unnecessary Task creation
func fetchAll() async {
  Task { await fetchUsers() }
  Task { await fetchPosts() }
}

// Better - use structured concurrency
func fetchAll() async {
  async let users = fetchUsers()
  async let posts = fetchPosts()
  await (users, posts)
}
```

If you're already in an async context, prefer structured concurrency (`async let`, `TaskGroup`). Structured concurrency handles cancellation automatically.

### Making Everything Sendable

Not everything needs to cross boundaries. If you're adding `@unchecked Sendable` everywhere, step back and ask if the data actually needs to move between isolation domains.

**Better approach**: Keep types non-Sendable and use isolated parameters. Non-Sendable types are perfectly thread-safe when used correctly.

### Forgetting Cancellation

```swift
// Ignores cancellation
func processItems(_ items: [Item]) async {
  for item in items {
    await process(item)  // Continues even if task is cancelled
  }
}

// Better - respects cancellation
func processItems(_ items: [Item]) async throws {
  for item in items {
    try Task.checkCancellation()
    await process(item)
  }
}
```

### Using Task.detached When Task Suffices

```swift
// Usually wrong
Task.detached {
  await doWork()
}

// Usually right
Task {
  await doWork()
}
```

`Task.detached` doesn't inherit priority, task-local values, or actor context. Regular `Task` is usually what you want. Use `@concurrent` for background work.

## SwiftUI-Specific Mistakes

### Views Not MainActor-Isolated

SwiftUI's isolation model is error-prone. If you see a SwiftUI view that is not MainActor-isolated, it's probably a bug.

```swift
// Potentially problematic
struct MyView: View {
  var body: some View { ... }
}

// Safe - use @Observable which is MainActor by default
@Observable
class ViewModel {
  var items: [Item] = []
}
```

Both UIKit and AppKit enforce whole-type MainActor isolation, so they're easier to use.

### Accessing @State from Detached Tasks

```swift
struct MyView: View {
  @State private var data: Data?

  var body: some View {
    Button("Load") {
      Task.detached {
        let result = await fetch()
        // ERROR: Cannot access @State from detached task
        self.data = result
      }
    }
  }
}
```

**Solution**: Use regular `Task` (inherits MainActor) or hop back explicitly:

```swift
Task.detached {
  let result = await fetch()
  await MainActor.run {
    self.data = result
  }
}
```

## Anti-Patterns to Avoid

### Introducing Actors to Fix Compiler Errors

> "This is an actor because the compiler told me to"

This is always a mistake. You might never revisit it, but it reinforces the wrong mental model. Understand *why* the error exists before adding concurrency constructs.

### @preconcurrency as a Blanket Solution

`@preconcurrency` silences warnings but doesn't fix underlying issues. Use it only for genuine interop with pre-Swift 6 code, not to avoid understanding the problem.

### Overusing nonisolated(unsafe)

```swift
// Dangerous - disables all checking
nonisolated(unsafe) var globalState = 0
```

This completely opts out of the compiler's protection. Only use when you've proven safety through other means.

## The Right Mental Model

1. **Start with MainActor** - Most UI code belongs here
2. **Remove isolation only when needed** - Less isolation = more flexibility
3. **Add actors only with justification** - Document why an actor is necessary
4. **Use non-Sendable types freely** - They're thread-safe when used correctly
5. **Prefer structured concurrency** - `async let` and `TaskGroup` over unstructured `Task`
6. **Trust the compiler** - Errors are telling you something important
