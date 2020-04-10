//
//  PointerView.swift
//  StepperView_Example
//
//  Created by Venkatnarayansetty, Badarinath on 4/7/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct TextHolderView: View {
    var text: String
    var body: some View {
        VStack {
            Text(text)
                .padding()
                .foregroundColor(Color.gray)
                .border(Color.black)
        }
    }
}
