//
//  ExampleView.swift
//  StepperView_Example
//
//  Created by Venkatnarayansetty, Badarinath on 4/10/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import SwiftUI
import StepperView

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct ExampleView: View {
    var body: some View {
        TabView {
            ExampleView6()
                .tabItem { Text("PitStops") .foregroundColor(Color.black) }
            ExampleView5()
                .tabItem { Text("Examples") .foregroundColor(Color.black) }
            ExampleView11()
                .tabItem { Text("LifeCycle") .foregroundColor(Color.black) }
//            ExampleView2()
//                .tabItem { Text("Usecase") .foregroundColor(Color.black) }
            ExampleView3()
                .tabItem { Text("Card") .foregroundColor(Color.black) }
            ExampleView1()
                .tabItem { Text("Basic").foregroundColor(Color.black) }
        }

        // to test dynamic way of adding steps, use ExampleView9
        //ExampleView9()

        // if there are many steps, embed it in scroll view and then set frame to it.
        //ExampleView7()
    }
}
