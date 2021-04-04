//
//  ExampleView11.swift
//  StepperView_Example
//
//  Created by Venkatnarayansetty, Badarinath on 4/3/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import SwiftUI
import UIKit
import StepperView

let customGreen = UIColor(red: 0.00, green: 0.80, blue: 0.66, alpha: 1.00)

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct ExampleView11: View {
    let cells = [ CustomStepTextView(text: "Cancellation requested"),
                  CustomStepTextView(text: "In-progress"),
                  CustomStepTextView(text: "Subscription cancelled")
                ]
    
    //Custom Indicators to point.
    let indicators = [
        StepperIndicationType.custom(IndicatorImageView(name: "completed").eraseToAnyView()),
        StepperIndicationType.custom(IndicatorImageView(name: "inprogress").eraseToAnyView()),
        StepperIndicationType.custom(IndicatorImageView(name:"pending").eraseToAnyView())
    ]
    
    var body: some View {
            StepperView()
                .addSteps(cells)
                .indicators(indicators)
                .lineOptions(StepperLineOptions.rounded(4, 8, Color(customGreen)))
                .stepLifeCycles([StepLifeCycle.completed, .pending, .pending])
                .spacing(50)
                .padding(.horizontal, 50)
    }
}

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct IndicatorImageView: View {
    var name:String
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(Color.white)
                .overlay(Image(name)
                            .resizable()
                            .frame(width: 30, height: 30))
                .frame(width: 40, height: 40)
        }
        
    }
}

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct CustomStepTextView: View {
    var text:String
    var body: some View {
        VStack {
            TextView(text: text, font: Font.system(size: 16, weight: Font.Weight.regular))
                .foregroundColor(Color.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .offset(x: -15)
        }
    }
}

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct ExampleView11_Previews: PreviewProvider {
    static var previews: some View {
        ExampleView11()
    }
}
