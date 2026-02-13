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
                .tabItem {
                    Image(systemName: "mappin.and.ellipse")
                    Text("PitStops")
                }
            ExampleView5()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Examples")
                }
            ExampleView11()
                .tabItem {
                    Image(systemName: "arrow.triangle.2.circlepath")
                    Text("LifeCycle")
                }
//            ExampleView2()
//                .tabItem { Text("Usecase") .foregroundColor(Color.black) }
            ExampleView3()
                .tabItem {
                    Image(systemName: "creditcard")
                    Text("Card")
                }
            ExampleView1()
                .tabItem {
                    Image(systemName: "circle.grid.2x2")
                    Text("Basic")
                }
        }

        // to test dynamic way of adding steps, use ExampleView9
        //ExampleView9()

        // if there are many steps, embed it in scroll view and then set frame to it.
        //ExampleView7()
    }
}
