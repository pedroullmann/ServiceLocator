import XCTest
import CwlPreconditionTesting
@testable import ServiceLocator

final class ServicePropertyWrapperTests: XCTestCase {
    func test_initialization_whenServiceIsNotRegistered_shouldReturnBadInstruction() {
        // When
        let fatalError = catchBadInstruction {
            _ = Service<DummyInstance>()
        }

        // Then
        XCTAssertNotNil(fatalError)
    }

    func test_initialization_whenReceiveResolvedValue_shouldReturnInstance() {
        // Given
        let instance = DummyInstance()
        let service = Service<DummyInstance>(resolvedValue: instance)

        // When
        let resolved = service.wrappedValue

        // Then
        XCTAssert(instance === resolved)
    }

    func test_initialization_whenServiceIsRegistered_shouldReturnInstance() {
        // Given
        let instance = DummyInstance()
        let registration = ServiceRegistration(factory: { instance })
        ServiceContainer.shared.register(DummyInstance.self, registration: registration)
        let service = Service<DummyInstance>()

        // When
        let resolved = service.wrappedValue

        // Then
        XCTAssert(instance === resolved)
    }
}
