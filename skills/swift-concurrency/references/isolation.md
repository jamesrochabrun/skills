# Isolation in Swift Concurrency

## What is Isolation?

Isolation is the mechanism Swift uses to make data races impossible. The compiler reasons about how data is accessed and when it can be done safely. This is about accessing mutable state in unsafe ways specifically.

**Key insight**: Definitions control isolation. You can always look at a definition to understand its isolation. This is a radical departure from locks and queues.

```swift
// No isolation for the type...
class MyClass {
  // ... and none for the function either
  func method() {
    // This is a non-isolated context
  }

  func asyncMethod() async {
    // async does not affect this - still non-isolated!
  }
}
```

## The Three Isolation Domains

### 1. MainActor

`@MainActor` is a global actor representing the main thread's isolation domain. UI frameworks require main thread access.

```swift
@MainActor
class ViewModel {
  var items: [Item] = []  // Protected by MainActor isolation
}
```

When you mark something `@MainActor`, you're saying "this belongs to the main actor's isolation domain." The compiler enforces that anything accessing it must either be on MainActor or `await` to cross the boundary.

**Recommendation**: When in doubt, use `@MainActor`. For most apps, marking ViewModels with `@MainActor` is the right choice. Performance concerns are usually overblown.

### 2. Actors

An actor protects its own mutable state. Only one piece of code can access its data at a time:

```swift
actor BankAccount {
  var balance: Double = 0

  func deposit(_ amount: Double) {
    balance += amount  // Safe: actor guarantees exclusive access
  }
}

// From outside, you must await to cross the boundary
await account.deposit(100)
```

**Important**: Actors are not threads. An actor is an isolation boundary. The Swift runtime decides which thread executes actor code.

### 3. Nonisolated

Code marked `nonisolated` opts out of actor isolation. It can be called from anywhere without `await`, but cannot access the actor's protected state:

```swift
actor BankAccount {
  var balance: Double = 0

  nonisolated func bankName() -> String {
    "Acme Bank"  // No actor state accessed
  }
}

let name = account.bankName()  // No await needed
```

## The Office Building Metaphor

Think of your app as an office building:

- **MainActor** is the front desk - where all customer (user) interactions happen. There's only one, and it handles everything the user sees.
- **actor types** are department offices - Accounting, Legal, HR. Each protects its own sensitive documents.
- **nonisolated** code is the hallway - shared space anyone can walk through, but no private documents live there.

You can't just barge into someone's office. You knock (`await`) and wait for them to let you in.

## How Isolation Is Inherited

Isolation flows through your code. With Approachable Concurrency, your app starts on MainActor, and that isolation propagates unless something explicitly changes it.

### Function Calls

```swift
@MainActor func updateUI() { }      // Always runs on MainActor
func helper() { }                    // Inherits caller's isolation
@concurrent func crunch() async { }  // Explicitly runs off-actor
```

### Closures

Closures inherit isolation from the context where they're defined:

```swift
@MainActor
class ViewModel {
  func setup() {
    let closure = {
      // Inherits MainActor from ViewModel
      self.updateUI()  // Safe, same isolation
    }
    closure()
  }
}
```

This is why SwiftUI's Button action closures can safely update `@State`.

### Tasks

A `Task { }` inherits actor isolation from where it's created:

```swift
@MainActor
class ViewModel {
  func doWork() {
    Task {
      // Inherits MainActor isolation
      self.updateUI()  // Safe, no await needed
    }
  }
}
```

## Breaking Inheritance

### Task.detached

```swift
@MainActor
class ViewModel {
  func doHeavyWork() {
    Task.detached {
      // No actor isolation
      let result = await self.expensiveCalculation()
      await MainActor.run {
        self.data = result
      }
    }
  }
}
```

### nonisolated Keyword

```swift
@MainActor
class MyClass {
  nonisolated func nonIsolatedMethod() {
    // No MainActor isolation here
  }

  nonisolated static let someConstant = "I'm thread-safe!"
}
```

## Isolation Can Change When You Await

Whenever you see `await`, isolation could change:

```swift
@MainActor
func doStuff() async {
  // On MainActor here
  await anotherFunction()  // Must check anotherFunction's definition
  // Back on MainActor
}
```

**Key insight**: Look at definitions, not runtime context. Definitions are all that matter in Swift!

## Actor Justification Test

Introduce an actor only when ALL conditions are met:

1. You have non-Sendable state
2. That state needs to be referenced from more than one place
3. Operations on that state must be atomic
4. Those operations cannot run on an existing actor (like MainActor)

If you cannot justify all four, use `@MainActor` instead.

**Example of unnecessary actor**:

```swift
// Over-engineered - no non-Sendable state!
actor NetworkManager { }
actor CacheManager { }

// Better - most things can live on MainActor
@MainActor
class AppState { }
```

A "network client" actor with zero non-Sendable state doesn't make sense. Use a `@MainActor` type with `@concurrent` functions for CPU-intensive work instead.

## Dynamic Isolation

When the type system cannot describe the actual isolation used (common with pre-concurrency systems):

```swift
@MainActor
class MyMainActorClass: SomeDelegate {
  nonisolated func someDelegateCallback() {
    // Promise the compiler we will be on MainActor at runtime
    MainActor.assumeIsolated {
      // Access MainActor stuff, including self
    }
  }
}
```

## Approachable Concurrency (Swift 6.2+)

Two Xcode build settings simplify the mental model:

- `SWIFT_DEFAULT_ACTOR_ISOLATION = MainActor`: Everything runs on MainActor unless you say otherwise
- `SWIFT_APPROACHABLE_CONCURRENCY = YES`: `nonisolated async` functions stay on the caller's actor instead of jumping to a background thread

New Xcode 26 projects have both enabled by default. When you need CPU-intensive work off the main thread, use `@concurrent`:

```swift
// Runs on MainActor (the default)
func updateUI() async { }

// Runs on background thread (opt-in)
@concurrent func processLargeFile() async { }
```
