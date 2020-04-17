//
//  ExampleView6.swift
//  StepperView_Example
//
//  Created by Venkatnarayansetty, Badarinath on 4/15/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import SwiftUI
import StepperView

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct ExampleView5: View {
    
    let indicationTypes = [
                 StepperIndicationType.custom(NumberedCircleView(text: "1").eraseToAnyView()),
                     .custom(NumberedCircleView(text: "2").eraseToAnyView()),
    .custom(NumberedCircleView(text: "3").eraseToAnyView()),
    .custom(NumberedCircleView(text: "4").eraseToAnyView()),
     .custom(NumberedCircleView(text: "5").eraseToAnyView())]
        
    let set1 = [ Text("Cart").font(.caption),
                  Text("Delivery Address").font(.caption),
                  Text("Order Summary").font(.caption),
                  Text("Payment Method").font(.caption),
                  Text("Track").font(.caption)]
    
    let set2 = [TextView(text:"Approval"),
                 TextView(text:"Processing"),
                  TextView(text:"Shipping"),
                  TextView(text:"Delivery"),
                  TextView(text:"Tracking")]
    
    let set3 = [ TextView(text:"Account"),
                  TextView(text:"Profile"),
                  TextView(text:"Band"),
                  TextView(text:"Membership"),
                  TextView(text:"Dashboard")]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 100) {
                StepperView(cells: self.set1,
                            indicationType:indicationTypes,
                            lineOptions: StepperLineOptions.custom(1, Colors.blue(.teal).rawValue),
                            verticalSpacing: 50,
                            stepperMode: StepperMode.horizontal)
                
                HStack {
                    StepperView(cells: self.set2,
                                indicationType:indicationTypes,
                                lineOptions: StepperLineOptions.custom(1, Colors.blue(.teal).rawValue),
                                verticalSpacing: 30,
                                stepperMode: StepperMode.vertical)
                    
                    StepperView(cells: self.set3,
                                indicationType:indicationTypes,
                                lineOptions: StepperLineOptions.custom(1, Colors.blue(.teal).rawValue),
                                verticalSpacing: 30,
                                stepperMode: StepperMode.vertical)
                }
            }
            .navigationBarTitle("StepperView")
        }
    }
}
