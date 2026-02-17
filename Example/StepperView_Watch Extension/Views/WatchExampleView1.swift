//
//  WatchExampleView1.swift
//  StepperView_Watch Extension
//
//  Created by Venkatnarayansetty, Badarinath on 5/9/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import SwiftUI
import StepperView

struct WatchExampleView1: View {
    
    //step indications types
    let indicationTypes = [
        StepperIndicationType.custom(NumberedCircleView(text: "1", color: Colors.blue(.lightSky).rawValue)),
                        .custom(NumberedCircleView(text: "2", color: Colors.blue(.lightSky).rawValue)),
       .custom(NumberedCircleView(text: "3", color: Colors.blue(.lightSky).rawValue)),
       .custom(NumberedCircleView(text: "4", color: Colors.blue(.lightSky).rawValue))]
    
    let set1 = [TextView(text:"Approval", font: Font.system(size: 14, weight: Font.Weight.medium)),
                   TextView(text:"Processing", font:Font.system(size: 14, weight: Font.Weight.medium)),
                   TextView(text:"Shipping", font:Font.system(size: 14, weight: Font.Weight.medium)),
                   TextView(text:"Tracking", font:Font.system(size: 14, weight: Font.Weight.medium))]
    
    var body: some View {
        ScrollView(Axis.Set.vertical, showsIndicators: true) {
            StepperView()
                   .addSteps(self.set1)
                   .indicators(self.indicationTypes)
                   .stepIndicatorMode(StepperMode.vertical)
                   .spacing(30)
                   .lineOptions(StepperLineOptions.custom(1, Colors.blue(.lightSky).rawValue))
                   .padding(.leading, 10)
         }
    }
}
