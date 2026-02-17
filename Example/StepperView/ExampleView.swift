//
//  ExampleView.swift
//  StepperView_Example
//
//  Created by Venkatnarayansetty, Badarinath on 4/10/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import SwiftUI
import StepperView

struct ExampleView: View {
    var body: some View {
        TabView {
            ExampleView6()
                .tabItem {
                    Image(systemName: "mappin.and.ellipse")
                    Text("PitStops")
                }
            #if canImport(FoundationModels)
            if #available(iOS 26.0, *) {
                StepperViewAIGeneratorView()
                    .tabItem {
                        Image(systemName: "wand.and.stars")
                        Text("AI")
                    }
            }
            #endif
            ExampleView5()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Examples")
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
            ExampleView11()
                .tabItem {
                    Image(systemName: "arrow.triangle.2.circlepath")
                    Text("LifeCycle")
                }
        }

        // to test dynamic way of adding steps, use ExampleView9
        //ExampleView9()

        // if there are many steps, embed it in scroll view and then set frame to it.
        //ExampleView7()
    }
}
