import Foundation

@propertyWrapper
public struct Service<T> {

    // MARK: - Properties
    private let registration: ServiceRegistration

    // MARK: - Initialization
    public init(resolvedValue: T? = nil) {
        if let resolved = resolvedValue {
            self.registration = .init(
                factory: { resolved }
            )
        } else if let registration = ServiceContainer.shared.get(T.self) {
            self.registration = registration
        } else {
            fatalError("Service '\(T.self)' not registered")
        }
    }

    // MARK: - Public methods
    public var wrappedValue: T {
        guard let instance = registration.getInstance() as? T else {
            fatalError("Service '\(T.self)' not registered")
        }
        return instance
    }

    public static func resolved(_ instance: T) -> Self {
        .init(resolvedValue: instance)
    }
}
