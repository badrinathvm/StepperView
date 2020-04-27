//
//  PitStopSteps.swift
//  StepperView
//
//  Created by Venkatnarayansetty, Badarinath on 4/27/20.
//

import Foundation
import SwiftUI

// MARK: - Pitstop view and custom options
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public struct PitStopSteps: Hashable {
    public var view:AnyView
    public var lineOptions:PitStopLineOptions
    
    public init(view: AnyView, lineOptions: PitStopLineOptions = .custom(1, Colors.gray(.light).rawValue)) {
        self.view = view
        self.lineOptions = lineOptions
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(-1)
    }
    
    public static func == (lhs: PitStopSteps, rhs: PitStopSteps) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
