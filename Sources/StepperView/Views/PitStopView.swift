//
//  SwiftUIView.swift
//  StepperView
//
//  Created by Venkatnarayansetty, Badarinath on 4/26/20.
//

import SwiftUI

// MARK: - Line Options for Step Customization
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public enum PitStopLineOptions {
    case defaults
    case custom(CGFloat, Color)
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .defaults: hasher.combine(-1)
        default: hasher.combine(-2)
        }
    }
}

// MARK: - PitStop View
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct PitStopView<PitStop:View>: View {
    @State private var width:CGFloat = 0.0
    
    var proxy:GeometryProxy
    var value:Anchor<CGRect>
    @Binding var lineXPosition:CGFloat
    var pitStop:PitStop
    var lineOptions:PitStopLineOptions
        
    var body: some View {
        VStack(spacing:0) {
            PitStopLineView(options: lineOptions, proxy: proxy, value: value, width: self.$width)
            Circle()
                .frame(width: self.lineXPosition/3, height: self.lineXPosition/3)
                .foregroundColor(self.getColor(from: lineOptions))
                .offset(x: proxy[value].midX - self.width / 2, y: proxy[value].maxY)
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
                            .frame(width: self.proxy.size.width * Utils.halfSpacing, height: reader.size.height, alignment: .leading)
                            .offset(x: self.lineXPosition + 30, y:  reader[value].maxY + Utils.halfSpacing)
                            .font(.caption)
                            .lineLimit(nil)
                    }
                }
        }
    }
    
    func getColor(from lineOptions: PitStopLineOptions) -> Color {
        if case .custom(_, let color) = lineOptions {
            return color
        }
        return Color.gray.opacity(0.2)
    }
}
