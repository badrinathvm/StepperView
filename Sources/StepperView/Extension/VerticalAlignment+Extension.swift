//
//  VerticalAlignment+Extension.swift
//  StepperView
//
//  Created by Venkatnarayansetty, Badarinath on 4/6/20.
//

import SwiftUI

// MARK: - Custom alignments
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
extension VerticalAlignment {
    private enum CustomTopAlignment: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            topValue = context[.top]
            return context[.top]
        }
    }
    
    private enum CustomBottomAlignment: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            bottomValue = context[.bottom]
            return context[.bottom]
        }
    }
    
    private enum CustomCenterAlignment: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            centerValue = context[VerticalAlignment.center]
            return context[VerticalAlignment.center]
        }
    }
    
    static let customTop = VerticalAlignment(CustomTopAlignment.self)
    
    static let customBottom = VerticalAlignment(CustomBottomAlignment.self)
    
    static let customCenter = VerticalAlignment(CustomCenterAlignment.self)
    
    static var topValue: CGFloat = 0.0
    
    static var centerValue: CGFloat = 0.0
    
    static var bottomValue: CGFloat = 0.0
}
