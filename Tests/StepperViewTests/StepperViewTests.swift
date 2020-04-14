import XCTest
import SwiftUI
@testable import StepperView

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
final class StepperViewTests: XCTestCase {
    
    func testStepAlignment() {
        XCTAssertTrue(StepperAlignment.allCases.count == 3)
    }
    
    func testStepperViewParameters() {
        let topView = StepperView(cells: [ Text("Top") ],
                               alignments: [StepperAlignment.top],
                               indicationType: [StepperIndicationType<AnyView>.circle(Colors.teal.rawValue, 12)])
        
        XCTAssertTrue(topView.verticalSpacing == 30.0)
    }

    static var allTests = [
        ("testStepAlignment", testStepAlignment),
        ("testStepperViewParameters", testStepperViewParameters)
    ]
}
