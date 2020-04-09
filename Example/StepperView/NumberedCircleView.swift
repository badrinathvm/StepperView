//
//  NumberCircleView.swift
//  StepperView_Example
//
//  Created by Venkatnarayansetty, Badarinath on 4/9/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import SwiftUI
import StepperView

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct NumberedCircleView: View {
    var text:String
    var body: some View {
        Circle()
            .foregroundColor(Color.white)
            .frame(width: 28,height: 28)
        .overlay(
            Circle()
                .stroke(Colors.blue(.teal).rawValue, lineWidth: 1)
                .overlay(Text(text).foregroundColor(Colors.blue(.teal).rawValue).font(.system(size: 12, weight: Font.Weight.bold)))
        )
    }
}
