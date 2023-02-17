# ServiceLocator

## Adding to your project

Add the following to the `dependencies` array in your "Package.swift" file:

     .package(url: "https://github.com/pedroullmann/ServiceLocator.git", from: Version("2.0.0"))

## Usage

```swift
import ServiceLocator

let container = ServiceContainer.shared

// Register lazy dependency
container.register(
    APIServiceProtocol.self, /// Interface
    factory: { APIService() } /// Concrete
)
```

```swift
import ServiceLocator

final class MyViewModel {
    @Service var apiService: APIServiceProtocol
}
```
