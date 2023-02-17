import Foundation

public typealias ServiceFactory = () -> Any

public final class ServiceContainer {

    // MARK: - Shared
    public static let shared = ServiceContainer()

    // MARK: - Properties
    private var factories: [NSString: ServiceFactory] = [:]
    private var services = NSMapTable<NSString, AnyObject>.strongToWeakObjects()

    // MARK: - Initialization
    private init() {}

    // MARK: - Public methods
    public func register<T>(
        _ type: T.Type,
        factory: @escaping ServiceFactory
    ) {
        let key = String(describing: type) as NSString
        guard factories[key] == nil else {
            fatalError("Service '\(T.self)' was registered twice")
        }
        factories[key] = factory
    }

    public func resolve<T>(_ type: T.Type) -> T? {
        let key = String(describing: type) as NSString
        guard
            let object = services.object(forKey: key),
            let service = object as? ServiceRegistration,
            let instance = service.instance as? T
        else {
            if let instance = factories[key]?() as? T {
                let service = ServiceRegistration(instance: instance)
                services.setObject(service, forKey: key)
                return instance
            } else {
                return nil
            }
        }
        return instance
    }

    // MARK: - Internal methods
    internal func reset() {
        factories = [:]
        services.removeAllObjects()
    }
}
