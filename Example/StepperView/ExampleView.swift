//
//  ExampleView.swift
//  StepperView_Example
//
//  Created by Venkatnarayansetty, Badarinath on 4/10/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct ExampleView: View {
    var body: some View {
        TabView {
            ExampleView5()
                .tabItem { Text("Horizontal") .foregroundColor(Color.black) }
            ExampleView2()
                .tabItem { Text("Usecase") .foregroundColor(Color.black) }
            ExampleView3()
                .tabItem { Text("Card") .foregroundColor(Color.black) }
            ExampleView6()
                .tabItem { Text("PitStops") .foregroundColor(Color.black) }
            ExampleView1()
                .tabItem { Text("Basic").foregroundColor(Color.black) }
        }
    }
}
