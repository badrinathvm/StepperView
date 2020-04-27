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
        StepperIndicationType<AnyView>.custom(IconIndicator(name:"flag", color: Colors.red(.normal).rawValue).eraseToAnyView()),
        StepperIndicationType.custom(IconIndicator(name: "like", color: Colors.green(.dark).rawValue).eraseToAnyView()),
        StepperIndicationType.custom(IconIndicator(name: "book", color: Colors.gray(.light).rawValue).eraseToAnyView())
                            ]
    
    var body: some View {
        VStack {
            StepperView()
                .addSteps([TextView(text:"Welcome to pitstop, questions to be asked for wondeful community"), TextView(text:"Answer"), TextView(text:"References")])
                .indicators(circleIndicators)
                .stepLineOptions(StepperLineOptions.custom(1, Colors.gray(.light).rawValue))
                .addPitstops([TextView(text:"Answer")])
                .pitStopLineOptions(PitStopLineOptions.custom(1, Colors.red(.normal).rawValue))
                .spacing(100)
        }
    }
}

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct IconIndicator:View {
    var name:String
    var color:Color
    var body: some View {
        VStack {
            Circle()
            .foregroundColor(Color.white)
            .frame(width: 40, height: 40)
            .overlay( Circle()
                           .stroke(color, lineWidth: 1)
                           .foregroundColor(Color.white)
                           .overlay(Image(name)
                               .resizable()
                                   .frame(width: 20, height: 20)
                               .aspectRatio(contentMode: .fit)))
        }
    }
}
