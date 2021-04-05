//
//  SwiftUIView.swift
//  StepperView
//
//  Created by Venkatnarayansetty, Badarinath on 4/26/20.
//

import SwiftUI

/// A View for setting up a pitstop for eg: line with a `circle`  or  `custom` view
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct PitStopView<PitStop:View>: View {
    /// state variable to hold width to render  `View`  when values changes
    @State private var width:CGFloat = 0.0
    /// co-ordinates to draw the pitsop view.
    var proxy:GeometryProxy
    /// bounds value of the rendered step indicator
    var value:Anchor<CGRect>
    /// x-axis position of the line
    @Binding var lineXPosition:CGFloat
    /// A pitsop view to render
    var pitStop:PitStop
    /// to customise the `width ` , `Color` of the line
    var lineOptions:StepperLineOptions = StepperLineOptions.custom(1, Color.gray)
    /// Index position to calculate the height of the pitstop view
    var heightIndex:Int
    
    /// environment variable to access pitstop options
    @Environment(\.autoSpacing) var autoSpacing
      
    /// Provides the content and behavior of this view.
    var body: some View {
        VStack(spacing:0) {
            PitStopLineView(options: lineOptions, proxy: proxy, value: value, width: self.$width)
            Circle()
                .frame(width: self.lineXPosition/3, height: self.lineXPosition/3)
                .foregroundColor(self.getColor(from: lineOptions))
                .offset(x: proxy[value].midX - self.width / 2 - Utils.minimumSpacing, y: proxy[value].maxY)
        }.widthKey()
            .onPreferenceChange(WidthKey.self, perform: { (value) in
                self.width = value ?? 12
            })
            // to draw text next to pitstop.
            .anchorPreference(key: BoundsPreferenceKey.self, value: .bounds) { $0 }
            .overlayPreferenceValue(BoundsPreferenceKey.self) { (preferences) in
                GeometryReader { reader in
                    preferences.map { value in
                            self.pitStop
                                .frame(width: self.proxy.size.width * Utils.halfSpacing, alignment: .leading)
                                .offset(x: self.lineXPosition + 30, y:  reader[value].maxY + Utils.halfSpacing)
                                .font(.caption)
                                .lineLimit(nil)
                                .padding(.bottom, self.autoSpacing ? 5 * Utils.standardSpacing : 0.0)
                                .pitstopHeightPreference(column: self.heightIndex)
                    }
                }
        }
    }
    
    /// Returns the `Color` from the line options provided.
    /// - Parameter lineOptions: contains options to customize `width`  and `Color` of the line
    func getColor(from lineOptions: StepperLineOptions) -> Color {
        if case .custom(_, let color) = lineOptions {
            return color
        }
        return Color.gray.opacity(0.2)
    }
}
