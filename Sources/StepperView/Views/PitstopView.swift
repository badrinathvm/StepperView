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
}

// MARK: - PitStop View
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct PitStopView: View {
    @State private var width:CGFloat = 0.0
    
    var proxy:GeometryProxy
    var value:Anchor<CGRect>
    @Binding var lineXPosition:CGFloat
    
    @Environment(\.pitStopLineOptions) var lineOptions
        
    var body: some View {
        VStack(spacing:0) {
            PitStopLineView(options: lineOptions, proxy: proxy, value: value, width: self.$width)
            Circle()
                .frame(width: self.lineXPosition/3, height: self.lineXPosition/3)
                .foregroundColor(Color.red)
                .offset(x: proxy[value].midX - self.width / 2, y: proxy[value].maxY)
        }.widthKey()
            .onPreferenceChange(WidthKey.self, perform: { (value) in
                self.width = value ?? 12
                print("Pitstop width is \(self.width)")
            })
            // to draw text next to pitstop.
            .anchorPreference(key: BoundsPreferenceKey.self, value: .bounds) { $0 }
            .overlayPreferenceValue(BoundsPreferenceKey.self) { (preferences) in
                GeometryReader { reader in
                    preferences.map { value in
                        Text("Welcome to pitstop midY \(reader[value].midY) maxY: \(reader[value].maxY)")
                            .frame(width: self.proxy.size.width * 5, height: reader.size.height, alignment: .leading)
                            //.fixedSize(horizontal: true, vertical: false)
                            .offset(x: self.lineXPosition + 30, y:  reader[value].maxY + 10)
                            .font(.caption)
                            .lineLimit(nil)
                    }
                }
        }
    }
}

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
