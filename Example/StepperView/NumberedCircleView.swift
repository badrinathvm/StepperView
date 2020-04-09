//
//  NumberedCircleView.swift
//  StepperView_Example
//
//  Created by Venkatnarayansetty, Badarinath on 4/8/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import SwiftUI
import StepperView

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct NumberedCircleView: View {
    var body: some View {
            Circle()
                .stroke(Color(Colors.blue(.teal).rawValue), lineWidth: 3)
                .frame(width: 28, height: 28)
                .overlay(Text("1")
                        .foregroundColor(Color(Colors.blue(.teal).rawValue))
                    .font(.system(size: 12, weight: Font.Weight.bold)))
    }
}

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct StepTextView: View {
    var body: some View {
        Text("Visit any participating partner store")
            .foregroundColor(Color(Colors.blue(.teal).rawValue))
            .font(.system(size: 16, weight: Font.Weight.bold))
            .padding(.vertical, 10)
    }
}

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct CircledStepView:View {
    let cells = [StepTextView(),StepTextView(), StepTextView()]
    let alignments = [StepperAlignment.center, .center, .center]
    let indicationTypes = [StepperIndicationType.custom(NumberedCircleView().eraseToAnyView()), .custom(NumberedCircleView().eraseToAnyView()),.custom(NumberedCircleView().eraseToAnyView())]
    
    var body: some View {
        HStack {
            StepperView(cells: self.cells, alignments: alignments, indicationType:indicationTypes, lineOptions: StepperLineOptions.custom(3,Color(Colors.blue(.teal).rawValue)))
        }
    }
}
