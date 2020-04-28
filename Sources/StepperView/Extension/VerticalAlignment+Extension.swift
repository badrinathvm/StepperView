//
//  VerticalAlignment+Extension.swift
//  StepperView
//
//  Created by Venkatnarayansetty, Badarinath on 4/6/20.
//

import SwiftUI

/// custom alignments for positioning
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
extension VerticalAlignment {
    /// custom top alignment
    private enum CustomTopAlignment: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            topValue = context[.top]
            return context[.top]
        }
    }
    
    /// custom bottom alignment
    private enum CustomBottomAlignment: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            bottomValue = context[.bottom]
            return context[.bottom]
        }
    }
    
    /// custom center alignment
    private enum CustomCenterAlignment: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            centerValue = context[VerticalAlignment.center]
            return context[VerticalAlignment.center]
        }
    }
    
    /// vertical alignment value for top
    static let customTop = VerticalAlignment(CustomTopAlignment.self)
    
    /// vertical alignment value for bottom
    static let customBottom = VerticalAlignment(CustomBottomAlignment.self)
    
    /// vertical alignment value for center
    static let customCenter = VerticalAlignment(CustomCenterAlignment.self)
    
    /// default value for top
    static var topValue: CGFloat = 0.0
    
    /// default value for center
    static var centerValue: CGFloat = 0.0
    
    /// default value for bottom
    static var bottomValue: CGFloat = 0.0
}
