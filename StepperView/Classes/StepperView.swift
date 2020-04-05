//
//  StepperView.swift
//
//  Created by Venkatnarayansetty, Badarinath on 4/4/20.
//  Copyright © 2020 Badarinath Venkatnarayansetty. All rights reserved.
//

import SwiftUI

//MARK:- Circle View for Stepper Indicator
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct CircleView: View {
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color(red: 245/255, green: 245/255, blue: 245/255), lineWidth: 5)
                .frame(width: 12, height:12)
                .overlay(Circle()
                        .frame(width: 10, height:10)
                        .foregroundColor(Color.green))
        }
    }
}

//MARK:- Line View for Stepper
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct LineView: View {
    @Binding var dividerHeight:CGFloat
    var body:some View {
        return Divider()
            .background(Color.gray)
            .frame(height: dividerHeight)
            .padding()
    }
}

//MARK:- Stepper View Implementation
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public struct StepperView<Cell:View>: View  {
    @State private var dividerHeight:CGFloat = 0
    @State private var columnHeights: [Int: CGFloat] = [:]
    public var cells:[Cell]
    public var alignments:[StepperAlignment]
    public var verticalSpacing: CGFloat = 30.0
    
    public init(cells: [Cell], alignments: [StepperAlignment],verticalSpacing:CGFloat) {
        self.cells = cells
        self.alignments = alignments
        self.verticalSpacing = verticalSpacing
    }
    
    public var body: some View {
        HStack {
            //line view to host circle to point
            LineView(dividerHeight: $dividerHeight)
            VStack(spacing: verticalSpacing) {
                ForEach(self.cells.indices) { index in
                    HStack(alignment: self.getAlignment(type: self.alignments[index])) {
                        CircleView()
                            .padding(.horizontal, 10.0)
                            .setAlignment(type: self.alignments[index])
                        self.cells[index]
                            .heightPreference(column: index)
                    }
                    .offset(x: -40)
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

//MARK:- Custom alignments
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
extension VerticalAlignment {
    private enum CustomTopAlignment: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            return context[.top]
        }
    }
    
    private enum CustomBottomAlignment: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            return context[.bottom]
        }
    }
    
    private enum CustomCenterAlignment: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            return context[VerticalAlignment.center]
        }
    }
    
    static let customTop = VerticalAlignment(CustomTopAlignment.self)
    
    static let customBottom = VerticalAlignment(CustomBottomAlignment.self)
    
    static let customCenter = VerticalAlignment(CustomCenterAlignment.self)
}

//MARK:- Helper function of View to operate on.
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
extension View {
    // Stores the height for each of column which will be passed as part of onPreference change to the view.
    func heightPreference(column: Int) -> some View {
        background(GeometryReader { proxy in
            Color.clear.preference(key: HeightPreference.self, value: [column: proxy.size.height])
        })
    }
    
    /// returns the alignment guide based on the alignemnt type.
    /// - Parameter type: sets the aligment guide.
    func setAlignment(type: StepperAlignment)-> some View  {
          switch type {
          case .top:
            return self.alignmentGuide(.customTop) { d in d[VerticalAlignment.top] - 15 }
          case .center:
            return self.alignmentGuide(.customCenter) { d in d[VerticalAlignment.center] }
          case .bottom:
            return self.alignmentGuide(.customBottom) { d in d[VerticalAlignment.bottom] + 15 }
          }
      }
    
    func getAlignment(type: StepperAlignment) -> VerticalAlignment {
        switch type {
        case .top:
            return .customTop
        case .center:
             return .customCenter
        case .bottom:
            return .customBottom
        }
    }
}

//MARK:- Collects width of all the cells, with reduce takes the maximum value for the given key
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct HeightPreference: PreferenceKey {
    typealias Value = [Int:CGFloat]
    static let defaultValue: Value = [:]
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value.merge(nextValue(), uniquingKeysWith: max)
    }
}

//MARK:- Stepper View alignments
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public enum StepperAlignment: String, CaseIterable {
    case top = "Top", center = "Center", bottom = "Bottom"
}

