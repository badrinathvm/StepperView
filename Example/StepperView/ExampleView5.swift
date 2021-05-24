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
        StepperIndicationType.custom(NumberedCircleView(text: "1")),
                            .custom(NumberedCircleView(text: "2")),
                            .custom(NumberedCircleView(text: "3")),
                            .custom(NumberedCircleView(text: "4")),
                            .custom(NumberedCircleView(text: "5"))]
    
    let indicationTypes1 = [
           StepperIndicationType<NumberedCircleView>.animation(NumberedCircleView(text: "1")),
                                                   .animation(NumberedCircleView(text: "2")),
                                                   .animation(NumberedCircleView(text: "3")),
                                                   .animation(NumberedCircleView(text: "4")),
                                                   .animation(NumberedCircleView(text: "5"))]
        
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
            ScrollView(Axis.Set.vertical, showsIndicators: false) {
                VStack(spacing: 10) {
                    StepperView()
                        .addSteps(self.set1)
                        .indicators(self.indicationTypes)
                        .stepIndicatorMode(StepperMode.horizontal)
                        .spacing(50)
                        .lineOptions(StepperLineOptions.custom(1, Colors.blue(.teal).rawValue))
                        .padding(.top, 50)
                    
                    //animated stepper View
                    ExampleView7()
                        .frame(height: 100)
                        .offset(y: 30)

                    StepperView()
                            .addSteps(self.set2)
                            .indicators(self.indicationTypes)
                            .spacing(30)
                            .lineOptions(StepperLineOptions.custom(1, Colors.blue(.teal).rawValue))
                            .offset(x: UIScreen.main.bounds.size.width / 4)
                    
                    //Animated stepper view
                    StepperView()
                        .addSteps(self.set3)
                        .indicators(self.indicationTypes1)
                        .spacing(30)
                        .lineOptions(StepperLineOptions.custom(1, Colors.blue(.teal).rawValue))
                        .loadingAnimationTime(0.02) // speed of the animation.
                        .offset(x: UIScreen.main.bounds.size.width / 4)
                }
                
            }
            .navigationBarTitle("StepperView")
        }
    }
}
