//
//  ExampleView10.swift
//  StepperView_Example
//
//  Created by Venkatnarayansetty, Badarinath on 1/11/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import SwiftUI
import StepperView

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct ExampleView10: View {
        
    let cells = [ TestTextView(text:"Insert ATM Card"),
                  TestTextView(text:"Enter 4-Digit ATM Pin"),
                  TestTextView(text:"Select the type of Transaction"),
                  TestTextView(text:"Select the type of Transaction")
                ]
    
    let circleIndicators = [StepperIndicationType<AnyView>.circle(Colors.teal.rawValue, 30),
                            StepperIndicationType<AnyView>.circle(Colors.teal.rawValue, 30),
                            StepperIndicationType<AnyView>.circle(Colors.teal.rawValue, 30),
                            StepperIndicationType<AnyView>.circle(Colors.teal.rawValue, 30)
    ]
        
    var body: some View {
            StepperView()
                .addSteps(cells)
                .spacing(60)
                .indicators(circleIndicators)
                .stepIndicatorMode(StepperMode.horizontal)
                .lineOptions(StepperLineOptions.custom(1, Colors.blue(.teal).rawValue))
                .padding(.vertical, 50)
                //.autoSpacing(true) //Uncomment for auto spacing detection between the steps.
    }
}

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct TestTextView: View {
    var text:String
    var body: some View {
        VStack {
            Text(text)
                .frame(maxWidth: .infinity, alignment: .center)
                .font(.caption)
                .lineLimit(nil)
                .padding(.leading, 5)
        }
    }
}
