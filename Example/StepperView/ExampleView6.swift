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
import WebKit

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct ExampleView6: View {
    
    let indicators = [
        StepperIndicationType<AnyView>.custom(NumberedCircleView(text: "1", width: 40).eraseToAnyView()),
        StepperIndicationType.custom(CircledIconView(image: Image("like"),
                                                     width: 40,
                                                     strokeColor: Color(UIColor(red: 26/255, green: 188/255, blue: 156/255, alpha: 1.0)))
                                        .eraseToAnyView()),
        StepperIndicationType.custom(CircledIconView(image: Image("flag"),
                                                     width: 40,
                                                     strokeColor: Color.red)
                                        .eraseToAnyView()),
        StepperIndicationType.custom(CircledIconView(image: Image("book"),
                                                     width: 40,
                                                     strokeColor: Colors.gray(.darkSilver).rawValue)
                                        .eraseToAnyView())]
    
    let steps = [TextView(text:"Question", font: .system(size: 14, weight: .semibold)),
                 TextView(text:"Expected Answer", font: .system(size: 14, weight: .semibold)),
                 TextView(text:"Red Flags", font: .system(size: 14, weight: .semibold)),
                 TextView(text:"Further Reading", font: .system(size: 14, weight: .semibold))]
    
    let pitStops = [
        TextView(text:PitStopText.p1).eraseToAnyView(),
        TextView(text:PitStopText.p2).eraseToAnyView(),
        TextView(text:PitStopText.p3).eraseToAnyView(),
        FurtherReadingView().eraseToAnyView()
    ]
    
    let pitStopLines = [
        StepperLineOptions.custom(1, Colors.teal.rawValue),
        StepperLineOptions.custom(1, Color(UIColor(red: 26/255, green: 188/255, blue: 156/255, alpha: 1.0))),
        StepperLineOptions.custom(1, Color.red),
        StepperLineOptions.custom(1, Colors.gray(.darkSilver).rawValue)
    ]
    
    var body: some View {
        VStack {
            StepperView()
                .addSteps(steps)
                .indicators(indicators)
                .addPitStops(pitStops)
                .pitStopLineOptions(pitStopLines)
                //.spacing(100) // sets the spacing to value specified.
                .autoSpacing(true) // auto calculates spacing between steps based on the content.
        }
    }
}

struct PitStopText {
    static var p1 = "What are Step Indicators? How do you represent them ?"
    static var p2 = "Step indicators are used to represent an ordered, sequential process."
        + "They can be used as navigation, or just as a visual indicator for where a user is within a process."
    static var p3 = "Even though some languages and platforms does not provide the component."
        + "Step Indicators are considered to be good, they are in fact an best way to represent the sequence of actions."
}
