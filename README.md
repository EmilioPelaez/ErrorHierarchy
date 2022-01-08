# Error Hierarchy

This is a sibling framework to [`EventHierarchy`](https://github.com/EmilioPelaez/EventHierarchy), but specialized for Error handling.

Using a closure contained in `EnvironmentValues`, `View` objects that are lower in the hierarchy report `Error` objects up the view hierarchy, while views that are higher in the hierarchy use one of the modifiers to register themselves as a responder to receive, transform, or handle the `Error` objects.

## Triggering an `Error`

Errors are triggered using the `reportError` closure added to `EnvironmentValues`.

Example:

```swift
struct MyError: Error {}

struct TriggerView: View {
	@Environment(\.reportError) var reportError
	
	var body: some View {
		Button("Trigger") {
			reportError(MyError())
		}
	}
}
```

## Receiving, Handling and Transforming an `Error`

There are three kinds of operations that can be applied to an `Error` that has been triggered. All of these are executed by registering a closure the same way you would apply a view modifier to a `View`.

```swift
struct ContentView: View {
	var body: some View {
		TriggerView()
			.receiveError { .notHandled }
			.transformError { MyError() }
			.handleError {}
	}
}
```

All of these functions have a generic version that receives the type of an `Error` as the first parameter, only errors matching the provided type will be acted on, any other error will be propagated up the view hierarchy.

```swift
struct ContentView: View {
	var body: some View {
		TriggerView()
			.handleError(MyError.self) {}
	}
}
```

### Receiving an `Error`

When receiving an `Error`, it's up to the registered closure to determine whether the `Error` has been fully handled or not.

If the registered closure returns `.handled`, the `Error` will no longer be propagated up the view hierarchy.
If it returns `.unhandled` instead, the `Error` will continue to be propagated.

### Handling an `Error`

Any error that is handled will no longer be propagated up the view hierarchy. This is equivalent to using a `receiveError` closure that always returns `.handled`.

### Transforming an `Error`

Transforming functions can be used to replace the received `Error`. It could be an `Error` of a different type, or an `Error` of the same type but with different values.
