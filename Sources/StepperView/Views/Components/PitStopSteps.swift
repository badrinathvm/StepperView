//
//  PitStopSteps.swift
//  StepperView
//
//  Created by Venkatnarayansetty, Badarinath on 4/27/20.
//

import Foundation
import SwiftUI

/// Pitstop view and custom options
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public struct PitStopStep: Hashable {
    /// placeholder  for `View` to render
    public var view:AnyView
    /// options to customise pitstop line for `width` and `Color`
    public var lineOptions:PitStopLineOptions
    
    /// Initilazer to hold `View` and pit stop line Options
    /// - Parameters:
    ///   - view: `View` to render
    ///   - lineOptions: options to customise pitstop line for `width` and `Color`
    public init(view: AnyView, lineOptions: PitStopLineOptions = .custom(1, Colors.gray(.light).rawValue)) {
        self.view = view
        self.lineOptions = lineOptions
    }
    
    /// to generate hash
    /// - Parameter hasher: hasger variable
    public func hash(into hasher: inout Hasher) {
        hasher.combine(-1)
    }
    
    /// equatable override
    /// - Parameters:
    ///   - lhs: lhs variable for comparison
    ///   - rhs: lhs variable for comparison
    public static func == (lhs: PitStopStep, rhs: PitStopStep) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
