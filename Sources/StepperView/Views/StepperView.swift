//
//  StepperView.swift
//
//  Created by Venkatnarayansetty, Badarinath on 4/4/20.
//  Copyright © 2020 Badarinath Venkatnarayansetty. All rights reserved.
//

import SwiftUI

//MARK:- Stepper View alignments
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public enum StepperAlignment: String, CaseIterable {
    case top = "Top", center = "Center", bottom = "Bottom"
}

//MARK:- Stepper Indication options
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public enum StepperIndicationType<Content:View> {
    public typealias Width = CGFloat
    case circle(Color, Width)
    case image(Image, Width)
    case custom(Content)
}

//MARK:- Line Options for Customization
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public enum StepperLineOptions {
    case defaults
    case custom(CGFloat, Color)
}

//MARK:- Stepper View Implementation
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public struct StepperView<Cell>: View where Cell:View {
    @State private var lineHeight:CGFloat = 0
    @State private var lineXPosition:CGFloat = 0
    @State private var columnHeights: [Int: CGFloat] = [:]
    @State private var lineYPosition: CGFloat = 0
    public var cells:[Cell]
    public var alignments:[StepperAlignment]
    public var indicationType: [StepperIndicationType<AnyView>]
    public var lineOptions:StepperLineOptions
    public var verticalSpacing: CGFloat
    
    public init(cells: [Cell], alignments: [StepperAlignment] = [],indicationType: [StepperIndicationType<AnyView>],lineOptions: StepperLineOptions = .defaults,verticalSpacing:CGFloat = 30.0) {
        self.cells = cells
        self.alignments = alignments.isEmpty ? (0..<cells.count).map {_ in  StepperAlignment.center } : alignments
        self.indicationType = indicationType
        self.lineOptions = lineOptions
        self.verticalSpacing = verticalSpacing
    }
        
    public var body: some View {
        HStack {
            //line view to host indicator to point
            LineView(lineHeight: $lineHeight, lineXPosition: $lineXPosition, lineYPosition: $lineYPosition, options: self.lineOptions, alignments: (self.firstAlignment, self.lastAlignment))
            VStack(spacing: verticalSpacing) {
                ForEach(self.cells.indices) { index in
                    HStack(alignment: self.getAlignment(type: self.alignments[index])) {
                        IndicatorView(type: self.indicationType[index], indexofIndicator: index)
                                .padding(.horizontal, Utils.standardSpacing)
                                .eraseToAnyView()
                        self.cells[index]
                            .heightPreference(column: index)
                    }.setAlignment(type: self.alignments[index])
                    .offset(x: -40)
                }
            }.verticalHeightPreference()
            // Intermediate height of the Line View
            .onPreferenceChange(HeightPreference.self) {
                self.lineYPosition = self.getYPosition(for: self.firstAlignment)
                self.calculateIntermediateHeights(value: $0)
            }
             // Width of the Indicator View
            .onPreferenceChange(WidthPreference.self) {
                self.lineXPosition = $0.values.first ?? 12
            }
             // Height of the Line View
            .onPreferenceChange(VerticalHeightPreference.self){
                print("Height of Divider \($0)")
                let finalHeight = $0.values.max() ?? 0.0
                //print("Heights Based on First and Last alignments  \(self.calculateHeightsForFirstAndLastAlignments())")
                self.lineHeight = finalHeight - self.calculateHeightsForFirstAndLastAlignments()
                print("Final Line Height \(self.lineHeight)")
            }
        }.padding()
    }
    
    // Calculate intermediate heights of the view.
    /// - Parameter value: dictionary to hold the index and height values.
    private func calculateIntermediateHeights( value: [Int:CGFloat] ) {
        self.columnHeights = value
        print("Intermediate Divider Height \(self.columnHeights)")
    }
    
    // returns the first alignemnt from the array else .center by default
    private var firstAlignment: StepperAlignment {
        return self.alignments.first ?? .center
    }
    
    // returns the last alignemnt from the array else .center by default
    public var lastAlignment: StepperAlignment {
        return self.alignments.last ?? .center
    }
}

//MARK:- Helper methods for StepperView
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
extension StepperView {
    // Calculates the height based on first and last alignments.
    func calculateHeightsForFirstAndLastAlignments() -> CGFloat {
        if self.alignments.count > 1 {
            switch (firstAlignment, lastAlignment) {
                //Reduce 3 times to get actual height
            case (.center, .top): return 3 * self.getYPosition(for: .center)
                //Reduce 2 times to get actual height
            case (.center, .center): return 2 * self.getYPosition(for: .center)
                //Reduce 1 time to get actual height
            case (.center, .bottom): return self.getYPosition(for: .center)
                
                //Reduce 1 time to get actual height
                case (.top, .center): return self.getYPosition(for: .center)
                case (.top, .bottom): return self.getYPosition(for: firstAlignment)
                //Reduce 2 times to get actual height
                case (.top, .top): return 2 * self.getYPosition(for: .center)
                
                //Reduce 2 times as it's messured from it's first alignment (.bottom isn this case)
                case(.bottom, .top): return 2 * self.getYPosition(for: firstAlignment)
                //Reduce 3 times to get actual height
                case (.bottom, .center): return 3 * self.getYPosition(for: .center)
                case (.bottom, .bottom): return self.getYPosition(for: firstAlignment)
           }
        } else {
            return self.getYPosition(for: self.firstAlignment)
       }
    }
}
