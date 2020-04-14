import XCTest
import StepperView

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
class StepperViewTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testStepAlignments() {
        XCTAssertTrue(StepperAlignment.allCases.count == 3)
        XCTAssertTrue(StepperAlignment.top.rawValue.lowercased() == "top")
        XCTAssertTrue(StepperAlignment.center.rawValue.lowercased() == "center")
        XCTAssertTrue(StepperAlignment.bottom.rawValue.lowercased() == "bottom")
    }
}
