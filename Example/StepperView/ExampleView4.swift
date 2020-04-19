//
//  StepDesignerView.swift
//  Basics
//
//  Created by Venkatnarayansetty, Badarinath on 4/2/20.
//  Copyright © 2020 Badarinath Venkatnarayansetty. All rights reserved.
//

import SwiftUI
import StepperView

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct ExampleView4: View {
    
    //alignments for the cell here to point
    let alignments = [StepperAlignment.top, StepperAlignment.center, StepperAlignment.bottom]
    
    let circleIndicators = [StepperIndicationType<AnyView>.circle(Colors.teal.rawValue, 12),
                    StepperIndicationType<AnyView>.circle(Colors.teal.rawValue, 12),
                    StepperIndicationType<AnyView>.circle(Colors.teal.rawValue, 12)]

    //Custom Indicators to point.
    let mixMatchIndicators = [
        StepperIndicationType.image(Image(systemName: "arrowshape.turn.up.right.fill"), 12),
                          StepperIndicationType.image(Image(systemName: "arrowshape.turn.up.right.circle"), 12),
                          StepperIndicationType.custom(ImageView(name: "arrow.uturn.right").eraseToAnyView())]
        
    //custom cells
    let cells = [StepperContentView(), StepperContentView(), StepperContentView() ]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                ScrollView(Axis.Set.vertical, showsIndicators: false) {
                    HStack {
                        //Stepper Indicator with Circle pointers
                        StepperView()
                            .addSteps(self.cells)
                            .alignments(self.alignments)
                            .indicators(self.circleIndicators)
                        
                        //Stepper Indicator with custom pointers
                        StepperView()
                            .addSteps(self.cells)
                            .alignments(self.alignments)
                            .indicators(self.mixMatchIndicators)
                    }
                }
            }
             .navigationBarTitle("Stepper View")
        }
    }
}
