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

struct StepTextView: View {
    var text:String
    var body: some View {
        VStack {
            TextView(text: text, font: Font.system(size: 16, weight: Font.Weight.medium))
                .foregroundColor(Colors.blue(.teal).rawValue)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 10)
        }
    }
}
