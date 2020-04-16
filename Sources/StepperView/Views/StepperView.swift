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

public enum StepperMode:String, CaseIterable {
    case vertical
    case horizontal
}

// MARK: - Stepper View Implementation
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public struct StepperView<Cell>: View where Cell:View {
    //vertical mode elements
    @State private var lineHeight:CGFloat = 0
    @State private var lineXPosition:CGFloat = 0
    @State private var columnHeights: [Int: CGFloat] = [:]
    @State private var lineYPosition: CGFloat = 0
    
    //horizontal mode elements
    @State private var lineWidth:CGFloat = 0
    @State private var height:CGFloat = 0
    @State private var lineYOffsetPosition:CGFloat = 0
    
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
            return verticalStepperView().eraseToAnyView()
        case .horizontal:
            return horizontalStepperView().eraseToAnyView()
        }
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

// MARK: - Helper methods for StepperView
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
    
    // MARK: - Returns the Stepper View in vertical mode
    func verticalStepperView() -> some View {
        return HStack {
            //line view to host indicator to point
            VerticalLineView(lineHeight: $lineHeight,
                     lineXPosition: $lineXPosition,
                     lineYPosition: $lineYPosition,
                     options: self.lineOptions,
                     alignments: (self.firstAlignment, self.lastAlignment))
            VStack(spacing: verticalSpacing) {
                ForEach(self.cells.indices) { index in
                    HStack(alignment: self.getAlignment(type: self.alignments[index])) {
                        IndicatorView(type: self.indicationType[index], indexofIndicator: index)
                            .padding(.horizontal, Utils.standardSpacing)
                            .eraseToAnyView()
                        self.cells[index]
                            .heightPreference(column: index)
                    }.setAlignment(type: self.alignments[index])
                        .offset(x: -Utils.offsetConstant)
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
                .onPreferenceChange(VerticalHeightPreference.self) {
                    print("Height of Divider \($0)")
                    let finalHeight = $0.values.max() ?? 0.0
                    self.lineHeight = finalHeight - self.calculateHeightsForFirstAndLastAlignments()
                    print("Final Line Height \(self.lineHeight)")
            }
        }.padding()
    }
    
    // MARK: - draws a label for the given index based ont he bouhnds calclulated by the anchor preference.
    fileprivate func drawLabel(for index: Int, proxy: GeometryProxy, value: Anchor<CGRect>) -> some View {
        return self.cells[index]
            .frame(height: 50)
            .frame(width: proxy[value].width * 2.5,
                   height: proxy[value].height)
            .padding(.vertical, Utils.standardSpacing)
            .offset(x: proxy[value].minX - proxy[value].midX, y: proxy[value].maxY)
            .allowsTightening(true)
            .multilineTextAlignment(.center)
    }
    
    // MARK: - Returns the Stepper View in horizontal mode
    func horizontalStepperView() -> some View {
        return VStack {
            HorizontalLineView(dividerWidth: $lineWidth, lineYOffsetPosition: $lineYOffsetPosition, options: self.lineOptions)
            VStack {
                HStack(spacing: verticalSpacing) {
                    ForEach(self.cells.indices) { index in
                        IndicatorView(type: self.indicationType[index], indexofIndicator: index)
                            //for calclulating the height of the indictor view to offset the divider.
                            .heightPreference(column: index)
                            // to get bounds of the indicator view to find the startung position to draw a label.
                            .anchorPreference(key: BoundsPreferenceKey.self, value: .bounds) { $0 }
                            .overlayPreferenceValue(BoundsPreferenceKey.self) { (preferences) in
                                GeometryReader { proxy in
                                    preferences.map { value in
                                        //draws label below the indicator.
                                        self.drawLabel(for: index, proxy: proxy, value: value)
                                    }
                                }
                        }.eraseToAnyView()
                    }
                }.widthKey()
            }.offset(y: -Utils.offsetConstant)
             .heightKey()
             // calclulate the width of the bar.
            .onPreferenceChange(WidthKey.self) { (value) in
                self.lineWidth = value ?? 0.0
            }
            // height of complete stepper Indicator
            .onPreferenceChange(HeightKey.self) {
                //print("Height of the divider \(String(describing: $0))")
                self.height = $0 ?? 0.0
            }.frame(height: self.height)
             // calclulate the offset position of the bar to move it to center.
            .onPreferenceChange(HeightPreference.self) {
                print("lineYOffsetPosition \(self.lineYOffsetPosition)")
                self.lineYOffsetPosition = ($0.values.first ?? 12) / 2
            }
        }
    }
}
