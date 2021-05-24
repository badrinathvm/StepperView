//
//  LineView.swift
//  StepperView
//
//  Created by Venkatnarayansetty, Badarinath on 4/6/20.
//

import SwiftUI

/// Vertical Line View for Step Indictor
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct VerticalLineView: View {
    /// binding variable to hold lineHeight
    @Binding var lineHeight:CGFloat
    /// binding variable to linx x-axis position
    @Binding var lineXPosition:CGFloat
    /// binding variable to linx y-axis position
    @Binding var lineYPosition:CGFloat
    /// options for customizing line with either  `defaults` or  custom `width`  and `Color`
    var options:StepperLineOptions
    /// tuple holding first and last stepper alignment
    var alignments:(StepperAlignment, StepperAlignment)
    
    /// contains list of steps to be rendered next to Indicators
    @Environment(\.steps) var steps
    
    /// provides the content and behavior of this view.
    var body:some View {
        switch options {
        case .defaults:
            return Divider()
                .background(Color.gray)
                .frame(height: lineHeight)
                .offset(x: lineXPosition/2 - Utils.threeFourthSpacing, y: (lineYPosition - lineYPosition / 2 ))
                .padding()
                .eraseToAnyView()
        case .custom(let width, let color):
            return Rectangle()
                    .fill(color)
                    .frame(width: width, height: lineHeight)
                    // X: subtract one pixel only if the width is 1
                    // Y: subtract half of the lineYposition to set to it's center position.
                    .offset(x: lineXPosition/2 - Utils.halfSpacing,
                            y: getYOffsetPosition(for: alignments.0, last: alignments.1, and: lineYPosition))
                    .padding()
                    .eraseToAnyView()
        case .rounded(_, _, _, _):
            return EmptyView().eraseToAnyView()
        }
    }
    
    /// returns Y offset position based on first and last alignments.
    /// - Parameters:
    ///   - first: alignment of the first step indicator
    ///   - last: alignment of the last step indicator
    ///   - offset: offset value between position of first and last
    private func getYOffsetPosition(for first: StepperAlignment, last: StepperAlignment, and offset: CGFloat ) -> CGFloat {
        switch (first, last) {
        //top variations
        case (.top, .top): return -VerticalAlignment.centerValue
        case (.top, .center) : return -(VerticalAlignment.centerValue / 2)
        case (.top, .bottom): return (lineYPosition  - 2 * lineYPosition / 2)
            
        //center variations
        case (.center, .top): return (lineYPosition - 3 * lineYPosition / 2)
        case (.center, .center): return (lineYPosition - 2 * lineYPosition / 2)
        case (.center, .bottom) : return (lineYPosition - lineYPosition / 2)
              
        //bottom variations
        case (.bottom, .top): return (lineYPosition -  2 * lineYPosition / 2)
        case (.bottom, .center): return (lineYPosition - 1.5 * lineYPosition / 2)
        case (.bottom, .bottom):return (lineYPosition - lineYPosition / 2)
        }
    }
}
