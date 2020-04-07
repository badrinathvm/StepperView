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
    case circle
    case image(Image)
    case custom(Content)
}

//MARK:- Stepper View Implementation
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public struct StepperView<Cell>: View where Cell:View {
    @State private var dividerHeight:CGFloat = 0
    @State private var columnHeights: [Int: CGFloat] = [:]
    public var cells:[Cell]
    public var alignments:[StepperAlignment]
    public var indicationType: [StepperIndicationType<AnyView>]
    public var verticalSpacing: CGFloat = 30.0
    
    public init(cells: [Cell], alignments: [StepperAlignment],indicationType: [StepperIndicationType<AnyView>],verticalSpacing:CGFloat) {
        self.cells = cells
        self.alignments = alignments
        self.indicationType = indicationType
        self.verticalSpacing = verticalSpacing
    }
    
    public var body: some View {
        HStack {
            //line view to host circle to point
            LineView(dividerHeight: $dividerHeight)
            VStack(spacing: verticalSpacing) {
                ForEach(self.cells.indices) { index in
                    HStack(alignment: self.getAlignment(type: self.alignments[index])) {
                        IndicatorView(type: self.indicationType[index])
                            .padding(.horizontal, 10.0)
                            .setAlignment(type: self.alignments[index])
                            .eraseToAnyView()
                        self.cells[index]
                            .heightPreference(column: index)
                    }.offset(x: -40)
                }
            }.onPreferenceChange(HeightPreference.self) {
                self.columnHeights = $0
                print(self.columnHeights)
                //get heights of each of the cell + paddings
                let paddings = CGFloat((self.verticalSpacing - 5) * CGFloat(self.cells.count))
                self.dividerHeight = Array(self.columnHeights.values).reduce(0, +) + paddings
                print("Divider Height \(self.dividerHeight)")
            }
        }.padding()
    }
}



