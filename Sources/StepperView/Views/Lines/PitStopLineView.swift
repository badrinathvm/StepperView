//
//  PitStopLineView.swift
//  StepperView
//
//  Created by Venkatnarayansetty, Badarinath on 4/26/20.
//

import SwiftUI

// MARK: - PitStop Line View
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct PitStopLineView: View {
    var options:PitStopLineOptions
    var proxy:GeometryProxy
    var value:Anchor<CGRect>
    
    @Binding var width:CGFloat
    
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
                .offset(x: proxy[value].midX - self.width / 2, y: proxy[value].maxY)
                .eraseToAnyView()
        }
    }
}
