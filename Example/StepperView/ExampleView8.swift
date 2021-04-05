//
//  ExampleView8.swift
//  StepperView_Example
//
//  Created by Venkatnarayansetty, Badarinath on 5/17/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import SwiftUI
import StepperView

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct ExampleView8: View {
    
    let indicators = [
           StepperIndicationType.custom(CircledIconView(image: Image("tasks"),
                                                        width: 30,
                                                        strokeColor: Color.black)
                               .eraseToAnyView()),
           StepperIndicationType.custom(CircledIconView(image: Image("branch"),
                                                        width: 30,
                                                        strokeColor: Color.black)
                               .eraseToAnyView()),
           StepperIndicationType.custom(CircledIconView(image: Image("commit"),
                                                        width: 30,
                                                        strokeColor: Color.black)
                               .eraseToAnyView()),
           StepperIndicationType.custom(CircledIconView(image: Image("codereview"),
                                                           width: 30,
                                                           strokeColor: Color.black)
                                  .eraseToAnyView()),
           StepperIndicationType.custom(CircledIconView(image: Image("merge"),
                                                           width: 30,
                                                           strokeColor: Color.black)
                                  .eraseToAnyView())]
    
    let steps = [TextView(text:"Manage Tasks", font: .system(size: 14, weight: .semibold)),
                 TextView(text:"Branch", font: .system(size: 14, weight: .semibold)),
                 TextView(text:"Commit", font: .system(size: 14, weight: .semibold)),
                 TextView(text:"Code review", font: .system(size: 14, weight: .semibold)),
                 TextView(text:"Merge and release", font: .system(size: 14, weight: .semibold))]
    
    let pitStopLineOptions = [
        StepperLineOptions.custom(1, Color.black),
        StepperLineOptions.custom(1, Color.black),
        StepperLineOptions.custom(1, Color.black),
        StepperLineOptions.custom(1, Color.black)
    ]
    
    let pitStops = [
        TextView(text:GithubPitstops.p1).eraseToAnyView(),
        TextView(text:GithubPitstops.p2).eraseToAnyView(),
        TextView(text:GithubPitstops.p3).eraseToAnyView(),
        TextView(text:GithubPitstops.p4).eraseToAnyView(),
        TextView(text:GithubPitstops.p5).eraseToAnyView()
    ]
    
    var body: some View {
        List {
            StepperView()
                .addSteps(steps)
                .indicators(indicators)
                .addPitStops(pitStops)
                .pitStopLineOptions(pitStopLineOptions)
                .spacing(100)
        }
        .padding(.horizontal, -10)
        .onAppear {
            UITableView.appearance().separatorStyle = .none
        }
   }
}

struct GithubPitstops {
    static var p1 = "\n\nTriage Notifications\nBrowse Repos\nCreate an issue\nComment on issues\nAssign self to issue"
    static var p2 = "Fork or Clone repo\ngit checkout -b branch\ngit stash"
    static var p3 = "git add -p\ngit diff .\ngit commit -m\ngit push origin branch"
    static var p4 = "Open pull request\ngit checkout pr-branch\nReview and comment"
    static var p5 = "View checks\ngit rebase\ngit merge\ngit tag"
}
