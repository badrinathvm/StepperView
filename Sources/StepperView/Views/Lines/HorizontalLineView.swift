//
//  HorizontlLineView.swift
//  StepperView
//
//  Created by Venkatnarayansetty, Badarinath on 4/15/20.
//

import SwiftUI

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct HorizontalLineView: View {
    @Binding var dividerWidth: CGFloat
    @Binding var lineYOffsetPosition:CGFloat
    var options:StepperLineOptions
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
        }
    }
}
