//
//  PreferenceKey+Extension.swift
//  StepperView
//
//  Created by Venkatnarayansetty, Badarinath on 4/10/20.
//

import Foundation
import SwiftUI

//MARK:- Collects height of all the cells, with reduce takes the maximum value for the given key
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct HeightPreference: PreferenceKey {
    typealias Value = [Int:CGFloat]
    static let defaultValue: Value = [:]
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value.merge(nextValue(), uniquingKeysWith: max)
    }
}

//MARK:- Collects height of all the cells, with reduce takes the maximum value for the given key
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct VerticalHeightPreference: PreferenceKey {
    typealias Value = [Int:CGFloat]
    static let defaultValue: Value = [:]
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value.merge(nextValue(), uniquingKeysWith: max)
    }
}

//MARK:- Collects width of all the cells, with reduce takes the maximum value for the given key
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct WidthPreference: PreferenceKey {
    typealias Value = [Int:CGFloat]
    static let defaultValue: Value = [:]
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value.merge(nextValue(), uniquingKeysWith: max)
    }
}

//MARK:- Collects bound, center coordinates and pass layout data to it's parent View
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public struct BoundsPreferenceKey: PreferenceKey {
    public typealias Value = Anchor<CGRect>?
    
    public static var defaultValue: Value = nil
    
    public static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
}

//MARK:- CGRect Preference Key
struct CGRectPreferenceKey: PreferenceKey {
    typealias Value = CGRectData?
    
    static var defaultValue: Value?
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        if let newValue = nextValue() {
            value?.rect = newValue.rect
        }
    }
}

//MARK:- placeholder struct to hold CGRect data.
struct CGRectData: Equatable,Identifiable {
    let id = UUID()
    var rect: CGRect
    
    static func == (lhs: CGRectData , rhs: CGRectData) -> Bool {
        lhs.id == rhs.id
    }
}
