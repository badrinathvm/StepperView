import XCTest
import StepperView
import SnapshotTesting
import SwiftUI

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
    
    func testSepAlignments() {
        XCTAssertTrue(StepperAlignment.allCases.count == 3)
        XCTAssertTrue(StepperAlignment.top.rawValue.lowercased() == "top")
        XCTAssertTrue(StepperAlignment.center.rawValue.lowercased() == "center")
        XCTAssertTrue(StepperAlignment.bottom.rawValue.lowercased() == "bottom")
    }
    
    func testExampleView1() {
        //top alignment test
        let topView = StepperView(cells: [ TextHolderView(text: "Top") ],
                               alignments: [StepperAlignment.top],
                               indicationType: [StepperIndicationType<AnyView>.circle(Colors.teal.rawValue, 12)])
        
        let topVC = UIHostingController(rootView: topView)
        topVC.view.frame = UIScreen.main.bounds
        assertSnapshot(matching: topVC, as: .image)
        
        //center alignment test
        let centerView = StepperView(cells: [ TextHolderView(text: "Center") ],
                                      alignments: [StepperAlignment.center],
                                      indicationType: [StepperIndicationType<AnyView>.circle(Colors.teal.rawValue, 12)])
               
        let centerVC = UIHostingController(rootView: centerView)
        centerVC.view.frame = UIScreen.main.bounds
        assertSnapshot(matching: centerVC, as: .image)
        
        //bottom alignment test
        let bottomView = StepperView(cells: [ TextHolderView(text: "Bottom") ],
                                      alignments: [StepperAlignment.bottom],
                                      indicationType: [StepperIndicationType<AnyView>.circle(Colors.teal.rawValue, 12)])
               
        let bottomVC = UIHostingController(rootView: bottomView)
        bottomVC.view.frame = UIScreen.main.bounds
        assertSnapshot(matching: bottomVC, as: .image)
    }
    
    func testExampleView2() {
        let stepperView = StepperView(cells: [StepTextView(text: "Insert ATM Card"),
                                              StepTextView(text: "Enter 4-Digit ATM Pin")],
                        indicationType : [StepperIndicationType.custom(NumberedCircleView(text: "1").eraseToAnyView()),
                                              .custom(NumberedCircleView(text: "2").eraseToAnyView())])
        let vc = UIHostingController(rootView: stepperView)
        vc.view.frame = UIScreen.main.bounds
        assertSnapshot(matching: vc, as: .image)
    }
    
    func testExampleView3() {
       let stepperView =  StepperView(cells: [CustomView(text: "Insert ATM Card", imageName: "cc"),
                                              CustomView(text: "Select transaction and enter pin",
                                                         imageName: "transaction")],
                                           indicationType:[
                                                StepperIndicationType<AnyView>.circle(Colors.teal.rawValue, 12),
                                                StepperIndicationType.circle(Colors.teal.rawValue, 12)
                                            ],
                                           lineOptions: StepperLineOptions.custom(1, Colors.blue(.teal).rawValue))
        
      let vc = UIHostingController(rootView: stepperView)
      vc.view.frame = UIScreen.main.bounds
      assertSnapshot(matching: vc, as: .image)
    }
    
    func testExampleView4() {
        let stepperView = StepperView(cells: [StepperContentView(), StepperContentView()],
                                      alignments: [.center, .bottom],
                                      indicationType: [
                                            StepperIndicationType
                                                .image(Image(systemName: "arrowshape.turn.up.right.fill"), 12),
                                            StepperIndicationType
                                                .custom(ImageView(name: "arrow.uturn.right").eraseToAnyView())])
        let vc = UIHostingController(rootView: stepperView)
        vc.view.frame = UIScreen.main.bounds
        assertSnapshot(matching: vc, as: .image)
    }
}
