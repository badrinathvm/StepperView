import XCTest
import SwiftUI
@testable import StepperView

final class StepperViewTests: XCTestCase {
    
    func testStepAlignment() {
        XCTAssertTrue(StepperAlignment.allCases.count == 3)
    }
    
    func testStepperViewParameters() {
        let topView = StepperView()
                .addSteps([ Text("Top") ])
                .alignments([StepperAlignment.top])
                .stepIndicatorMode(StepperMode.vertical)
                .indicators([StepperIndicationType<AnyView>.circle(Colors.teal.rawValue, 12)])
        
        XCTAssertNotNil(topView)
    }

    static var allTests = [
        ("testStepAlignment", testStepAlignment),
        ("testStepperViewParameters", testStepperViewParameters)
    ]
}
