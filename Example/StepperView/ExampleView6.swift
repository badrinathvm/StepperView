//
//  ExampleView6.swift
//  StepperView_Example
//
//  Created by Venkatnarayansetty, Badarinath on 4/25/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import SwiftUI
import StepperView

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct ExampleView6: View {
    
    let circleIndicators = [
        StepperIndicationType<AnyView>.custom(
            CircledIconView(image: Image("flag"), width: 40, color: Colors.gray(.light).rawValue).eraseToAnyView().eraseToAnyView()),
        StepperIndicationType.custom(CircledIconView(image: Image("like"), width: 40, color: Colors.gray(.light).rawValue).eraseToAnyView().eraseToAnyView()),
        StepperIndicationType.custom(CircledIconView(image: Image("book"), width: 40, color: Colors.gray(.light).rawValue).eraseToAnyView())
                            ]
    
    var body: some View {
        VStack {
            StepperView()
                .addSteps([
                    TextView(text:"Welcome to pitstop, questions to be asked for wondeful community"), TextView(text:"Answer"), TextView(text:"References")])
                .indicators(circleIndicators)
                .stepLineOptions(StepperLineOptions.custom(1, Colors.gray(.light).rawValue))
                .addPitstops([TextView(text:"PitStop 1"), TextView(text:"PitStop 2"), TextView(text:"PitStop 3")])
                .pitStopLineOptions(PitStopLineOptions.custom(1, Colors.red(.normal).rawValue))
                .spacing(100)
        }
    }
}
