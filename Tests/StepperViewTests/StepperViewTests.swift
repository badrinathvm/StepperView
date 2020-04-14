import XCTest
import SnapshotTesting
import SwiftUI
@testable import StepperView

#if os(iOS)
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
final class StepperViewTests: XCTestCase {
    
    func testStepAlignment() {
        XCTAssertTrue(StepperAlignment.allCases.count == 3)
    }
    
    func testExampleView1() {
        let topView = StepperView(cells: [ Text("Top") ],
                               alignments: [StepperAlignment.top],
                               indicationType: [StepperIndicationType<AnyView>.circle(Colors.teal.rawValue, 12)])
        
        let topVC = UIHostingController(rootView: topView)
        topVC.view.frame = UIScreen.main.bounds
        assertSnapshot(matching: topVC, as: .image)
    }
    
    func testExampleView2() {
        let stepperView = StepperView(cells: [Text("Insert ATM Card")
                                                .foregroundColor(Colors.blue(.teal).rawValue)
                                                .font(.system(size: 16, weight:Font.Weight.medium))
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .padding(.horizontal, 10),
                                              
                                              Text("Enter 4 digit Pin")
                                              .foregroundColor(Colors.blue(.teal).rawValue)
                                              .font(.system(size: 16, weight:Font.Weight.medium))
                                              .frame(maxWidth: .infinity, alignment: .leading)
                                              .padding(.horizontal, 10)
            
                                            ],
                                      alignments: [StepperAlignment.center, .bottom],
                                             indicationType: [StepperIndicationType
                                                       .image(Image(systemName: "arrowshape.turn.up.right.fill"), 12),
                                                        .image(Image(systemName: "arrowshape.turn.up.right.fill"), 12)])
               let vc = UIHostingController(rootView: stepperView)
               vc.view.frame = UIScreen.main.bounds
               assertSnapshot(matching: vc, as: .image)
    }

    static var allTests = [
        ("testStepAlignment", testStepAlignment),
        ("testExampleView1", testExampleView1),
        ("testExampleView2", testExampleView2)
    ]
}
#endif
