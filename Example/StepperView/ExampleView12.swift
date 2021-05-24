//
//  ExampleView12.swift
//  StepperView
//
//  Created by Venkatnarayansetty, Badarinath on 5/23/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import SwiftUI
import StepperView

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct ExampleView12: View {
    let steps = [ Text("Cart").font(.caption),
                  Text("Delivery Address").font(.caption),
                  Text("Order Summary").font(.caption),
                  Text("Payment Method").font(.caption),
                  Text("Shipping\nTracking\nDelivered\nReturn Label\nRate The Experience").font(.caption)]
    
    let indicationTypes = [StepperIndicationType.custom(NumberedCircleView(text: "1")),
                            .custom(NumberedCircleView(text: "2")),
                            .custom(NumberedCircleView(text: "3")),
                            .custom(NumberedCircleView(text: "4")),
                            .custom(NumberedCircleView(text: "5"))]
    
    var body: some View {
        StepperView()
            .addSteps(steps)
            .indicators(indicationTypes)
            .stepIndicatorMode(StepperMode.vertical)
            .spacing(30)
            .alignments([StepperAlignment.top, .top, .top, .top, .center])
            .lineOptions(StepperLineOptions.custom(1, Colors.blue(.teal).rawValue))
    }
}
