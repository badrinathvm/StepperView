//
//  FurtherReadingView.swift
//  StepperView_Example
//
//  Created by Venkatnarayansetty, Badarinath on 4/27/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct FurtherReadingView:View {
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Button("Github - StepperView") {
                UIApplication.shared.open(URL(string:"https://github.com/badrinathvm/StepperView")!)
            }
            Button("cocoapods - StepperView") {
                 UIApplication.shared.open(URL(string:"https://cocoapods.org/pods/StepperView")!)
            }
            Button("Step Indicator on  Medium") {
                 UIApplication.shared.open(URL(string:"https://medium.com/@badrinathvm/step-indicator-in-swiftui-104e0486d133")!)
            }
        }
    }
}
