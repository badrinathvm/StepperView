//
//  EnvironmentValues+Extension.swift
//  StepperView
//
//  Created by Venkatnarayansetty, Badarinath on 4/17/20.
//

import Foundation
import SwiftUI

/// Environment values configuration for standard size margins, can be used across the app
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
extension EnvironmentValues {
    /// property wrapper  for `StepsKey`
    var steps: [AnyView] {
        get { self[StepsKey.self] }
        set { self[StepsKey.self] = newValue }
    }
    
    /// property wrapper  for `AlignmentKey`
    var alignments: [StepperAlignment] {
        get { self[AlignmentKey.self] }
        set { self[AlignmentKey.self] = newValue }
    }
    
    /// property wrapper  for `StepperIndicationType`
    var indicationType: [StepperIndicationType<AnyView>] {
        get { self[IndicatorKey.self] }
        set { self[IndicatorKey.self] = newValue }
    }
    
    /// property wrapper  for `StepIndicatorModeKey`
    var stepperMode: StepperMode {
        get { self[StepIndicatorModeKey.self] }
        set { self[StepIndicatorModeKey.self] = newValue }
    }
    
    /// property wrapper  for `SpacingKey`
    var spacing: CGFloat {
        get { self[SpacingKey.self] }
        set { self[SpacingKey.self] = newValue }
    }
    
    /// property wrapper  for `AutoSpacingKey`
    var autoSpacing: Bool {
        get { self[AutoSpacingKey.self] }
        set { self[AutoSpacingKey.self] = newValue }
    }
    
    /// property wrapper  for `LineOptionsKey`
    var lineOptions: StepperLineOptions {
        get { self[LineOptionsKey.self] }
        set { self[LineOptionsKey.self] = newValue }
    }
      
    /// property wrapper  for `PitStopOptionsKey`
    var pitStopOptions: [AnyView] {
        get { self[PitStopOptionsKey.self] }
        set { self[PitStopOptionsKey.self] = newValue }
    }
    
    /// property wrapper  for `PitStopLineOptionsKey`
    var pitStopLineOptions: [StepperLineOptions] {
        get { self[PitStopLineOptionsKey.self] }
        set { self[PitStopLineOptionsKey.self] = newValue }
    }
    
    /// property wrapper  for `StepAnimationOptionsKey`
    var stepAnimations: Int {
        get { self[StepAnimationOptionsKey.self] }
        set { self[StepAnimationOptionsKey.self] = newValue }
    }
    
    /// property wrapper  for `LoadAnimationOptionsKey`
    var loadAnimationTime: Double {
        get { self[LoadAnimationOptionsKey.self] }
        set { self[LoadAnimationOptionsKey.self] = newValue }
    }
    
    /// property wrapper  for `StepLifeCycleKey`
    var stepLifeCycle: [StepLifeCycle] {
        get { self[StepLifeCycleKey.self] }
        set { self[StepLifeCycleKey.self] = newValue }
    }
    
    /// property wrapper  for `StepperEdgeInsetsKey`
    var stepperEdgeInsets: EdgeInsets {
        get { self[StepperEdgeInsetsKey.self] }
        set { self[StepperEdgeInsetsKey.self] = newValue }
    }
}

/// Environment Key for Steps
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct StepsKey: EnvironmentKey {
    /// provide a default value for custom dependency
    static var defaultValue = [AnyView]()
}

/// Environment Key for alignments
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct AlignmentKey: EnvironmentKey {
    /// provide a default value for custom dependency
    static var defaultValue = [StepperAlignment]()
}

/// Environment Key for Indicators
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct IndicatorKey: EnvironmentKey {
    /// provide a default value for custom dependency
    static var defaultValue = [StepperIndicationType<AnyView>]()
}

/// Environment Key for StepIndicatorMode
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct StepIndicatorModeKey: EnvironmentKey {
    /// provide a default value for custom dependency
    static var defaultValue = StepperMode.vertical
}

/// Environment Key for Spacing
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct SpacingKey: EnvironmentKey {
    /// provide a default value for custom dependency
    static var defaultValue:CGFloat = 30.0
}

/// Environment Key for Auto Spacing
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct AutoSpacingKey: EnvironmentKey {
    /// provide a default value for custom dependency
    static var defaultValue:Bool = false
}

/// Environment Key for Line Options
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct LineOptionsKey: EnvironmentKey {
    /// provide a default value for custom dependency
    static var defaultValue:StepperLineOptions = StepperLineOptions.defaults
}

/// Environment Key for pit stop line options.
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct PitStopOptionsKey: EnvironmentKey {
    /// provide a default value for custom dependency
    static var defaultValue = [AnyView]()
}

/// Environment Key for Line Options
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct PitStopLineOptionsKey: EnvironmentKey {
    /// provide a default value for custom dependency
    static var defaultValue:[StepperLineOptions] = []
}

/// Environment Key for pit stop line options.
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct StepAnimationOptionsKey: EnvironmentKey {
    /// provide a default value for custom dependency
    static var defaultValue:Int = 0
}

/// Environment Key for pit stop line options.
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct LoadAnimationOptionsKey: EnvironmentKey {
    /// provide a default value for custom dependency
    static var defaultValue:Double = 0.05
}

/// Environment Key for pit stop line options.
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct StepLifeCycleKey: EnvironmentKey {
    /// provide a default value for custom dependency
    static var defaultValue:[StepLifeCycle] = []
}

/// Environment Key for pit stop line options.
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct StepperEdgeInsetsKey: EnvironmentKey {
    /// provide a default value for custom dependency
    static var defaultValue: EdgeInsets = EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
}
