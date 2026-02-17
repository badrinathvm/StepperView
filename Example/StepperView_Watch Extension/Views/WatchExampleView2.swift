//
//  WatchExampleView2.swift
//  StepperView_Watch Extension
//
//  Created by Venkatnarayansetty, Badarinath on 5/9/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import SwiftUI
import StepperView

struct WatchExampleView2: View {
    
    let indicationTypes = [
     StepperIndicationType.custom(NumberedCircleView(text: "1", color: Colors.blue(.lightSky).rawValue)),
                     .custom(NumberedCircleView(text: "2", color: Colors.blue(.lightSky).rawValue)),
    .custom(NumberedCircleView(text: "3", color: Colors.blue(.lightSky).rawValue))]
           
    let set3 = [ TextView(text:"Account"),
                  TextView(text:"Profile"),
                  TextView(text:"Track")]
    
    var body: some View {
            StepperView()
                .addSteps(self.set3)
                .stepIndicatorMode(StepperMode.horizontal)
                .indicators(self.indicationTypes)
                .spacing(40)
                .lineOptions(StepperLineOptions.custom(1, Colors.blue(.teal).rawValue))
                .padding(.leading, 2)
    }
}
