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
    @Binding var dividerHeight:CGFloat
    @Binding var shiftLine:CGFloat
    var options:StepperLineOptions
    var body:some View {
        switch options {
        case .defaults:
            return Divider()
                .background(Color.gray)
                .frame(height: dividerHeight)
                .offset(x: shiftLine/2 - Utils.halfSpacing)
                .padding()
                .eraseToAnyView()
        case .custom(let width, let color):
            return Rectangle()
                    .fill(color)
                    .frame(width: width, height: dividerHeight)
                .offset(x: shiftLine/2 - Utils.halfSpacing)
                    .padding()
                .eraseToAnyView()
        }
    }
}
