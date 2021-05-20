//
//  IconView.swift
//  StepperView
//
//  Created by Venkatnarayansetty, Badarinath on 4/26/20.
//

import SwiftUI

/// A  Circled Icon `View ` for Step Indicator
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public struct CircledIconView: View {
    /// icon for the step indicator
    public var image:Image
    /// width for step indicator
    public var width:CGFloat
    /// color for step indicator
    public var color:Color
    /// stroke color for step indicator
    public var strokeColor:Color
    /// detect the color scheme i.e., light or dark mode
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    /// initiazes `image` , `width` , `color` and  `strokeColor`
    public init(image:Image, width:CGFloat, color: Color = Color.black, strokeColor: Color = Colors.blue(.lightSky).rawValue) {
        self.image = image
        self.width = width
        self.color = color
        self.strokeColor = strokeColor
    }
    
    /// provides the content and behavior of this view.
    public var body: some View {
        VStack {
            Circle()
                .foregroundColor(colorScheme == .light ? Color.white : Color.black )
                .frame(width: width, height: width)
                .overlay(Circle()
                    .stroke(strokeColor, lineWidth: 1)
                    .overlay(image
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(self.color)
                        .frame(width: width/2, height: width/2)
                        .aspectRatio(contentMode: .fit)))
        }
    }
}
