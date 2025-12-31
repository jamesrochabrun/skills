# Sendable and Crossing Isolation Boundaries

## What is Sendable?

When you pass data between isolation domains, Swift checks if it's safe. A reference to a mutable class passed from one actor to another could be modified simultaneously - exactly the data race we're preventing.

The `Sendable` protocol is a marker that tells the compiler "this type is safe to pass across isolation boundaries":

- **Sendable types** can cross safely (value types, immutable data, actors)
- **Non-Sendable types** cannot (classes with mutable state)

```swift
// Sendable - value type, each place gets a copy
struct User: Sendable {
  let id: Int
  let name: String
}

// Non-Sendable - class with mutable state
class Counter {
  var count = 0  // Two places modifying this = disaster
}
```

## Making Types Sendable

Swift automatically infers Sendable for many types:

- **Structs and enums** with only Sendable properties are implicitly Sendable
- **Actors** are always Sendable (they protect their own state)
- **@MainActor types** are Sendable (MainActor serializes access)

For classes, it's harder. A class can conform to Sendable only if it's final and all stored properties are immutable:

```swift
final class APIConfig: Sendable {
  let baseURL: URL      // Immutable
  let timeout: Double   // Immutable
}
```

### @unchecked Sendable

For types that are thread-safe through other means (locks, atomics):

```swift
final class ThreadSafeCache: @unchecked Sendable {
  private let lock = NSLock()
  private var storage: [String: Data] = [:]
}
```

**Warning**: `@unchecked Sendable` is a promise. The compiler won't verify thread safety. Use sparingly.

## The Photocopies Metaphor

When sharing information between department offices:

- **Photocopies are safe** - Legal copies a document and sends it to Accounting. Both have their own copy. No conflict.
- **Original signed contracts must stay put** - If two departments could both modify the original, chaos ensues.

Sendable types are like photocopies: safe to share because each place gets its own copy (value types) or because they're immutable. Non-Sendable types are like original contracts.

## Non-Sendable Types Are Valuable

Non-Sendable types are also thread-safe - the compiler forces you to use them safely. They're stuck in whatever isolation domain they're created in.

**Key insight**: If you can remove isolation from a type, you should. Isolation is a constraint; removing it makes things more flexible.

```swift
// This works fine - no isolation needed
class MyClass {
  private var state = 0

  func someFunction() {
    print("my state is:", state)
  }
}
```

A non-Sendable type will be created in some isolation domain and stay there. It cannot move.

## The Problem: Non-Sendable + async

Non-isolated async functions always run on the global executor (background):

```swift
class MyClass {
  private var state = 0

  func someAsyncFunction() async {
    print("my state is:", state)  // ERROR
  }
}
```

To call this method, the instance must already be non-isolated. This creates a type only usable from non-isolated contexts.

## The Solution: Isolated Parameters

Use an isolated parameter to inherit caller's isolation:

```swift
class MyClass {
  private var state = 0

  func someAsyncFunction(isolation: isolated (any Actor)? = #isolation) async {
    print("my state is:", state)
  }
}
```

This function works from MainActor, custom actors, and non-isolated contexts. The `#isolation` default handles everything automatically.

```swift
@MainActor
class Client {
  let instance = MyClass()

  func useInstance() async {
    // Now this works! Function inherits MainActor isolation
    await instance.someAsyncFunction()
  }
}
```

**Bonus**: Isolated parameters guarantee no suspension on function entry, opening a synchronous window.

### Non-optional Variant (Safest)

```swift
class MyClass {
  private var state = 0

  func someAsyncFunction(isolation: isolated any Actor) async {
    print("my state is:", state)
  }
}
```

The non-optional form is safest but loses the `#isolation` default convenience.

## The sending Keyword

Sometimes you need a one-way transfer of a non-Sendable type. The `sending` keyword promises the value won't be used after transfer:

```swift
func process(sending value: NonSendableType) async { }
```

This enables region-based isolation to prove the transfer is safe even though the type isn't Sendable.

## Protocol Conformance Isolation Mismatch

A common problem: protocols require non-isolated methods, but your type is isolated:

```swift
protocol NonIsolatedProtocol {
  func someFunction()
}

@MainActor
class MyClass: NonIsolatedProtocol {
  private var state = 0

  // ERROR: Protocol requires non-isolated, type is MainActor
  func someFunction() { }
}
```

### Solution 1: Remove Isolation

If the type doesn't actually need isolation, remove it:

```swift
class MyClass: NonIsolatedProtocol {
  private var state = 0

  func someFunction() {
    print("my state is:", state)
  }
}
```

The type will be created in some isolation domain and stay there. Clients handle isolation.

### Solution 2: Use nonisolated

If only some methods need to be non-isolated:

```swift
@MainActor
class MyClass: NonIsolatedProtocol {
  private let state = 0  // Must be immutable

  nonisolated func someFunction() {
    print("my state is:", state)
  }
}
```

### Solution 3: Isolated Parameters

For async methods in non-Sendable types:

```swift
class MyClass {
  private var state = 0

  func asyncMethod(isolation: isolated (any Actor)? = #isolation) async {
    // Works from any isolation context
  }
}
```

## Approachable Concurrency Reduces Sendable Friction

With Approachable Concurrency enabled:

- If code doesn't cross isolation boundaries, you don't need Sendable
- Async functions stay on the caller's actor instead of hopping to background
- The compiler is smarter about detecting when values are used safely

Sendable errors become much rarer. When you do need parallelism, mark functions `@concurrent` and then think about Sendable.
