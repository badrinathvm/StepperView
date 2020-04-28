//
//  StepperView.swift
//
//  Created by Venkatnarayansetty, Badarinath on 4/4/20.
//  Copyright © 2020 Badarinath Venkatnarayansetty. All rights reserved.
//

import SwiftUI

/// A View for Step Indications.
///
/// You create step indicator view either  in `vertical` or `horizontal` mode
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public struct StepperView: View {
    /// contains list of steps to be rendered next to Indicators
    @Environment(\.steps) var steps
    /// alignments to place the step indicators
    @Environment(\.alignments) var alignments
    /// step indicator type can be a `Circle` , `Image` or `Custom`
    @Environment(\.indicationType) var indicationType
    /// to customise the `width ` , `Color` of the line
    @Environment(\.lineOptions) var lineOptions
    /// aligns the step indicator either in `vertical` or `horizontal`
    @Environment(\.stepperMode) var stepperMode
    /// spacing between each of the step indicators
    @Environment(\.spacing) var spacing
    
    public init() { }
    
    /// Provides the content and behavior of this view.
    public var body: some View {
        switch stepperMode {
        case .vertical:
            return StepIndicatorVerticalView(cells: steps,
                                             alignments: alignments.isEmpty ? (0..<steps.count).map {_ in  StepperAlignment.center } : alignments,
                                             indicationType: indicationType,
                                             lineOptions: lineOptions,
                                             verticalSpacing: spacing)
                .eraseToAnyView()
        case .horizontal:
            return StepIndicatorHorizontalView(cells: steps,
                                               alignments: alignments,
                                               indicationType: indicationType,
                                               lineOptions: lineOptions,
                                               horizontalSpacing: spacing)
                .eraseToAnyView()
        }
    }
}

// MARK: - Stepper View alignments
/**
    Options for stepper view alignments
 
    ````
    case top
    case center
    case bottoom
    ````
*/
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public enum StepperAlignment: String, CaseIterable {
    /// aligns step Indicator  to top
    case top = "Top"
    /// aligns step Indicator  to center
    case center = "Center"
    /// aligns step Indicator  to bottom
    case bottom = "Bottom"
}

// MARK: - Stepper Indication options
/**
    Options for displaying step indications can be either `Circle` or `Image`or `custom(View)`
 
    ````
    case circle(Color, Width)op
    case image(Image, Width)
    case custom(Content)
    ````
 */
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public enum StepperIndicationType<Content:View> {
    public typealias Width = CGFloat
    case circle(Color, Width)
    case image(Image, Width)
    case custom(Content)
}

// MARK: - Line Options for Step Customization
/**
   Options for customizing line with either  `defaults` or  custom `width`  and `Color`

   ````
   case defaults
   case custom(CGFloat, Color)
   ````
*/
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public enum StepperLineOptions {
    case defaults
    case custom(CGFloat, Color)
}

// MARK: - Indicates the types of Setp Indicator mode
/**
   Options for aligns the step indicator either in `vertical` or `horizontal`

   ````
   case vertical
   case horizontal
   ````
*/
public enum StepperMode:String, CaseIterable {
    case vertical
    case horizontal
}
