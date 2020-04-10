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
    case circle(Color)
    case image(Image)
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
    @State private var dividerHeight:CGFloat = 0
    @State private var dividerPosition:CGFloat = 0
    @State private var columnHeights: [Int: CGFloat] = [:]
    //@State private var shiftLinePositio
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
    
    
    func calculateIntermediateHeights( value: [Int:CGFloat] ) {
        self.columnHeights = value
        let totalHeight = Array(self.columnHeights.values).reduce(0, +)
        print("Intermediate Divider Height \(self.columnHeights)")
    }
    
    public var body: some View {
        HStack {
            //line view to host indicator to point
            LineView(dividerHeight: $dividerHeight, shiftLine: $dividerPosition, options: self.lineOptions)
            VStack(spacing: verticalSpacing) {
                ForEach(self.cells.indices) { index in
                    HStack(alignment: self.getAlignment(type: self.alignments[index])) {
                        IndicatorView(type: self.indicationType[index], indexofIndicator: index)
                                .padding(.horizontal, Utils.standardSpacing)
                                .eraseToAnyView()
                        self.cells[index]
                            .heightPreference(column: index)
                    }.setAlignment(type: self.alignments[index])
                    .offset(x: CGFloat(-40))
                }
            }.verticalHeightPreference()
            // Intermediate height of the Line View
            .onPreferenceChange(HeightPreference.self) {
                self.calculateIntermediateHeights(value: $0)
            }
             // Width of the Indicator View
            .onPreferenceChange(WidthPreference.self) {
                self.dividerPosition = $0.values.first ?? 12
            }
             // Height of the Line View
            .onPreferenceChange(VerticalHeightPreference.self){
                print("Height of Divider \($0)")
                let finalHeight = $0.values.max() ?? 0.0
                self.dividerHeight = finalHeight
            }
        }.padding()
    }
}
