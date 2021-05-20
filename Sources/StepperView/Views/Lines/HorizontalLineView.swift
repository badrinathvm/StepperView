//
//  HorizontlLineView.swift
//  StepperView
//
//  Created by Venkatnarayansetty, Badarinath on 4/15/20.
//

import SwiftUI

/// Horizontal Line View for Step Indictor
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct HorizontalLineView: View {
    /// binding variable to hold the divider width
    @Binding var dividerWidth: CGFloat
    /// binding variable to hold line y-axis position
    @Binding var lineYOffsetPosition:CGFloat
    /// options for customizing line with either  `defaults` or  custom `width`  and `Color`
    var options:StepperLineOptions
    
    /// provides the content and behavior of this view.
    var body: some View {
        switch options {
        case .defaults:
            return Divider()
                .background(Color.gray)
                .frame(width: dividerWidth)
                .padding()
                .eraseToAnyView()
        case .custom(let height, let color):
            return Rectangle()
            .fill(color)
            .frame(width: dividerWidth, height: height)
            .offset(y: -(lineYOffsetPosition + 1))
            .eraseToAnyView()
        case .rounded(_,_,_,_):
            return EmptyView().eraseToAnyView()
        }
    }
}
