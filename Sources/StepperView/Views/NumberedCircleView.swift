//
//  NumberCircleView.swift
//  StepperView_Example
//
//  Created by Venkatnarayansetty, Badarinath on 4/9/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import SwiftUI

// MARK: - Helper view to warp text inside the circle
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public struct NumberedCircleView: View {
    public var text:String
    
    public init(text:String) {
        self.text = text
    }
    
    public var body: some View {
        Circle()
            .foregroundColor(Color.white)
            .frame(width: 28, height: 28)
        .overlay(
            Circle()
                .stroke(Colors.blue(.teal).rawValue, lineWidth: 1)
                .overlay(
                    Text(text)
                    .foregroundColor(Colors.blue(.teal).rawValue)
                    .font(.system(size: 12, weight: Font.Weight.bold)))
        )
    }
}
