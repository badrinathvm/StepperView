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
    let cells = [ CustomStepTextView(text: "Basic Details"),
                  CustomStepTextView(text: "Company Details"),
                  CustomStepTextView(text: "Subscription plan"),
                  CustomStepTextView(text: "Payment details")
    ]
    
    //Custom Indicators to point.
    let indicators = [
        StepperIndicationType.custom(IndicatorImageView(name: "completed").eraseToAnyView()),
        StepperIndicationType.custom(IndicatorImageView(name: "completed").eraseToAnyView()),
        StepperIndicationType.custom(IndicatorImageView(name:"pending").eraseToAnyView()),
        StepperIndicationType.custom(IndicatorImageView(name:"pending").eraseToAnyView())
    ]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 10) {
                Section(header: Text("Horizontal").foregroundColor(Color.black).font(.headline).padding()) {
                    ScrollView(Axis.Set.horizontal, showsIndicators: false) {
                        StepperView()
                            .addSteps([
                                CustomStepTextView(text: "Card details"),
                                CustomStepTextView(text: "Application review"),
                                CustomStepTextView(text: "Authenticate OTP"),
                                CustomStepTextView(text: "Create password")
                            ])
                            .indicators([
                                StepperIndicationType.custom(IndicatorImageView(name: "completed")),
                                StepperIndicationType.custom(IndicatorImageView(name: "completed")),
                                StepperIndicationType.custom(IndicatorImageView(name: "completed")),
                                StepperIndicationType.custom(IndicatorImageView(name:"pending"))
                            ])
                            .stepIndicatorMode(StepperMode.horizontal)
                            .lineOptions(StepperLineOptions.rounded(4, 8, Color(customGreen)))
                            .stepLifeCycles([StepLifeCycle.completed, .completed, .completed, .completed, .completed ])
                            .spacing(70)
                            .padding(.all, 40)
                    }
                    
                    ScrollView(Axis.Set.horizontal, showsIndicators: false) {
                        StepperView()
                            .addSteps(cells)
                            .indicators(indicators)
                            .stepIndicatorMode(StepperMode.horizontal)
                            .lineOptions(StepperLineOptions.rounded(4, 8, Color(customGreen)))
                            .stepLifeCycles([StepLifeCycle.completed, .completed, .pending, .pending])
                            .spacing(70)
                            .padding(.all, 40)
                    }
                    
                    StepperView()
                        .addSteps([
                            CustomStepTextView(text: "Announced"),
                            CustomStepTextView(text: "Dividend Payment")
                        ])
                        .indicators([
                            StepperIndicationType.custom(IndicatorImageView(name: "completed")),
                            StepperIndicationType.custom(IndicatorImageView(name: "completed"))
                        ])
                        .stepIndicatorMode(StepperMode.horizontal)
                        .lineOptions(StepperLineOptions.rounded(4, 8, Color(customGreen)))
                        .stepLifeCycles([StepLifeCycle.completed, .completed ])
                        .spacing(70)
                        .padding(.all, 40)
                }
                
                Divider()
                
                Section(header: Text("Vertical").foregroundColor(Color.black).font(.headline).padding()) {
                    StepperView()
                        .addSteps([
                            CustomStepTextView(text: "Card details"),
                            CustomStepTextView(text: "Application review"),
                            CustomStepTextView(text: "Authenticate OTP"),
                            CustomStepTextView(text: "Create password")
                        ])
                        .indicators([
                            StepperIndicationType.custom(IndicatorImageView(name: "completed")),
                            StepperIndicationType.custom(IndicatorImageView(name: "completed")),
                            StepperIndicationType.custom(IndicatorImageView(name: "completed")),
                            StepperIndicationType.custom(IndicatorImageView(name:"pending"))
                        ])
                        .lineOptions(StepperLineOptions.rounded(4, 8, Color(customGreen)))
                        .stepLifeCycles([StepLifeCycle.completed, .completed, .completed, .pending])
                        .spacing(40)
                        .padding(.leading, 50)
                    
                    StepperView()
                        .addSteps(cells)
                        .indicators(indicators)
                        .lineOptions(StepperLineOptions.rounded(4, 8, Color(customGreen)))
                        .stepLifeCycles([StepLifeCycle.completed, .completed, .pending, .pending])
                        .spacing(40)
                        .padding(.leading, 50)
                    
                    StepperView()
                        .addSteps([
                            CustomStepTextView(text: "Announced"),
                            CustomStepTextView(text: "Dividend Payment")
                        ])
                        .indicators([
                            StepperIndicationType.custom(IndicatorImageView(name: "completed")),
                            StepperIndicationType.custom(IndicatorImageView(name: "completed"))
                        ])
                        .lineOptions(StepperLineOptions.custom(4, Color(customGreen)))
                        .stepLifeCycles([StepLifeCycle.completed, .completed ])
                        .spacing(50)
                        .padding(.leading, 10)
                }
            }
        }
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
