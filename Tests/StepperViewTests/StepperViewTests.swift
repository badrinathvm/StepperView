import XCTest
import SwiftUI
@testable import StepperView

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
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
