//
//  View+Extensions.swift
//  StepperView
//
//  Created by Venkatnarayansetty, Badarinath on 4/6/20.
//

import SwiftUI

//MARK:- Helper function of View to operate on.
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public extension View {
    // Stores the height for each of column which will be passed as part of onPreference change to the view.
    func heightPreference(column: Int) -> some View {
        background(GeometryReader { proxy in
            Color.clear.preference(key: HeightPreference.self, value: [column: proxy.size.height])
        })
    }
    
    /// returns the alignment guide based on the alignemnt type.
    /// - Parameter type: sets the aligment guide.
    func setAlignment(type: StepperAlignment)-> some View  {
        switch type {
        case .top:
            return self.alignmentGuide(.customTop) { d in d[VerticalAlignment.top] }
        case .center:
            return self.alignmentGuide(.customCenter) { d in d[VerticalAlignment.center] }
        case .bottom:
            return self.alignmentGuide(.customBottom) { d in d[VerticalAlignment.bottom] }
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
    
    /// Embeds the view in navigationView
    func embedINNavigationView() -> some View {
        NavigationView { self }
    }
    
    
    /// wrapper to  AnyView 
    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
}

//MARK:- Collects width of all the cells, with reduce takes the maximum value for the given key
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct HeightPreference: PreferenceKey {
    typealias Value = [Int:CGFloat]
    static let defaultValue: Value = [:]
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value.merge(nextValue(), uniquingKeysWith: max)
    }
}

//MARK:- Collects bound, center coordinates and pass layout data to it's parent View
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public struct BoundsPreferenceKey: PreferenceKey {
    
 //   public typealias Value = Anchor<CGRect>?
//
//    public static var defaultValue: Value = nil
//
//    public static func reduce(value: inout Value, nextValue: () -> Value) {
//        value = nextValue()
//        print("Bounds \(String(describing: value))")
//    }
    
    public typealias Value = TopBottomBoundsPreferenceKey?
    
    public static var defaultValue: Value = nil
    
    public static func reduce(value: inout TopBottomBoundsPreferenceKey?, nextValue: () -> TopBottomBoundsPreferenceKey?) {
        value = nextValue()
        print("Bounds \(String(describing: value))")
    }
    
}


@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public struct TopBottomBoundsPreferenceKey {
    var topLeading: Anchor<CGPoint>? = nil
    var bottomTrailing: Anchor<CGPoint>? = nil
}
