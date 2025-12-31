# Swift Concurrency Glossary

Complete reference of Swift concurrency terms, keywords, and annotations.

## Keywords and Annotations

### actor
**Type**: Keyword
**Usage**: Defines a reference type that protects mutable state
**Introduced**: SE-0306 Actors

Actors define a unit of isolation. Each instance has its own isolation domain.

```swift
actor BankAccount {
  var balance: Double = 0
  func deposit(_ amount: Double) { balance += amount }
}
```

### Actor
**Type**: Protocol
**Usage**: A protocol which all actor types conform to
**Introduced**: SE-0306 Actors

Like `AnyObject` but only for actor types. Used for isolated parameters.

### async
**Type**: Keyword
**Usage**: Applied to a function signature so it can use `await`
**Introduced**: SE-0296 Async/await

Marks a function that might need to pause (suspend).

### await
**Type**: Keyword
**Usage**: Marks a suspension point
**Introduced**: SE-0296 Async/await

Introduces a potential suspension point. At these points, the executing actor can change.

### async let
**Type**: Flow Control
**Usage**: Start work asynchronously without awaiting immediately
**Introduced**: SE-0317 async let bindings

```swift
async let avatar = fetchAvatar()
async let bio = fetchBio()
let (a, b) = await (avatar, bio)  // Both run in parallel
```

### @concurrent
**Type**: Annotation
**Usage**: Causes an async function to run on the global executor
**Introduced**: SE-0461

Forces a function to always run in the background, regardless of Approachable Concurrency settings.

```swift
@concurrent
func processLargeFile() async -> Data { }
```

### @globalActor
**Type**: Annotation
**Usage**: Marks an actor type as global
**Introduced**: SE-0316 Global actors

Makes an actor type usable as an annotation for static isolation.

### isolated
**Type**: Keyword
**Usage**: Defines static isolation via a function parameter
**Introduced**: SE-0313

Essential for integrating concurrency into non-Sendable types.

```swift
func doWork(isolation: isolated (any Actor)? = #isolation) async { }
```

### @isolated(any)
**Type**: Annotation
**Usage**: Inspect a function's static isolation at runtime
**Introduced**: SE-0431

Allows inspecting the isolation of a function passed as a variable.

### #isolation
**Type**: Expression Macro
**Usage**: Returns the static isolation as `(any Actor)?`
**Introduced**: SE-0420

Used with isolated parameters to inherit calling isolation.

### @_inheritActorContext
**Type**: Parameter Annotation
**Usage**: Applies isolation inheritance to a closure parameter
**Introduced**: Internal

Makes closures maintain the same isolation as where they were formed. Used by `Task`.

### @MainActor
**Type**: Annotation
**Usage**: The global actor for the main thread
**Introduced**: SE-0316 Global actors

References the shared MainActor instance for main thread isolation.

### nonisolated
**Type**: Keyword
**Usage**: Explicitly turns off actor isolation
**Introduced**: SE-0313

Opts out of actor isolation for a declaration.

```swift
actor MyActor {
  nonisolated func publicInfo() -> String { "safe" }
}
```

### nonisolated(nonsending)
**Type**: Annotation
**Usage**: Causes an async function to inherit caller's isolation
**Introduced**: SE-0461

Avoids the need for Sendable types by staying on the caller's actor.

### nonisolated(unsafe)
**Type**: Annotation
**Usage**: Opts a declaration out of Sendable checking
**Introduced**: SE-0306 Actors

Targeted opt-out of isolation checks. Less error-prone than `@unchecked Sendable`.

### @preconcurrency
**Type**: Attribute
**Usage**: Interop between Swift 6 and pre-Swift 6 code
**Introduced**: SE-0337, SE-0423

For consuming pre-Swift 6 APIs or maintaining compatibility with Swift 5 mode.

### Sendable
**Type**: Protocol
**Usage**: Marker that a type can safely cross isolation boundaries
**Introduced**: SE-0302

```swift
struct User: Sendable {
  let id: Int
  let name: String
}
```

### SendableMetatype
**Type**: Protocol
**Usage**: Marker that a metatype can safely cross isolation boundaries
**Introduced**: SE-0470

Required after Swift 6.2 for isolated conformances.

### @Sendable
**Type**: Attribute
**Usage**: Sendable for function types
**Introduced**: SE-0302

Same as Sendable but for closures and function types.

### sending
**Type**: Keyword
**Usage**: Express one-way transfer of values
**Introduced**: SE-0430

Encodes a strict promise about value behavior into function signatures.

```swift
func process(sending value: NonSendableType) async { }
```

### @unchecked
**Type**: Annotation
**Usage**: Disables compiler checks for Sendable conformance
**Introduced**: SE-0302

For types with thread-safety implemented outside Swift's checking.

```swift
final class Cache: @unchecked Sendable {
  private let lock = NSLock()
  private var storage: [String: Data] = [:]
}
```

## Types and Concepts

### AsyncSequence
**Type**: Protocol
**Usage**: A series of values produced over time
**Introduced**: SE-0298

```swift
for await notification in NotificationCenter.default.notifications(named: .userDidLogin) {
  // Handle each notification as it arrives
}
```

### Continuation
**Type**: Type
**Usage**: Bridge callback-based code to async/await
**Introduced**: SE-0300

```swift
try await withCheckedThrowingContinuation { continuation in
  legacyAPI { result in
    continuation.resume(with: result)
  }
}
```

### Executor
**Type**: Protocol
**Usage**: API for controlling how actors execute code
**Introduced**: SE-0304

Rarely needed for day-to-day development. For advanced uses and performance.

### Global Executor
**Type**: Concept
**Usage**: The executor that runs concurrent (non-isolated) code
**Introduced**: SE-0338

Unlike actor executors, this runs more than one thing simultaneously. Accessed via `async let`, `TaskGroup`, and `@concurrent`.

### Isolation
**Type**: Concept
**Usage**: The form of thread-safety an actor provides
**Introduced**: SE-0306 Actors

Actors implement isolation, perhaps via a serial queue. Everything has well-defined static isolation.

### Region-Based Isolation
**Type**: Concept
**Usage**: Compiler relaxes Sendable checking in specific circumstances
**Introduced**: SE-0414

Code-flow analysis proving that even non-Sendable types are used safely in specific patterns.

### Task
**Type**: Type
**Usage**: Creates a new top-level context for async code
**Introduced**: SE-0304 Structured concurrency

Supports cancellation, priority, and accessing results.

### TaskGroup
**Type**: Type
**Usage**: Manage multiple child tasks
**Introduced**: SE-0304 Structured concurrency

For dynamic parallel work with automatic cancellation propagation.

### TaskLocal
**Type**: Type
**Usage**: Make values available across the current task
**Introduced**: SE-0311 Task Local Values

Analog of thread-local values for tasks.

## Build Settings

### SWIFT_DEFAULT_ACTOR_ISOLATION
**Values**: `MainActor` | (empty)
**Default**: `MainActor` for Xcode 26+ projects

When set to `MainActor`, everything runs on MainActor unless explicitly marked otherwise.

### SWIFT_APPROACHABLE_CONCURRENCY
**Values**: `YES` | `NO`
**Default**: `YES` for Xcode 26+ projects

When enabled, `nonisolated async` functions stay on the caller's actor instead of hopping to background.

## Quick Reference Table

| Term | Purpose |
|------|---------|
| `async` | Function can suspend |
| `await` | Suspension point |
| `Task { }` | Start async work, inherits context |
| `Task.detached { }` | Start async work, no inheritance |
| `@MainActor` | Runs on main thread |
| `actor` | Type with isolated mutable state |
| `nonisolated` | Opts out of actor isolation |
| `nonisolated(nonsending)` | Inherits caller's isolation |
| `@concurrent` | Always run on background |
| `Sendable` | Safe to cross isolation boundaries |
| `sending` | One-way transfer of non-Sendable |
| `async let` | Start parallel work |
| `TaskGroup` | Dynamic parallel work |
| `#isolation` | Get current isolation |
| `isolated` | Parameter-based isolation |
