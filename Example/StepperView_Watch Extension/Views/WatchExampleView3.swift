//
//  WatchExampleView3.swift
//  StepperView_Watch Extension
//
//  Created by Venkatnarayansetty, Badarinath on 5/9/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import SwiftUI
import StepperView

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct WatchExampleView3: View {
    
    let indicators = [
           StepperIndicationType.custom(CircledIconView(image: Image("like"),
                                                        width: 30,
                                                        strokeColor: Color(UIColor(red: 26/255, green: 188/255, blue: 156/255, alpha: 1.0)))
                               .eraseToAnyView()),
           StepperIndicationType.custom(CircledIconView(image: Image("flag"),
                                                        width: 30,
                                                        strokeColor: Color.red)
                               .eraseToAnyView()),
           StepperIndicationType.custom(CircledIconView(image: Image("cc"),
                                    width: 30,
                                    strokeColor: Colors.teal.rawValue)
           .eraseToAnyView()),
           StepperIndicationType.custom(CircledIconView(image: Image("book"),
                                                        width: 30,
                                                        strokeColor: Colors.gray(.darkSilver).rawValue)
                               .eraseToAnyView())]
    
    let steps = [TextView(text:"Like", font: .system(size: 14, weight: .semibold)),
                 TextView(text:"Flag", font: .system(size: 14, weight: .semibold)),
                 TextView(text:"Card", font: .system(size: 14, weight: .semibold)),
                 TextView(text:"Book", font: .system(size: 14, weight: .semibold))]
    
    var body: some View {
        ScrollView(Axis.Set.vertical, showsIndicators: true) {
            StepperView()
                .addSteps(steps)
                .indicators(indicators)
                .spacing(30)
                .padding(.leading, 10)
        }
    }
}
