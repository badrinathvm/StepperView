//
//  StepIndicatorHorizontalView.swift
//  StepperView
//
//  Created by Venkatnarayansetty, Badarinath on 4/16/20.
//

import SwiftUI

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct StepIndicatorHorizontalView<Cell:View>: View {
    @State private var lineWidth:CGFloat = 0
    @State private var lineYOffsetPosition:CGFloat = 0
    @State private var height:CGFloat = 0
    
    //constructor parameters
    var cells:[Cell]
    var alignments:[StepperAlignment]
    var indicationType: [StepperIndicationType<AnyView>]
    var lineOptions: StepperLineOptions
    var verticalSpacing:CGFloat
    
    init(cells: [Cell], alignments: [StepperAlignment] = [], indicationType: [StepperIndicationType<AnyView>],
         lineOptions: StepperLineOptions = .defaults, verticalSpacing:CGFloat = 50.0) {
           self.cells = cells
           self.alignments = alignments
           self.indicationType = indicationType
           self.lineOptions = lineOptions
           self.verticalSpacing = verticalSpacing
    }
    
    var body: some View {
        VStack {
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
    
    // MARK: - draws a label for the given index based ont he bouhnds calculated by the anchor preference.
    fileprivate func drawLabel(for index: Int, proxy: GeometryProxy, value: Anchor<CGRect>) -> some View {
         return self.cells[index]
             .frame(height: proxy[value].width * 2.5)
             .frame(width: proxy[value].width * 2.5, height: proxy[value].height)
             .padding(.vertical, Utils.standardSpacing)
             .offset(x: proxy[value].minX - proxy[value].midX, y: proxy[value].maxY)
             .allowsTightening(true)
             .multilineTextAlignment(.center)
     }
}
