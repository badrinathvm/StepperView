//
//  IndicatorView.swift
//  StepperView
//
//  Created by Venkatnarayansetty, Badarinath on 4/6/20.
//

import SwiftUI

// MARK: - Indicator View for Stepper Indicator
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct IndicatorView: View {
    @State private var width:CGFloat = 0.0
    @State private var horizontalWidth:CGFloat = 0.0
    
    var type: StepperIndicationType<AnyView>
    var indexofIndicator:Int
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
    
    func getViewForOverlay(of type: StepperIndicationType<AnyView>, for index: Int) -> some View {
        switch type {
        case .circle(let color, let width):
            return
             Circle()
                .frame(width: width, height: width)
                .foregroundColor(color)
                .eraseToAnyView()
        case .image(let image, let width):
            return image
                .resizable()
                .frame(width: width, height: width)
                .eraseToAnyView()
        case .custom(let view):
            return view
                .widthPreference(column: index)
                .eraseToAnyView()
        }
    }
}
