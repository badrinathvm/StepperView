//
//  PitStopLineView.swift
//  StepperView
//
//  Created by Venkatnarayansetty, Badarinath on 4/26/20.
//

import SwiftUI

/// pitstop Line View for each of the step indicator
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct PitStopLineView: View {
    /// options for customizing pitstop line with either  `defaults` or  custom `width`  and `Color`
    var options:StepperLineOptions
    /// co-ordinates values of step indicator
    var proxy:GeometryProxy
    /// bound values of step indicator
    var value:Anchor<CGRect>
    
    /// binding variable to hold width of the `View`
    @Binding var width:CGFloat
    
    /// provides the content and behavior of this view.
    var body: some View {
        switch options {
        case .defaults:
            return Divider()
                .background(Color.gray)
                .frame(width: 1, height: proxy.size.height)
                .offset(x: proxy[value].midX - self.width / 2, y: proxy[value].maxY)
                .eraseToAnyView()
        case .custom(let width, let color):
            return Rectangle()
                .fill(color)
                .frame(width: width, height: proxy.size.height)
                .offset(x: proxy[value].midX - self.width / 2 - (width + 1), y: proxy[value].maxY)
                .eraseToAnyView()
        case .rounded(_, _, _, _):
            return EmptyView().eraseToAnyView()
        }
    }
}
