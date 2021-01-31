//
//  ExampleView7.swift
//  StepperView_Example
//
//  Created by Venkatnarayansetty, Badarinath on 5/11/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import SwiftUI
import StepperView

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct ExampleView7: View {
    
    let indicationTypes = [
        StepperIndicationType<NumberedCircleView>.animation(NumberedCircleView(text: "1")),
                                                .animation(NumberedCircleView(text: "2")),
                                                .animation(NumberedCircleView(text: "3")),
                                                .animation(NumberedCircleView(text: "4")),
                                                .animation(NumberedCircleView(text: "5")),
        .animation(NumberedCircleView(text: "6"))
    ]
    
    let set = [ Text("Campaign").font(.caption),
                     Text("Contents").font(.caption),
                     Text("Recipients").font(.caption),
                     Text("Delivery").font(.caption),
                     Text("Tracking").font(.caption),
                     Text("Complete").font(.caption)
    ]
    
    var body: some View {
        ScrollView(Axis.Set.horizontal, showsIndicators: false) {
            StepperView()
                .addSteps(self.set)
                .indicators(self.indicationTypes)
                .stepIndicatorMode(StepperMode.horizontal)
                .spacing(50)
                .lineOptions(StepperLineOptions.custom(1, Colors.blue(.teal).rawValue))
                .loadingAnimationTime(0.02) //speed of the animation
                .padding(.horizontal, 40)
                .frame(height: 300)
        }
    }
}
