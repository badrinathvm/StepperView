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
        StepperIndicationType.custom(AnimatedCircleView(text: "1", width: 30).eraseToAnyView()),
        StepperIndicationType.custom(AnimatedCircleView(text: "2", width: 30).eraseToAnyView()),
        StepperIndicationType.custom(AnimatedCircleView(text: "3", width: 30).eraseToAnyView()),
        StepperIndicationType.custom(AnimatedCircleView(text: "4", width: 30).eraseToAnyView()),
        StepperIndicationType.custom(AnimatedCircleView(text: "5", width: 30).eraseToAnyView())]
    
       let set1 = [ Text("Cart").font(.caption),
                     Text("Delivery Address").font(.caption),
                     Text("Order Summary").font(.caption),
                     Text("Payment Method").font(.caption),
                     Text("Track").font(.caption)]
    
    var body: some View {
        StepperView()
            .addSteps(self.set1)
            .indicators(self.indicationTypes)
            .stepIndicatorMode(StepperMode.horizontal)
            .spacing(50)
            .lineOptions(StepperLineOptions.custom(1, Colors.blue(.teal).rawValue))
            .stepAnimations([0:true, 1:true])
    }
}
