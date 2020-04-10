//
//  LineView.swift
//  StepperView
//
//  Created by Venkatnarayansetty, Badarinath on 4/6/20.
//

import SwiftUI

//MARK:- Line View for Stepper
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct LineView: View {
    @Binding var lineHeight:CGFloat
    @Binding var lineXPosition:CGFloat
    @Binding var lineYPosition:CGFloat
    var options:StepperLineOptions
    var alignment:StepperAlignment
    var body:some View {
        switch options {
        case .defaults:
            return Divider()
                .background(Color.gray)
                .frame(height: lineHeight)
                .offset(x: (lineXPosition/2 - Utils.halfSpacing) - 1, y: (lineYPosition - lineYPosition / 2 ))
                .padding()
                .eraseToAnyView()
        case .custom(let width, let color):
            return Rectangle()
                    .fill(color)
                    .frame(width: width, height: lineHeight)
                    // X: subtract one pixel only if the width is 1
                    // Y: subtract half of the lineYposition to set to it's center position.
                    .offset(x: width == 1 ? lineXPosition/2 - Utils.halfSpacing - 1 : (lineXPosition/2 - Utils.halfSpacing) , y: (lineYPosition - lineYPosition / 2))
                    .padding()
                    .eraseToAnyView()
        }
    }
}
