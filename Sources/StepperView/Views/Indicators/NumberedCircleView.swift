//
//  NumberCircleView.swift
//  StepperView_Example
//
//  Created by Venkatnarayansetty, Badarinath on 4/9/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import SwiftUI

// MARK: - Circle view with text inside
/// Circle view with text inside for Step Indicator
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public struct NumberedCircleView: View {
    /// test to be paced inside the circle
    public var text:String
    /// width of the step indicator
    public var width:CGFloat
    /// color of the step indicator
    public var color:Color
    /// detect the color scheme i.e., light or dark mode
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    ///initilazes `text` , `width`  and  `color`
    public init(text:String, width:CGFloat = 28.0, color: Color = Colors.teal.rawValue) {
        self.text = text
        self.width = width
        self.color = color
    }
    
    /// provides the content and behavior of this view.
    public var body: some View {
        Circle()
            .foregroundColor(colorScheme == .light ? Color.white : Color.black)
            .frame(width: width, height: width)
        .overlay(
            Circle()
                .stroke(color, lineWidth: 1)
                .overlay(
                    Text(text)
                    .foregroundColor(color)
                        .font(.subheadline))
        )
    }
}
