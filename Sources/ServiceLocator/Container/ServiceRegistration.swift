import Foundation

public final class ServiceRegistration {

    // MARK: - Properties
    private let factory: () -> Any
    private var instance: Any?

    // MARK: - Initialization
    public init(factory: @escaping () -> Any) {
        self.factory = factory
    }

    // MARK: - Public methods
    public func getInstance() -> Any {
        if let instance = instance {
            return instance
        }
        let newInstance = factory()
        instance = newInstance
        return newInstance
    }
}
