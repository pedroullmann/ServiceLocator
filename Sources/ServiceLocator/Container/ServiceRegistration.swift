import Foundation

public final class ServiceRegistration {
    public let instance: Any

    // MARK: - Initialization
    public init(instance: Any) {
        self.instance = instance
    }
}
