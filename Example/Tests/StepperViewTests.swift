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
        let topView = StepperView()
            .addSteps([TextView(text: "Top")])
            .alignments([StepperAlignment.top])
            .indicators([StepperIndicationType<AnyView>.circle(Colors.teal.rawValue, 12)])
        
        let topVC = UIHostingController(rootView: topView)
        topVC.view.frame = UIScreen.main.bounds
        assertSnapshot(matching: topVC, as: .image)
        
        //center alignment test
        let centerView = StepperView()
                            .addSteps([TextView(text: "Center")])
                            .alignments([StepperAlignment.center])
                            .indicators([StepperIndicationType<AnyView>.circle(Colors.teal.rawValue, 12)])
               
        let centerVC = UIHostingController(rootView: centerView)
        centerVC.view.frame = UIScreen.main.bounds
        assertSnapshot(matching: centerVC, as: .image)
        
        //bottom alignment test
        let bottomView = StepperView()
                            .addSteps([TextView(text: "Bottom")])
                            .alignments([StepperAlignment.bottom])
                            .indicators([StepperIndicationType<AnyView>.circle(Colors.teal.rawValue, 12)])
        
        let bottomVC = UIHostingController(rootView: bottomView)
        bottomVC.view.frame = UIScreen.main.bounds
        assertSnapshot(matching: bottomVC, as: .image)
    }
    
    func testExampleView2() {
        let steps = [StepTextView(text: "Insert ATM Card"), StepTextView(text: "Enter 4-Digit ATM Pin")]
        let indicators = [StepperIndicationType.custom(NumberedCircleView(text: "1").eraseToAnyView()),
        .custom(NumberedCircleView(text: "2").eraseToAnyView())]
        
        let stepperView = StepperView()
                            .addSteps(steps)
                            .indicators(indicators)
        
        let vc = UIHostingController(rootView: stepperView)
        vc.view.frame = UIScreen.main.bounds
        assertSnapshot(matching: vc, as: .image)
    }
    
    func testExampleView3() {
        
     let steps = [ImageTextRowView(text: "Insert ATM Card", imageName: "cc"),
                  ImageTextRowView(text: "Select transaction and enter pin", imageName: "transaction")]
        
     let indictors = [ StepperIndicationType<AnyView>.circle(Colors.teal.rawValue, 12),
                       StepperIndicationType.circle(Colors.teal.rawValue, 12)]
        
      let stepperView = StepperView()
        .addSteps(steps)
        .indicators(indictors)
        .lineOptions(StepperLineOptions.custom(1, Colors.blue(.teal).rawValue))
        
      let vc = UIHostingController(rootView: stepperView)
      vc.view.frame = UIScreen.main.bounds
      assertSnapshot(matching: vc, as: .image)
    }
    
    func testExampleView4() {
        let steps = [StepperContentView(), StepperContentView()]
        let indicators = [StepperIndicationType.image(Image(systemName: "arrowshape.turn.up.right.fill"), 12),
                         StepperIndicationType.custom(ImageView(name: "arrow.uturn.right").eraseToAnyView())]
        
        let stepperView = StepperView()
                                .addSteps(steps)
                                .indicators(indicators)
                                .spacing(30)
                                .lineOptions(StepperLineOptions.custom(1, Colors.blue(.teal).rawValue))
        
        let vc = UIHostingController(rootView: stepperView)
        vc.view.frame = UIScreen.main.bounds
        assertSnapshot(matching: vc, as: .image)
    }
    
    func testExampleView5() {
        let steps = [TextView(text:"Approval"),
                     TextView(text:"Processing"),
                     TextView(text:"Shipping"),
                     TextView(text:"Delivery"),
                     TextView(text:"Tracking")]
        
        let indicationTypes = [
            StepperIndicationType.custom(NumberedCircleView(text: "1")),
            .custom(NumberedCircleView(text: "2")),
            .custom(NumberedCircleView(text: "3")),
            .custom(NumberedCircleView(text: "4")),
            .custom(NumberedCircleView(text: "5"))]
        
        let stepperView = StepperView()
            .addSteps(steps)
            .indicators(indicationTypes)
            .stepIndicatorMode(StepperMode.horizontal)
            .spacing(50)
            .lineOptions(StepperLineOptions.custom(1, Colors.blue(.teal).rawValue))
        
        let vc = UIHostingController(rootView: stepperView)
        vc.view.frame = UIScreen.main.bounds
        assertSnapshot(matching: vc, as: .image)
    }
    
    func testExampleView6() {
        let steps = [TextView(text:"Question"),
                     TextView(text:"Expected Answer"),
                     TextView(text:"Red Flags"),
                     TextView(text:"Further Reading")]
        
        let indicators = [
               StepperIndicationType<AnyView>.custom(NumberedCircleView(text: "1", width: 40).eraseToAnyView()),
               .custom(CircledIconView(image: Image("like"), width: 40,
                                                            strokeColor: Color(UIColor(red: 26/255, green: 188/255, blue: 156/255, alpha: 1.0)))
                                   .eraseToAnyView()),
               .custom(CircledIconView(image: Image("flag"), width: 40,
                                                            strokeColor: Color.red).eraseToAnyView()),
                .custom(CircledIconView(image: Image("book"), width: 40,
                                                            strokeColor: Colors.gray(.darkSilver).rawValue).eraseToAnyView())]
        
        let pitStopLineOptions = [
            StepperLineOptions.custom(1, Colors.teal.rawValue),
            StepperLineOptions.custom(1, Color(UIColor(red: 26/255, green: 188/255, blue: 156/255, alpha: 1.0))),
            StepperLineOptions.custom(1, Color.red),
            StepperLineOptions.custom(1, Colors.gray(.darkSilver).rawValue)
        ]
        
        let pitStops = [
           TextView(text: "Pitstop 1").eraseToAnyView(),
           TextView(text:"Pitstop 2").eraseToAnyView(),
           TextView(text:"Pitstop 3").eraseToAnyView(),
           TextView(text:"References").eraseToAnyView()
        ]
        
       let stepperView = StepperView()
                            .addSteps(steps)
                            .indicators(indicators)
                            .addPitStops(pitStops)
                            .pitStopLineOptions(pitStopLineOptions)
                            .spacing(100)
        
        let vc = UIHostingController(rootView: stepperView)
        vc.view.frame = UIScreen.main.bounds
        assertSnapshot(matching: vc, as: .image)
    }
}
