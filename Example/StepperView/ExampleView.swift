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


//let steps = [ Text("Cart").font(.caption),
//              Text("Delivery Address").font(.caption),
//              Text("Order Summary").font(.caption),
//              Text("Payment Method").font(.caption),
//              Text("Payment Method1").font(.caption),
//              Text("Payment Method2").font(.caption),
//              Text("Payment Method4").font(.caption),
//              Text("Track\nTracking\nTracking\nTracking\nTracking\nTracking\nTracking\nTracking\nTracking").font(.caption)]
//
//let indicationTypes = [StepperIndicationType.custom(NumberedCircleView(text: "1")),
//                        .custom(NumberedCircleView(text: "2")),
//                        .custom(NumberedCircleView(text: "3")),
//                        .custom(NumberedCircleView(text: "4")),
//                        .custom(NumberedCircleView(text: "5")),
//                        .custom(NumberedCircleView(text: "6")),
//                        .custom(NumberedCircleView(text: "7")),
//                        .custom(NumberedCircleView(text: "8"))]
//
//var body: some View {
//    StepperView()
//        .addSteps(steps)
//        .indicators(indicationTypes)
//        .stepIndicatorMode(StepperMode.vertical)
//        .spacing(30)
//        .alignments([StepperAlignment.top, .top, .top, .top, .top, .top, .top, .top])
//        .lineOptions(StepperLineOptions.custom(1, Colors.blue(.teal).rawValue))
//}
