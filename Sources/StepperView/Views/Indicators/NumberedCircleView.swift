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
    
    ///initilazes `text` , `width`  and  `color`
    public init(text:String, width:CGFloat = 28.0, color: Color = Colors.teal.rawValue) {
        self.text = text
        self.width = width
        self.color = color
    }
    
    /// provides the content and behavior of this view.
    public var body: some View {
        Circle()
            .foregroundColor(Color.white)
            .frame(width: width, height: width)
        .overlay(
            Circle()
                .stroke(Colors.blue(.teal).rawValue, lineWidth: 1)
                .overlay(
                    Text(text)
                    .foregroundColor(color)
                        .font(.subheadline))
        )
    }
}
