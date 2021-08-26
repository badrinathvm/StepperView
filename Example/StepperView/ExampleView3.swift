//
//  Example3.swift
//  StepperView_Example
//
//  Created by Venkatnarayansetty, Badarinath on 4/9/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import SwiftUI
import StepperView

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct ExampleView3:View {
    
    let cells = [ ImageTextRowView(text: "Insert ATM Card", imageName: "cc"),
                  ImageTextRowView(text: "Select transaction and enter pin", imageName: "transaction"),
                  ImageTextRowView(text: "Collect Cash", imageName: "cash"),
                  ImageTextRowView(text: "Select type of Account", imageName: "cash")
                ]
    
    let alignments = [StepperAlignment.center, .top, .center, .bottom]
    
    let indicationTypes = [
                StepperIndicationType<AnyView>.circle(Colors.teal.rawValue, 12),
                StepperIndicationType.circle(Colors.teal.rawValue, 12),
                StepperIndicationType.circle(Colors.teal.rawValue, 12),
                StepperIndicationType.circle(Colors.teal.rawValue, 12)
            ]
    
    var body: some View {
        NavigationView {
            ScrollView(Axis.Set.vertical, showsIndicators: false) {
                VStack {
                    HStack {
                        StepperView()
                            .addSteps(self.cells)
                            .alignments(alignments)
                            .stepIndicatorMode(StepperMode.vertical)
                            .indicators(indicationTypes)
                            .lineOptions(StepperLineOptions.custom(1, Colors.blue(.teal).rawValue))
                            .stepperEdgeInsets(EdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 10)) // for custom leading , trailing , top and bottom spacing
                    }
                }.padding(.vertical, 50)
            }
            .navigationBarTitle("StepperView")
        }
    }
}
