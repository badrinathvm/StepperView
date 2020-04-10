//
//  Example3.swift
//  StepperView_Example
//
//  Created by Venkatnarayansetty, Badarinath on 4/9/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import SwiftUI

import SwiftUI
import StepperView

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct ExampleView3:View {
    
    let cells = [ CustomView(text: "Insert ATM Card", imageName: "cc"),
                  CustomView(text: "Select transaction and enter pin", imageName: "transaction"),
                  CustomView(text: "Collect Cash", imageName: "cash"),
                  CustomView(text: "Select type of Account",imageName: "cash")
                ]
    
    let alignments = [StepperAlignment.center, .center, .bottom, .center]
    
    let indicationTypes = [
                StepperIndicationType<AnyView>.circle(Colors.teal.rawValue),
                StepperIndicationType.circle(Colors.teal.rawValue),
                StepperIndicationType.circle(Colors.teal.rawValue),
                StepperIndicationType.circle(Colors.teal.rawValue)
            ]
    
    var body: some View {
        HStack {
            StepperView(cells: self.cells,
                        alignments: alignments,
                        indicationType:indicationTypes,
                        lineOptions: StepperLineOptions.custom(1,Colors.blue(.teal).rawValue))
        }
    }
}

