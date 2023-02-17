import XCTest
import CwlPreconditionTesting
@testable import ServiceLocator

final class ServiceContainerTests: XCTestCase {
    func test_get_whenServiceIsRegistered_shouldReturnInstance() {
        // Given
        let container = ServiceContainer.shared
        let instance = DummyInstance()
        let registration = ServiceRegistration(factory: { instance })

        // When
        container.register(DummyInstance.self, registration: registration)
        let resolved = container.get(DummyInstance.self)?.getInstance()

        // Then
        XCTAssert(resolved === instance)
    }

    func test_get_whenServiceIsNotRegistered_shouldReturnNil() {
        // Given
        let container = ServiceContainer.shared

        // When
        let resolved = container.get(DummyInstance.self)?.getInstance()

        // Then
        XCTAssertNil(resolved)
    }

    func test_register_whenServiceIsRegisteredTwice_shouldReturnBadInstruction() {
        // Given
        let container = ServiceContainer.shared
        let instance = DummyInstance()
        let registration = ServiceRegistration(factory: { instance })
        container.register(DummyInstance.self, registration: registration)

        // When
        let fatalError = catchBadInstruction {
            container.register(DummyInstance.self, registration: registration)
        }

        // Then
        XCTAssertNotNil(fatalError)
    }
}
