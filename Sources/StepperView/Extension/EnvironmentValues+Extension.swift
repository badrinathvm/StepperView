//
//  EnvironmentValues+Extension.swift
//  StepperView
//
//  Created by Venkatnarayansetty, Badarinath on 4/17/20.
//

import Foundation
import SwiftUI

// MARK: - Environment values configuration for standard size margins, can be used across the app.
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
extension EnvironmentValues {
    var steps: [AnyView] {
        get { self[StepsKey.self] }
        set { self[StepsKey.self] = newValue }
    }
    
    var alignments: [StepperAlignment] {
        get { self[AlignmentKey.self] }
        set { self[AlignmentKey.self] = newValue }
    }
    
    var indicationType: [StepperIndicationType<AnyView>] {
        get { self[IndicatorKey.self] }
        set { self[IndicatorKey.self] = newValue }
    }
    
    var stepperMode: StepperMode {
        get { self[StepIndicatorModeKey.self] }
        set { self[StepIndicatorModeKey.self] = newValue }
    }
    
    var spacing: CGFloat {
        get { self[SpacingKey.self] }
        set { self[SpacingKey.self] = newValue }
    }
    
    var lineOptions: StepperLineOptions {
        get { self[LineOptionsKey.self] }
        set { self[LineOptionsKey.self] = newValue }
    }
        
    var pitStopOptions: [PitStopSteps] {
        get { self[PitStopOptionsKey.self] }
        set { self[PitStopOptionsKey.self] = newValue }
    }
}

// MARK: - Environment Key for Steps
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct StepsKey: EnvironmentKey {
    static var defaultValue = [AnyView]()
}

// MARK: - Environment Key for alignments
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct AlignmentKey: EnvironmentKey {
    static var defaultValue = [StepperAlignment]()
}

// MARK: - Environment Key for Indicators
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct IndicatorKey: EnvironmentKey {
    static var defaultValue = [StepperIndicationType<AnyView>]()
}

// MARK: - Environment Key for StepIndicatorMode
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct StepIndicatorModeKey: EnvironmentKey {
    static var defaultValue = StepperMode.vertical
}

// MARK: - Environment Key for Spacing
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct SpacingKey: EnvironmentKey {
    static var defaultValue:CGFloat = 30.0
}

// MARK: - Environment Key for Line Options
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct LineOptionsKey: EnvironmentKey {
    static var defaultValue:StepperLineOptions = StepperLineOptions.defaults
}

// MARK: - Environment Key for pit stop line options.
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct PitStopOptionsKey: EnvironmentKey {
    static var defaultValue:[PitStopSteps] = []
}
