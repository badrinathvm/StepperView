//
//  StepTextView.swift
//  StepperView_Example
//
//  Created by Venkatnarayansetty, Badarinath on 4/14/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import SwiftUI
import StepperView

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct StepTextView: View {
    var text:String
    var body: some View {
        VStack {
            Text(text)
                .foregroundColor(Colors.blue(.teal).rawValue)
                .font(.system(size: 16, weight: Font.Weight.medium))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 10)
        }
    }
}
