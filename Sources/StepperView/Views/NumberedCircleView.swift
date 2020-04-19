//
//  NumberCircleView.swift
//  StepperView_Example
//
//  Created by Venkatnarayansetty, Badarinath on 4/9/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import SwiftUI

// MARK: - Circle view with text inside
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public struct NumberedCircleView: View {
    public var text:String
    public var width:CGFloat
    public var color:Color
    
    public init(text:String, width:CGFloat = 28.0, color: Color = Colors.blue(.teal).rawValue) {
        self.text = text
        self.width = width
        self.color = color
    }
    
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
