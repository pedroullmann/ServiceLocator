import Foundation

@propertyWrapper
public struct Service<T> {

    // MARK: - Properties
    private let value: T

    // MARK: - Initialization
    public init(resolvedValue: T? = nil) {
        if let resolved = resolvedValue {
            self.value = resolved
        } else if let instance = ServiceContainer.shared.resolve(T.self) {
            self.value = instance
        } else {
            fatalError("Service '\(T.self)' not registered")
        }
    }

    // MARK: - Public methods
    public var wrappedValue: T { value }

    public static func resolved(_ instance: T) -> Self {
        .init(resolvedValue: instance)
    }
}
