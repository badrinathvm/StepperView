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
struct StepDesignerView: View{
    
    //alignemts for the cell here to point
    let alignments = [StepperAlignment.top,StepperAlignment.center,StepperAlignment.bottom]
    
    let circleIndicators = [StepperIndicationType<AnyView>.circle, StepperIndicationType.circle, StepperIndicationType.circle]

    //Custom Indicators to point.
    let mixMatchIndicators = [StepperIndicationType.image(Image(systemName: "arrowshape.turn.up.right.fill")),
                          StepperIndicationType.image(Image(systemName: "arrowshape.turn.up.right.circle")),
                          StepperIndicationType.custom(ImageView(name: "arrow.uturn.right").eraseToAnyView())]
        
    //custom cells
    let cells = [StepperContentView(), StepperContentView(), StepperContentView() ]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 5) {
                ScrollView(Axis.Set.vertical, showsIndicators: false) {
                    HStack {
                        StepperView(cells: [ PointerView(text: "Top") ] , alignments: [.top ] , indicationType: [StepperIndicationType<AnyView>.circle])
                        StepperView(cells: [PointerView(text: "Bottom")] , alignments: [.bottom ] , indicationType: [StepperIndicationType<AnyView>.circle] )
                        Spacer()
                    }

                    HStack {
                        //Stepper Indicator with Circle pointers
                        StepperView(cells: self.cells, alignments: self.alignments, indicationType : self.circleIndicators)
                        
                         //Stepper Indicator with custom pointers
                        StepperView(cells: self.cells, alignments: self.alignments, indicationType : self.mixMatchIndicators,verticalSpacing: 10.0)
                    }
                    
                }
            }
             .navigationBarTitle("Stepper View")
        }
    }
}


