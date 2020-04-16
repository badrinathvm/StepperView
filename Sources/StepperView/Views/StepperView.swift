//
//  StepperView.swift
//
//  Created by Venkatnarayansetty, Badarinath on 4/4/20.
//  Copyright © 2020 Badarinath Venkatnarayansetty. All rights reserved.
//

import SwiftUI

// MARK: - Stepper View alignments
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public enum StepperAlignment: String, CaseIterable {
    case top = "Top", center = "Center", bottom = "Bottom"
}

// MARK: - Stepper Indication options
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public enum StepperIndicationType<Content:View> {
    public typealias Width = CGFloat
    case circle(Color, Width)
    case image(Image, Width)
    case custom(Content)
}

// MARK: - Line Options for Customization
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public enum StepperLineOptions {
    case defaults
    case custom(CGFloat, Color)
}

// MARK: - Indicates the types of Setp Indicator mode
public enum StepperMode:String, CaseIterable {
    case vertical
    case horizontal
}

// MARK: - Stepper View Implementation
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public struct StepperView<Cell>: View where Cell:View {
    //constructor parameters
    public var cells:[Cell]
    public var alignments:[StepperAlignment]
    public var indicationType: [StepperIndicationType<AnyView>]
    public var lineOptions:StepperLineOptions
    public var verticalSpacing: CGFloat
    public var stepperMode:StepperMode
    
    public init(cells: [Cell], alignments: [StepperAlignment] = [],
                indicationType: [StepperIndicationType<AnyView>],
                lineOptions: StepperLineOptions = .defaults,
                verticalSpacing:CGFloat = 30.0, stepperMode: StepperMode = .vertical) {
        self.cells = cells
        self.alignments = alignments.isEmpty ? (0..<cells.count).map {_ in  StepperAlignment.center } : alignments
        self.indicationType = indicationType
        self.lineOptions = lineOptions
        self.verticalSpacing = verticalSpacing
        self.stepperMode = stepperMode
    }
    
    public var body: some View {
        switch stepperMode {
        case .vertical:
            return StepIndicatorVerticalView(cells: cells,
                                             alignments: alignments,
                                             indicationType: indicationType,
                                             lineOptions: lineOptions,
                                             verticalSpacing: verticalSpacing)
                .eraseToAnyView()
        case .horizontal:
            return StepIndicatorHorizontalView(cells: cells,
                                               alignments: alignments,
                                               indicationType: indicationType,
                                               lineOptions: lineOptions,
                                               verticalSpacing: verticalSpacing)
                .eraseToAnyView()
        }
    }
}
