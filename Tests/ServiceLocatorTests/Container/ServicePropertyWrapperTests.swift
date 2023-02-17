import XCTest
import CwlPreconditionTesting
@testable import ServiceLocator

final class ServicePropertyWrapperTests: XCTestCase {
    override func tearDown() {
        ServiceContainer.shared.reset()
    }

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
        ServiceContainer.shared.register(
            DummyInstance.self,
            factory: { instance }
        )
        let service = Service<DummyInstance>()

        // When
        let resolved = service.wrappedValue

        // Then
        XCTAssert(instance === resolved)
    }
}
