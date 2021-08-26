//
//  StepIndicatorVerticalView.swift
//  StepperView
//
//  Created by Venkatnarayansetty, Badarinath on 4/16/20.
//

import SwiftUI

/// A Step Indications View in `vertical`  direction
///
/// creates step indicator view either in `vertical` mode
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct StepIndicatorVerticalView<Cell>: View where Cell:View {
    //vertical mode elements
    /// state variable to hold  height of line to render  `View`  when values changes
    @State private var lineHeight:CGFloat = 0
    /// state variable to hold x-axis position of line to render  `View`  when values changes
    @State private var lineXPosition:CGFloat = 0
    /// state variable to hold each step heights to render  `View`  when values changes
    @State private var columnHeights: [Int: CGFloat] = [:]
    /// state variable to hold y-axis position  to render  `View`  when values changes
    @State private var lineYPosition: CGFloat = 0
    /// state variable for dyanmic spacing
    @State private var dynamicSpace:CGFloat = Utils.standardSpacing
    
    /// environment variable to access pitstop options
    @Environment(\.pitStopOptions) var pitStopsOptions
    
    /// environment variable to access pitstop options
    @Environment(\.pitStopLineOptions) var pitStopLineOptions
    
    /// environment variable to access autospacing
    @Environment(\.autoSpacing) var autoSpacing
    
    /// environment variable for edge Insets
    @Environment(\.stepperEdgeInsets) var stepperEdgeInsets
    
    /// environment variable to access steplife cycles
    @Environment(\.stepLifeCycle) var stepLifeCycle
    
    /// list  of `View's` to display step indictor content
    var cells:[Cell]
    /// list of alignments to display the step indicator position  can be `top` or  `center` or  `bottom`
    var alignments:[StepperAlignment]
    /// step indicator type can be a `Circle` , `Image` or `Custom`
    var indicationType: [StepperIndicationType<AnyView>]
    /// options to customize  `width ` , `Color` of the line
    var lineOptions:StepperLineOptions
    /// spacing between each of the step indicators
    var verticalSpacing: CGFloat
    /// to detect the whether the line option is of type `rounded`
    var isRounded:Bool = false
    
    /// initilazes cells, alignments , indicators and spacing
    init(cells: [Cell], alignments: [StepperAlignment] = [], indicationType: [StepperIndicationType<AnyView>],
         lineOptions: StepperLineOptions = .defaults, verticalSpacing:CGFloat = 30.0) {
           self.cells = cells
           self.alignments = alignments
           self.indicationType = indicationType
           self.verticalSpacing = verticalSpacing
           self.lineOptions = lineOptions
            switch lineOptions {
            case .rounded(_, _, _, _):
                     self.isRounded = true
            default: self.isRounded = false
            }
    }
    
    /// Provides the content and behavior of this view.
    var body: some View {
        HStack {
            //line view to host indicator to point
            VerticalLineView(lineHeight: $lineHeight,
                     lineXPosition: $lineXPosition,
                     lineYPosition: $lineYPosition,
                     options: self.lineOptions,
                     alignments: (self.firstAlignment, self.lastAlignment))
            VStack(alignment: .leading, spacing: autoSpacing ? self.dynamicSpace : self.verticalSpacing) {
                ForEach(0..<self.cells.count, id:\.self) { index in
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
                            .ifTrue(self.isRounded, content: { view in
                                view.anchorPreference(key: BoundsPreferenceKey.self, value: .bounds) { $0 }
                                .overlayPreferenceValue(BoundsPreferenceKey.self, { (preferences) in
                                    GeometryReader { proxy in
                                        preferences.map { value in
                                            self.drawCustomLine(proxy: proxy, value: value, index: index)
                                        }
                                    }
                                })
                            })
                            .eraseToAnyView()
                        self.cells[index]
                            .heightPreference(column: index)
                    }.setAlignment(type: self.alignments[index])
                     .offset(x: self.getOffset())
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
                    //print("Height of Divider \($0)")
                    let finalHeight = $0.values.max() ?? 0.0
                    self.lineHeight = finalHeight - self.calculateHeightsForFirstAndLastAlignments()
                    //print("Final Line Height \(self.lineHeight)")
            }
                // auto spacing
            .onPreferenceChange(PitstopHeightPreference.self) {
                //print("Pistop height value \($0)")
                self.dynamicSpace = Array($0.values).max() ?? 0.0
                //print("Auto Spacing:: \(self.dynamicSpace)")
            }
        }.padding(stepperEdgeInsets)
    }
}

// MARK: - Helper methods to construct step indicator vertical view.
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
extension StepIndicatorVerticalView {

    /// Calculate intermediate heights of the view.
    /// - Parameter value: dictionary to hold the index and height values.
    private func calculateIntermediateHeights( value: [Int:CGFloat] ) {
        self.columnHeights = value
        //print("Intermediate Divider Height \(self.columnHeights)")
        self.dynamicSpace = self.columnHeights.first?.value ?? 0.0
        //print("Auto Spacing:: \(self.dynamicSpace)")
    }
    
    /// returns the first alignment from array else `.center`  by default
    private var firstAlignment: StepperAlignment {
        return self.alignments.first ?? .center
    }
    
    /// returns the last alignment from array else  `center`  by default
    private var lastAlignment: StepperAlignment {
        return self.alignments.last ?? .center
    }
    
    /// Calculates the height based on first and last alignments.
    private func calculateHeightsForFirstAndLastAlignments() -> CGFloat {
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
            case (.top, .top): return self.getYPosition(for: .center)
        
            //Reduce 2 times as it's measured from it's first alignment (.bottom is in this case)
            case(.bottom, .top): return 2 * self.getYPosition(for: firstAlignment)
            //Reduce 3 times to get actual height
            case (.bottom, .center): return 3 * self.getYPosition(for: .center)
            case (.bottom, .bottom): return self.getYPosition(for: firstAlignment)
           }
        } else {
            return self.getYPosition(for: self.firstAlignment)
       }
    }
    
    /// draws pitstops for each of the step indicators.
    /// - Parameters:
    ///   - proxy: co-ordinates values of step indicator
    ///   - value: bound values of step indicator
    ///   - pitStopIndex: Index position of step indicator
    private func drawAnchors(proxy: GeometryProxy, value: Anchor<CGRect>, pitStopIndex: Int) -> some View {
        guard self.pitStopsOptions.indices.contains(pitStopIndex) else {
          return EmptyView().eraseToAnyView()
        }

        guard self.pitStopLineOptions.count > 0 else {
            return PitStopView(proxy: proxy,
                               value: value,
                               lineXPosition: $lineXPosition,
                               pitStop: self.pitStopsOptions[pitStopIndex],
                               heightIndex: pitStopIndex)
                .eraseToAnyView()
        }
        
        return PitStopView(proxy: proxy,
                           value: value,
                           lineXPosition: $lineXPosition,
                           pitStop: self.pitStopsOptions[pitStopIndex], lineOptions: self.pitStopLineOptions[pitStopIndex],
                           heightIndex: pitStopIndex)
             .eraseToAnyView()
    }
    
    /// draaws custom line between the indicators
    /// - Parameters:
    ///   - proxy: co-ordinates values of step indicator
    ///   - value: bound values of step indicator
    ///   - index: index position of step indicator
    /// - Returns: reurns a `view` of type of  Line
    private func drawCustomLine(proxy: GeometryProxy, value: Anchor<CGRect>, index: Int) -> some View {
        guard index != self.cells.count - 1 else { return EmptyView().eraseToAnyView() }
        switch lineOptions {
        case .rounded(let width, let cornerRadius, let color, let pendingColor):
            // draw a line
            return RoundedRectangle(cornerRadius: cornerRadius)
                .foregroundColor(stepLifeCycle[index] == StepLifeCycle.completed ? color : pendingColor)
                .frame(width: width, height: self.verticalSpacing)
                .offset(x: proxy[value].midX - width/2, y: proxy[value].maxY)
                .eraseToAnyView()
        default:
            return EmptyView().eraseToAnyView()
        }
    }
    
    /// returns offset value to align the the line view
    private func getOffset() -> CGFloat {
       #if os(watchOS)
            return -Utils.watchoffsetConstant
        #else
            return -Utils.offsetConstant
        #endif
    }
}
