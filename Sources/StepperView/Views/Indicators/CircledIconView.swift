//
//  IconView.swift
//  StepperView
//
//  Created by Venkatnarayansetty, Badarinath on 4/26/20.
//

import SwiftUI

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public struct CircledIconView: View {
    public var image:Image
    public var width:CGFloat
    public var color:Color
    public var strokeColor:Color
    
    public init(image:Image, width:CGFloat, color: Color = Color.white, strokeColor: Color = Colors.gray(.light).rawValue) {
        self.image = image
        self.width = width
        self.color = color
        self.strokeColor = strokeColor
    }
    
    public var body: some View {
        VStack {
            Circle()
                .foregroundColor(self.color)
                .frame(width: width, height: width)
                .overlay(Circle()
                    .stroke(strokeColor, lineWidth: 1)
                    .foregroundColor(self.color)
                    .overlay(image
                        .resizable()
                        .frame(width: width/2, height: width/2)
                        .aspectRatio(contentMode: .fit)))
        }
    }
}
