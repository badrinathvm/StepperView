//
//  StepIndicatorHorizontalView.swift
//  StepperView
//
//  Created by Venkatnarayansetty, Badarinath on 4/16/20.
//

import SwiftUI

/// A Step Indications View in `horizontal`  direction
///
/// creates step indicator view either in `horizontal` mode
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct StepIndicatorHorizontalView<Cell:View>: View {
    /// state variable to hold width to render  `View`  when values changes
    @State private var lineWidth:CGFloat = 0
    /// state variable to hold line y-axis position to render  `View`  when values changes
    @State private var lineYOffsetPosition:CGFloat = 0
    /// state variable to hold height to render  `View`  when values changes
    @State private var height:CGFloat = 0
    /// state variable for dyanmic spacing
    @State private var dynamicSpace:CGFloat = Utils.standardSpacing * 10
    
    /// environment variable to autospacing
    @Environment(\.autoSpacing) var autoSpacing
    
    /// environment variable to access steplife cycles
    @Environment(\.stepLifeCycle) var stepLifeCycle
    
    //constructor parameters
    /// list  of `View's` to display step indictor content
    var cells:[Cell]
    /// list of alignments to display the step indicator position  can be `top` or  `center` or  `bottom`
    var alignments:[StepperAlignment]
    /// step indicator type can be a `Circle` , `Image` or `Custom`
    var indicationType: [StepperIndicationType<AnyView>]
    /// options to customize  `width ` , `Color` of the line
    var lineOptions: StepperLineOptions
    /// spacing between each of the step indicators
    var horizontalSpacing:CGFloat
    /// to detect the whether the line option is of type `rounded`
    var isRounded:Bool = false
    
    /// initilazes cells, alignments , indicators and spacing
    init(cells: [Cell], alignments: [StepperAlignment] = [], indicationType: [StepperIndicationType<AnyView>],
         lineOptions: StepperLineOptions = .defaults, horizontalSpacing:CGFloat = 50.0) {
           self.cells = cells
           self.alignments = alignments
           self.indicationType = indicationType
           self.lineOptions = lineOptions
           self.horizontalSpacing = horizontalSpacing
           self.lineOptions = lineOptions
             switch lineOptions {
             case .rounded(_, _, _, _):
                      self.isRounded = true
             default: self.isRounded = false
          }
    }
    
    /// Provides the content and behavior of this view.
    var body: some View {
        VStack {
            HorizontalLineView(dividerWidth: $lineWidth, lineYOffsetPosition: $lineYOffsetPosition, options: self.lineOptions)
            VStack {
                HStack(spacing: autoSpacing ? self.dynamicSpace : self.horizontalSpacing) {
                    ForEach(0..<self.cells.count, id:\.self) { index in
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
                //print("lineYOffsetPosition \(self.lineYOffsetPosition)")
                self.lineYOffsetPosition = ($0.values.first ?? 12) / 2
            }
        }
    }
    
    // MARK: - draws a label for the given index based ont he bouhnds calculated by the anchor preference.
    
    /// draws a label for the given index based ont he bouhnds calculated by the anchor preference.
    /// - Parameters:
    ///   - index: Index position of step indicator
    ///   - proxy: co-ordinates values of step indicator
    ///   - value: bound values of step indicator
    fileprivate func drawLabel(for index: Int, proxy: GeometryProxy, value: Anchor<CGRect>) -> some View {
         return self.cells[index]
             .frame(height: proxy[value].width * 2.5)
             .frame(width: proxy[value].width * 2.5, height: proxy[value].height, alignment: .center)
             .padding(.vertical, Utils.standardSpacing)
             .offset(x: proxy[value].minX - proxy[value].midX, y: proxy[value].maxY)
             .allowsTightening(true)
             .multilineTextAlignment(.center)
     }
    
    
    // MARK: - Performas line customization
    /// draws custom line between the indicators
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
                .frame(width: self.horizontalSpacing, height: width)
                .offset(x: proxy[value].maxX + width, y: proxy[value].midY)
                .eraseToAnyView()
        default:
            return EmptyView().eraseToAnyView()
        }
    }
}
