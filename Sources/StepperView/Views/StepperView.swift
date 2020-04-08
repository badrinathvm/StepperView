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
    public var verticalSpacing: CGFloat
    
    public init(cells: [Cell], alignments: [StepperAlignment],indicationType: [StepperIndicationType<AnyView>],verticalSpacing:CGFloat = 30.0) {
        self.cells = cells
        self.alignments = alignments
        self.indicationType = indicationType
        self.verticalSpacing = verticalSpacing
    }
    
    public var body: some View {
        HStack {
            //line view to host indicator to point
            LineView(dividerHeight: $dividerHeight)
            VStack(spacing: verticalSpacing) {
                ForEach(self.cells.indices) { index in
                    HStack(alignment: self.getAlignment(type: self.alignments[index])) {
                        IndicatorView(type: self.indicationType[index])
                            .padding(.horizontal, CGFloat(10.0))
                            .eraseToAnyView()
                        self.cells[index]
                            .heightPreference(column: index)
                            //.anchorPreference(key: BoundsPreferenceKey.self, value: .bounds) { TopBottomBoundsPreferenceKey(topLeading: $0) }
                        //.anchorPreference(key: BoundsPreferenceKey.self, value: .topLeading, transform: { TopBottomBoundsPreferenceKey(topLeading: $0) })
//                            .anchorPreference(key: BoundsPreferenceKey.self, value: .topLeading, transform: {  ( value: inout TopBottomBoundsPreferenceKey, anchor: Anchor<CGPoint>) in
//                                value.topLeading = anchor
//                            })
//                        .transformAnchorPreference(key: BoundsPreferenceKey.self, value: .bottomTrailing, transform: { ( value: inout TopBottomBoundsPreferenceKey, anchor: Anchor<CGPoint>) in
//                            value.bottomTrailing = anchor
//                        })
                        
                            .anchorPreference(key: BoundsPreferenceKey.self, value: .topLeading, transform: { TopBottomBoundsPreferenceKey(topLeading: $0)})
                            //.anchorPreference(key: BoundsPreferenceKey.self, value: .bottomTrailing, transform: { TopBottomBoundsPreferenceKey(bottomTrailing: $0)})
                            .transformAnchorPreference(key: BoundsPreferenceKey.self, value: .bottomTrailing) { (value, anchor) in
                                value?.bottomTrailing = anchor
                        }
    
                    }.setAlignment(type: self.alignments[index])
                    .offset(x: CGFloat(-40))
                }
            }.onPreferenceChange(HeightPreference.self) {
                self.columnHeights = $0
                print(self.columnHeights)
                //get heights of each of the cell + paddings to pass it back to the children i.e., LineView here.
                let paddings = CGFloat((self.verticalSpacing - 5) * CGFloat(self.cells.count))
                self.dividerHeight = Array(self.columnHeights.values).reduce(0, +) + paddings
                print("Divider Height \(self.dividerHeight)")
            }.backgroundPreferenceValue(BoundsPreferenceKey.self) { preferences in
                return GeometryReader { geometry in
                    preferences.map { p in
                         self.createBorder(geometry,p)
                    }
                }
            }
        }.padding()
    }
    
    func createBorder(_ geometry: GeometryProxy, _ preferences: TopBottomBoundsPreferenceKey) -> some View {
        let p = preferences
        
        let aTopLeading = p.topLeading
        let aBottomTrailing = p.bottomTrailing
        
        let topLeading = aTopLeading != nil ? geometry[aTopLeading!] : .zero
        let bottomTrailing = aBottomTrailing != nil ? geometry[aBottomTrailing!] : .zero
        
        
        return RoundedRectangle(cornerRadius: 15)
            .stroke(lineWidth: 3.0)
            .foregroundColor(Color.green)
            .frame(width: bottomTrailing.x - topLeading.x, height: bottomTrailing.y - topLeading.y)
            .fixedSize()
            .offset(x: topLeading.x, y: topLeading.y)
            .animation(.easeInOut(duration: 1.0))
    }
}



