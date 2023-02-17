import XCTest
import CwlPreconditionTesting
@testable import ServiceLocator

final class ServiceContainerTests: XCTestCase {
    override func tearDown() {
        ServiceContainer.shared.reset()
    }

    func test_register_shouldStoreFactory() {
        // Given
        let container = ServiceContainer.shared
        let instance = DummyInstance()
        let factory: () -> DummyInstance = { instance }
        let key = String(describing: DummyInstance.self) as NSString

        // When
        container.register(
            DummyInstance.self,
            factory: factory
        )

        // Then
        let factories = Mirror(reflecting: container)
            .firstChild(of: [NSString: ServiceFactory].self)
        let storedFactory = factories?[key]
        let storedInstance = storedFactory?()
        XCTAssert(storedInstance is DummyInstance)
    }

    func test_register_whenServiceIsRegisteredTwice_shouldReturnBadInstruction() {
        // Given
        let container = ServiceContainer.shared
        let factory: () -> DummyInstance = { DummyInstance() }
        container.register(DummyInstance.self, factory: factory)

        // When
        let fatalError = catchBadInstruction {
            container.register(
                DummyInstance.self,
                factory: factory
            )
        }

        XCTAssertNotNil(fatalError)
    }

    func test_resolve_whenServiceIsNotInMemory_andThereIsFactory_shouldInitializeAndKeepInMemory() {
        // Given
        let container = ServiceContainer.shared
        let instance = DummyInstance()
        let factory: () -> DummyInstance = { instance }
        container.register(DummyInstance.self, factory: factory)

        // When
        let firstInstance = container.resolve(DummyInstance.self)
        let secondInstance = container.resolve(DummyInstance.self)

        // Then
        XCTAssert(firstInstance === secondInstance)
    }
}
