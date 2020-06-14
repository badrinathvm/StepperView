//
//  PreferenceKey+Extension.swift
//  StepperView
//
//  Created by Venkatnarayansetty, Badarinath on 4/10/20.
//

import Foundation
import SwiftUI

/// Collects height of all the cells, with reduce takes the maximum value for the given key
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct HeightPreference: PreferenceKey {
    typealias Value = [Int:CGFloat]
    /// provide a default value for custom dependency
    static let defaultValue: Value = [:]
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value.merge(nextValue(), uniquingKeysWith: max)
    }
}

/// Collects height of all the cells, with reduce takes the maximum value for the given key
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct VerticalHeightPreference: PreferenceKey {
    typealias Value = [Int:CGFloat]
    /// provide a default value for custom dependency
    static let defaultValue: Value = [:]
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value.merge(nextValue(), uniquingKeysWith: max)
    }
}

/// Collects height of all pistop cells, with reduce takes the maximum value for the given key
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct PitstopHeightPreference: PreferenceKey {
    typealias Value = [Int:CGFloat]
    /// provide a default value for custom dependency
    static let defaultValue: Value = [:]
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value.merge(nextValue(), uniquingKeysWith: max)
    }
}

/// Collects width of all the cells, with reduce takes the maximum value for the given key
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct WidthPreference: PreferenceKey {
    typealias Value = [Int:CGFloat]
    /// provide a default value for custom dependency
    static let defaultValue: Value = [:]
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value.merge(nextValue(), uniquingKeysWith: max)
    }
}

/// Collects bound, center coordinates and pass layout data to it's parent View
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public struct BoundsPreferenceKey: PreferenceKey {
    public typealias Value = Anchor<CGRect>?
    
    /// provide a default value for custom dependency
    public static var defaultValue: Value = nil
    
    public static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
}

/// Preference Key for  `CGRect`
struct CGRectPreferenceKey: PreferenceKey {
    typealias Value = CGRectData?
    
    /// provide a default value for custom dependency
    static var defaultValue: Value?
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        if let newValue = nextValue() {
            value?.rect = newValue.rect
        }
    }
}

/// placeholder struct to hold CGRect data.
struct CGRectData: Equatable, Identifiable {
    /// placeholder to store id
    let id = UUID()
    /// placeholder to CGRect data
    var rect: CGRect
    
    /// equatable override
    /// - Parameters:
    ///   - lhs: lhs variable for comparison
    ///   - rhs: lhs variable for comparison
    static func == (lhs: CGRectData, rhs: CGRectData) -> Bool {
        lhs.id == rhs.id
    }
}

/// Preference Key for  `width`
struct WidthKey: PreferenceKey {
    /// provide a default value for custom dependency
    static let defaultValue: CGFloat? = nil
    static func reduce(value: inout CGFloat?,
                       nextValue: () -> CGFloat?) {
        value = value ?? nextValue()
    }
}

/// Preference Key for  `height`
struct HeightKey: PreferenceKey {
    /// provide a default value for custom dependency
    static let defaultValue: CGFloat? = nil
    static func reduce(value: inout CGFloat?,
                       nextValue: () -> CGFloat?) {
        value = value ?? nextValue()
    }
}
