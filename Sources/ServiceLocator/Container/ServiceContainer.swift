import Foundation

public final class ServiceContainer {

    // MARK: - Shared
    public static let shared = ServiceContainer()

    // MARK: - Properties
    private var services = NSMapTable<NSString, AnyObject>.strongToWeakObjects()

    // MARK: - Initialization
    private init() {}

    // MARK: - Public methods
    public func register<T>(
        _ type: T.Type,
        registration: ServiceRegistration
    ) {
        let key = String(describing: type) as NSString
        guard services.object(forKey: key) == nil else {
            fatalError("Service '\(T.self)' was registered twice")
        }
        services.setObject(registration, forKey: key)
    }

    public func get<T>(_ type: T.Type) -> ServiceRegistration? {
        let key = String(describing: type) as NSString
        guard let registration = services.object(forKey: key) as? ServiceRegistration else {
            return nil
        }
        return registration
    }
}
