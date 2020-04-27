//
//  StepIndicatorVerticalView.swift
//  StepperView
//
//  Created by Venkatnarayansetty, Badarinath on 4/16/20.
//

import SwiftUI

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct StepIndicatorVerticalView<Cell>: View where Cell:View {
    //vertical mode elements
    @State private var lineHeight:CGFloat = 0
    @State private var lineXPosition:CGFloat = 0
    @State private var columnHeights: [Int: CGFloat] = [:]
    @State private var lineYPosition: CGFloat = 0
    
    @Environment(\.pitStopOptions) var pitStopsOptions
    
    //constructor parameters
    var cells:[Cell]
    var alignments:[StepperAlignment]
    var indicationType: [StepperIndicationType<AnyView>]
    var lineOptions:StepperLineOptions
    var verticalSpacing: CGFloat
    
    init(cells: [Cell], alignments: [StepperAlignment] = [], indicationType: [StepperIndicationType<AnyView>],
         lineOptions: StepperLineOptions = .defaults, verticalSpacing:CGFloat = 30.0) {
           self.cells = cells
           self.alignments = alignments
           self.indicationType = indicationType
           self.lineOptions = lineOptions
           self.verticalSpacing = verticalSpacing
    }
    
    var body: some View {
        HStack {
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
                            //for drawing pit stops.
                            .ifTrue(self.pitStopsOptions.count > 0, content: { view in
                                view.anchorPreference(key: BoundsPreferenceKey.self, value: .bounds) { $0 }
                                .overlayPreferenceValue(BoundsPreferenceKey.self, { (preferences) in
                                    GeometryReader { proxy in
                                        preferences.map { anchor in
                                            self.drawAnchors(proxy: proxy, value: anchor, pitStopIndex: index)
                                        }
                                    }
                                })
                            })
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
}

// MARK: - Helper methods to constrcut step indicator vertical view.
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
extension StepIndicatorVerticalView {
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
    
    // draws pitstops for each of the step indicators.
    func drawAnchors(proxy: GeometryProxy, value: Anchor<CGRect>, pitStopIndex: Int) -> some View {
        guard self.pitStopsOptions.indices.contains(pitStopIndex) else {
          return EmptyView().eraseToAnyView()
        }
        
        return PitStopView(proxy: proxy,
                           value: value,
                           lineXPosition: $lineXPosition,
                           pitStop: self.pitStopsOptions[pitStopIndex].view, lineOptions:self.pitStopsOptions[pitStopIndex].lineOptions)
            .eraseToAnyView()
    }
}

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct OptionalView<Value, Content>: View where Content: View {
    var content: (Value) -> Content
    var value: Value
    
    init?(_ value: Value?, @ViewBuilder content: @escaping (Value) -> Content) {
        guard let value = value else {
            return nil
        }
        self.value = value
        self.content = content
    }
    
    var body: some View {
        content(value)
    }
}
