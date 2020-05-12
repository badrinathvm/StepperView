//
//  WatchExampleView5.swift
//  StepperView_Watch Extension
//
//  Created by Venkatnarayansetty, Badarinath on 5/11/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import SwiftUI
import StepperView

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct WatchExampleView5: View {
    
    let indicationTypes = [
        StepperIndicationType<NumberedCircleView>.animation(NumberedCircleView(text: "1")),
                                                .animation(NumberedCircleView(text: "2")),
                                                .animation(NumberedCircleView(text: "3")),
                                                .animation(NumberedCircleView(text: "4"))]
    
    let set = [ TextView(text: "Campaign", font: Font.system(size: 12, weight: Font.Weight.semibold)),
                TextView(text:"Contents", font: Font.system(size: 12, weight: Font.Weight.semibold)),
                TextView(text:"Recipients", font: Font.system(size: 12, weight: Font.Weight.semibold)),
                TextView(text:"Delivery", font: Font.system(size: 12, weight: Font.Weight.semibold))]
    
    var body: some View {
           StepperView()
            .addSteps(self.set)
            .indicators(self.indicationTypes)
            .stepIndicatorMode(StepperMode.vertical)
            .spacing(15)
            .lineOptions(StepperLineOptions.custom(1, Colors.blue(.lightSky).rawValue))
            .padding(.leading, 10)
            .padding(.top, 10)
    }
}
