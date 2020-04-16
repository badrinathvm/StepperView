//
//  ExampleView5.swift
//  StepperView_Example
//
//  Created by Venkatnarayansetty, Badarinath on 4/14/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import SwiftUI
import StepperView

var arr = ["Account", "Profile", "Band", "Delivery Address", "Dashboard", "Results"]

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct ExampleView5: View {
    @State var dividerWidth:CGFloat?
    var horizontalSpacing:CGFloat = 40.0
    @State var height:CGFloat?
    @State var width:CGFloat?
    @State var stateWidths:[Int:CGFloat] = [:]
    var body: some View {
        VStack {
            
//          Divider()
//                .background(Color.gray)
//                .frame(width: dividerWidth)
//                .padding()
//                .eraseToAnyView()
            
            Rectangle()
                .fill(Color.black)
                .frame(width: dividerWidth, height: 1)
            .eraseToAnyView()
            
            VStack {
                HStack(spacing: horizontalSpacing) {
                    ForEach(0..<arr.count) { index in
                        CircleView1(index: index)
                         .anchorPreference(key: BoundsPreferenceKey.self, value: .bounds) { value in
                            //print(value)
                            return value
                        }
                        .overlayPreferenceValue(BoundsPreferenceKey.self) { preferences in
                            GeometryReader { geometry in
                                preferences.map {
                                    TextView(text: arr[index], index: index)
                                        .frame(width: geometry[$0].width * 2.5,
                                               height: geometry[$0].height)
                                        .padding(.vertical, 10)
                                        .offset(x: geometry[$0].minX - geometry[$0].midX, y: geometry[$0].maxY)
                                        .allowsTightening(true)
                                        .multilineTextAlignment(.center)
                                }
                            }
                        }
                    }
                }.widthKey()
            }
             .heightKey()
             .offset(y: CGFloat(-40))
            .frame(width: 350)
        }
        .setAlignment(type: StepperAlignment.center)
            
        // width of the divider ( which is exactly the width of the horizontal stack of)
        .onPreferenceChange(WidthKey.self) { (value) in
            print("Divider Width \(String(describing: value))")
            self.dividerWidth = value
        }
        // height of complete stepper Indicator
        .onPreferenceChange(HeightKey.self) {
            print("Height Value \(String(describing: $0))")
            self.height = $0
        }
//        .onPreferenceChange(FrameWidthPreference.self) { (dict) in
//            print("Width values \(dict)")
//            self.stateWidths = dict
//            self.width = Array(dict.values).max()
//        }
        .frame(height: self.height)
    }
    
    func test(index: Int) -> Bool {
        if let widthOfIndex = self.stateWidths[index] {
           return (widthOfIndex > 50) ? true: false
        } else {
            return false
        }
    }
}

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct CircleView1: View {
    var index:Int
    var body: some View {
        NumberedCircleView(text: "\(index)")
                    .eraseToAnyView()
    }
}

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct TextView: View {
    var text:String
    var index:Int
    @State var width:CGFloat?
    var body: some View {
            Text(text)
                .font(.caption)
                //.frameWidthPref(column: index)
                .frame(height: 50)
    }
}

// MARK: - Collects width of all the cells, with reduce takes the maximum value for the given key
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct TestWidthPreference: PreferenceKey {
    typealias Value = [Int:CGFloat]
    static let defaultValue: Value = [:]

    static func reduce(value: inout Value, nextValue: () -> Value) {
        value.merge(nextValue(), uniquingKeysWith: max)
    }
}

// MARK: - Collects width of all the cells, with reduce takes the maximum value for the given key
//@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct FrameWidthPreference: PreferenceKey {
    typealias Value = [Int:CGFloat]
    static let defaultValue: Value = [:]

    static func reduce(value: inout Value, nextValue: () -> Value) {
        value.merge(nextValue(), uniquingKeysWith: max)
    }
}

struct HeightKey: PreferenceKey {
    static let defaultValue: CGFloat? = nil
    static func reduce(value: inout CGFloat?,
                       nextValue: () -> CGFloat?) {
        value = value ?? nextValue()
    }
}

struct WidthKey: PreferenceKey {
    static let defaultValue: CGFloat? = nil
    static func reduce(value: inout CGFloat?,
                       nextValue: () -> CGFloat?) {
        value = value ?? nextValue()
    }
}

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
extension View {
    // Stores the width for each of column which will be passed as part of onPreference change to parent view.
    func frameWidthPref(column: Int) -> some View {
        background(GeometryReader { proxy in
            Color.clear.preference(key: FrameWidthPreference.self, value:  [column:proxy.size.width])
        })
    }
    
    // Stores the height for each of column which will be passed as part of onPreference change to parent view.
    func heightKey() -> some View {
        background(GeometryReader { proxy in
            Color.clear.preference(key: HeightKey.self, value:  proxy.size.height)
        })
    }
    
    // Stores the width for each of column which will be passed as part of onPreference change to parent view.
    func widthKey() -> some View {
        background(GeometryReader { proxy in
            Color.clear.preference(key: WidthKey.self, value:  proxy.size.width)
        })
    }
    
    // Stores the width for each of column which will be passed as part of onPreference change to parent view.
    func widthPref(column: Int = 0) -> some View {
        background(GeometryReader { proxy in
            Color.clear.preference(key: TestWidthPreference.self, value: [column: proxy.size.width])
        })
    }
}
