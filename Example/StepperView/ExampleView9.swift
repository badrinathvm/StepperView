//
//  ExampleView9.swift
//  StepperView_Example
//
//  Created by Venkatnarayansetty, Badarinath on 6/7/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import SwiftUI
import StepperView

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct ExampleView9: View {
      
    // steps for vertical mode ( for adding dynamic steps , make it `@State` property)
    @State var verticalSteps = [TextView(text:"Cart"),
                TextView(text:"Delivery Address"),
                TextView(text:"Order Summary"),
                TextView(text:"Payemnt")]
    
     // steps for horizontal mode ( for adding dynamic steps , make it `@State` property)
    @State var horizontalSteps = [TextView(text:"Approval "),
                   TextView(text:"Shipping"),
                   TextView(text:"Delivery"),
                   TextView(text:"Tracking")]

    // indications types commonn for both the modes
    @State var indicationTypes = [StepperIndicationType.custom(NumberedCircleView(text: "1")),
                            .custom(NumberedCircleView(text: "2")),
                            .custom(NumberedCircleView(text: "3")),
                            .custom(NumberedCircleView(text: "4"))]
                            
    var body: some View {
        VStack(spacing: 50) {
            // vertical mode
            StepperView()
             .addSteps(verticalSteps)
             .indicators(indicationTypes)
             .stepIndicatorMode(StepperMode.vertical)
             .spacing(50)
             .lineOptions(StepperLineOptions.custom(1, Colors.blue(.teal).rawValue))
             .onAppear {
                 self.verticalSteps.append(TextView(text:"Track"))
                 self.indicationTypes.append(StepperIndicationType.custom(NumberedCircleView(text: "5")))
             }
            
            // Horizontal mode
            StepperView()
                .addSteps(horizontalSteps)
                .indicators(self.indicationTypes)
                .stepIndicatorMode(StepperMode.horizontal)
                .spacing(50)
                .lineOptions(StepperLineOptions.custom(1, Colors.blue(.teal).rawValue))
                .padding(.top, 20)
                .onAppear {
                    // at specific index
                    self.horizontalSteps.insert( TextView(text:"Processing"), at: 1)
                }
        }
    }
}
