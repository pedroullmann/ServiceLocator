import XCTest
import CwlPreconditionTesting
@testable import ServiceLocator

final class ServiceRegistrationTests: XCTestCase {
    func test_getInstance_shouldReturnInstance() {
        // Given
        let instance = DummyInstance()
        let registration = ServiceRegistration(factory: { instance })

        // When
        let resolved = registration.getInstance()

        // Then
        XCTAssert(instance === resolved)
    }
}
