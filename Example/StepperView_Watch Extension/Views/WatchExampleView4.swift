//
//  WatchExampleView4.swift
//  StepperView_Watch Extension
//
//  Created by Venkatnarayansetty, Badarinath on 5/10/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import SwiftUI
import StepperView

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct WatchExampleView4: View {
    
    let indicators = [
              StepperIndicationType.custom(CircledIconView(image: Image("like"),
                                                           width: 25,
                                                           strokeColor: Color(UIColor(red: 26/255, green: 188/255, blue: 156/255, alpha: 1.0)))
                                  .eraseToAnyView()),
              StepperIndicationType.custom(CircledIconView(image: Image("star"),
                                                           width: 25,
                                                           strokeColor: Color.red)
                                  .eraseToAnyView()),
              StepperIndicationType.custom(CircledIconView(image: Image("pullrequest"),
                                                        width: 25,
                                                        strokeColor: Colors.gray(.darkSilver).rawValue)
                               .eraseToAnyView())]
       
    let steps = [TextView(text:"Like", font: .system(size: 14, weight: .semibold)),
                TextView(text:"Star", font: .system(size: 14, weight: .semibold)),
                TextView(text:"Create", font: .system(size: 14, weight: .semibold))]
    
    let pitStops = [
        TextView(text: "StepperView",font: .system(size: 12, weight: .semibold)).eraseToAnyView(),
        TextView(text:"Repository", font: .system(size: 12, weight: .semibold)).eraseToAnyView(),
        TextView(text:"Pull Request", font: .system(size: 12, weight: .semibold)).eraseToAnyView()
    ]
    
    let pitStopLineOptions = [
           StepperLineOptions.custom(1, Color(UIColor(red: 26/255, green: 188/255, blue: 156/255, alpha: 1.0))),
           StepperLineOptions.custom(1, Colors.red(.normal).rawValue),
           StepperLineOptions.custom(1, Colors.gray(.light).rawValue)]
    
    var body: some View {
            List {
                StepperView()
                       .addSteps(steps)
                       .indicators(indicators)
                       .addPitStops(pitStops)
                       .pitStopLineOptions(pitStopLineOptions)
                       .spacing(60)
                       .padding(.leading, 10)
                 .listRowBackground(Color.black)
            }.padding(.leading, 20)
               
    }
}
