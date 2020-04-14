import XCTest
@testable import StepperView

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
final class StepperViewTests: XCTestCase {
    func testStepAlignment() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertTrue(StepperAlignment.allCases.count == 3)
    }

    static var allTests = [
        ("testExample", testStepAlignment)
    ]
}
