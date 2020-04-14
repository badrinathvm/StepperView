//
//  LineView.swift
//  StepperView
//
//  Created by Venkatnarayansetty, Badarinath on 4/6/20.
//

import SwiftUI

// MARK: - Line View for Stepper
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct LineView: View {
    @Binding var lineHeight:CGFloat
    @Binding var lineXPosition:CGFloat
    @Binding var lineYPosition:CGFloat
    var options:StepperLineOptions
    var alignments:(StepperAlignment, StepperAlignment)
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
                    .offset(x: width == 1 ? lineXPosition/2 - Utils.halfSpacing - 1
                                          : (lineXPosition/2 - Utils.halfSpacing),
                        y: getYOffsetPosition(for: alignments.0, last: alignments.1, and: lineYPosition))
                    .padding()
                    .eraseToAnyView()
        }
    }
    
    // returns Y offset position based on first and last alignments.
    func getYOffsetPosition(for first: StepperAlignment, last: StepperAlignment, and offset: CGFloat ) -> CGFloat {
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
