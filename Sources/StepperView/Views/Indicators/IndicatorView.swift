//
//  IndicatorView.swift
//  StepperView
//
//  Created by Venkatnarayansetty, Badarinath on 4/6/20.
//

import SwiftUI

// MARK: - Indicator View for Stepper Indicator
/// A `View ` for Step Indicator
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct IndicatorView: View {
    /// state variable to hold  width to render  `View`  when values changes
    @State private var width:CGFloat = 0.0
    
    /// indicator type can be a `Circle` , `Image` or `Custom`
    var type: StepperIndicationType<AnyView>
    /// index position of the indicator
    var indexofIndicator:Int
    
    /// environment variable to access pitstop options
    @Environment(\.stepAnimations) var animations
    
    /// step indicator type can be a `Circle` , `Image` or `Custom`
    @Environment(\.indicationType) var indicationType
    
    /// loading time for animations
    @Environment(\.loadAnimationTime) var loadingTime
    
    /// provides the content and behavior of this view.
    var body: some View {
        ZStack {
            Circle()
                .frame(width: self.width, height: self.width)
                .foregroundColor(Color.white)
                .overlay(self.getViewForOverlay(of: self.type, for: self.indexofIndicator))
        }
        .onPreferenceChange( WidthPreference.self) {
            self.width = $0.values.first ?? 12
        }
    }
    
    /// provides the overlay `View`
    /// - Parameters:
    ///   - type:  can be a `Circle` , `Image` or `Custom`
    ///   - index: index position of the indicator
    func getViewForOverlay(of type: StepperIndicationType<AnyView>, for index: Int) -> some View {
        switch type {
        case .circle(let color, let width):
            return
             Circle()
                .frame(width: width, height: width)
                .widthPreference(column: index)
                .foregroundColor(color)
                .eraseToAnyView()
        case .image(let image, let width):
            return image
                .resizable()
                .frame(width: width, height: width)
                .widthPreference(column: index)
                .eraseToAnyView()
        case .custom(let view):
                return view
                .widthPreference(column: index)
                .eraseToAnyView()
        case .animation(let view):
                let delays = generateDelays()
                return NumberedCircleView(text: view.text, width: view.width, delay: delays[index], triggerAnimation: true)
                    .widthPreference(column: index)
                    .eraseToAnyView()
        }
    }
    
    /// generates delay intervals based on the loading timer.
    private func generateDelays() -> [Double] {
            var delays = [Double]()
            for data in indicationType.enumerated() {
                delays.append(loadingTime * Double(data.offset) * 100.0)
            }
            return delays
        }
}
