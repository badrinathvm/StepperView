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
    var body: some View {
        Divider()
            .background(Color.gray)
            .frame(width: dividerWidth)
            .padding()
            .eraseToAnyView()
    }
}
