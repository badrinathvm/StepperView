//
//  View+Extensions.swift
//  StepperView
//
//  Created by Venkatnarayansetty, Badarinath on 4/6/20.
//

import SwiftUI

// MARK: - Helper function of View to operate on.
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public extension View {
    
    // Stores the height for each of column which will be passed as part of onPreference change parent view.
    func heightPreference(column: Int) -> some View {
        background(GeometryReader { proxy in
            Color.clear.preference(key: HeightPreference.self, value: [column: proxy.size.height])
        })
    }
    
    // Stores the width for each of column which will be passed as part of onPreference change to parent view.
    func widthPreference(column: Int) -> some View {
        background(GeometryReader { proxy in
            Color.clear.preference(key: WidthPreference.self, value: [column: proxy.size.width])
        })
    }
    
    // Stores the height for each of column which will be passed as part of onPreferenceChange to parent view.
    func verticalHeightPreference(column: Int? = 0) -> some View {
        background(GeometryReader { proxy in
            Color.clear.preference(key: VerticalHeightPreference.self, value: [column!: proxy.size.height])
        })
    }
    
    // Stores CGRect data for each cell which will be passed as part of onPreferenceChange to the parent view.
    func cgRectPreference() -> some View {
        background(GeometryReader { proxy in
            Color.clear.preference(key: CGRectPreferenceKey.self, value: CGRectData(rect: proxy.frame(in: .global)))
        })
    }
    
    /// returns the alignment guide based on the alignemnt type.
    /// - Parameter type: sets the aligment guide.
    func setAlignment(type: StepperAlignment)-> some View {
        switch type {
        case .top:
            return self.alignmentGuide(.customTop) { alignment in alignment[VerticalAlignment.top] }
        case .center:
            return self.alignmentGuide(.customCenter) { alignment in alignment[VerticalAlignment.center] }
        case .bottom:
            return self.alignmentGuide(.customBottom) { alignment in alignment[VerticalAlignment.bottom] }
        }
    }
    
    /// returmns the alginment based ont he Stepper Alignment
    /// - Parameter type: StepperAlignment enum
    func getAlignment(type: StepperAlignment) -> VerticalAlignment {
        switch type {
        case .top:
            return .customTop
        case .center:
            return .customCenter
        case .bottom:
            return .customBottom
        }
    }
    
    // Embeds the view in navigationView
    func embedINNavigationView() -> some View {
        NavigationView { self }
    }
    
    // Wrapper to  AnyView
    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
    
    // Returns either .top, .center. .bottom bound positions
    func getYPosition(for alignment: StepperAlignment) -> CGFloat {
        switch alignment {
        case .top:
            return VerticalAlignment.topValue
        case .center:
            return VerticalAlignment.centerValue
        case .bottom:
            return VerticalAlignment.bottomValue
        }
    }
}
