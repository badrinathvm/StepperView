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
    var body:some View {
        return Divider()
            .background(Color.gray)
            .frame(height: dividerHeight)
            .padding()
    }
}
