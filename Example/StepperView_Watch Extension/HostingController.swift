//
//  InterfaceController.swift
//  StepperView_Watch Extension
//
//  Created by Venkatnarayansetty, Badarinath on 5/9/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import WatchKit
import Foundation
import StepperView
import SwiftUI

class HostingController: WKHostingController<WatchExampleView> {
    override var body: WatchExampleView {
        return WatchExampleView()
    }
}

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct WatchExampleView: View {
    
    let indicationTypes = [
        StepperIndicationType.custom(NumberedCircleView(text: "1")),
                        .custom(NumberedCircleView(text: "2")),
       .custom(NumberedCircleView(text: "3")),
       .custom(NumberedCircleView(text: "4"))]
    
    let set1 = [TextView(text:"Approval"),
                   TextView(text:"Processing"),
                   TextView(text:"Shipping"),
                   TextView(text:"Tracking")]
    
    var body: some View {
        ScrollView(Axis.Set.vertical, showsIndicators: true) {
            StepperView()
                   .addSteps(self.set1)
                   .indicators(self.indicationTypes)
                   .stepIndicatorMode(StepperMode.vertical)
                   .spacing(30)
                   .lineOptions(StepperLineOptions.custom(1, Colors.blue(.teal).rawValue))
                   .padding(.leading, 30)
         }
    }
}
