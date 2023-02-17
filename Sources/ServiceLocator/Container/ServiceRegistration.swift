import Foundation

public final class ServiceRegistration<T> {

    // MARK: - Properties
    private let factory: () -> T
    private var instance: T?

    // MARK: - Initialization
    public init(factory: @escaping () -> T) {
        self.factory = factory
    }

    // MARK: - Public methods
    public func getInstance() -> T {
        if let instance = instance {
            return instance
        }
        let newInstance = factory()
        instance = newInstance
        return newInstance
    }
}
