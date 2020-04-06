//
//  VerticalAlignment+Extension.swift
//  StepperView
//
//  Created by Venkatnarayansetty, Badarinath on 4/6/20.
//

import SwiftUI

//MARK:- Custom alignments
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
extension VerticalAlignment {
    private enum CustomTopAlignment: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            return context[.top]
        }
    }
    
    private enum CustomBottomAlignment: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            return context[.bottom]
        }
    }
    
    private enum CustomCenterAlignment: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            return context[VerticalAlignment.center]
        }
    }
    
    static let customTop = VerticalAlignment(CustomTopAlignment.self)
    
    static let customBottom = VerticalAlignment(CustomBottomAlignment.self)
    
    static let customCenter = VerticalAlignment(CustomCenterAlignment.self)
}
