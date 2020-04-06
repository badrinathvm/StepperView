//
//  StepDesignerView.swift
//  Basics
//
//  Created by Venkatnarayansetty, Badarinath on 4/2/20.
//  Copyright © 2020 Badarinath Venkatnarayansetty. All rights reserved.
//

import SwiftUI
import StepperView

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct StepDesignerView: View{
    let cells = [StepperContentView(), StepperContentView(), StepperContentView() ]
    let alignments = [StepperAlignment.top,.center,.bottom]
    let indicatorTypes = [StepperIndicationType.circle,
                          StepperIndicationType.image(Image(systemName: "arrow.right.circle")),
                          StepperIndicationType.custom(AnyView(ImageView()))]
    
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                ScrollView(Axis.Set.vertical, showsIndicators: false) {
                    StepperView(cells: self.cells, alignments: self.alignments, indicationType : self.indicatorTypes,verticalSpacing: 10.0)
                }
            }
            .navigationBarTitle("Stepper View")
        }
    }
}

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct ImageView: View {
    var body: some View {
        Image(systemName: "arrow.left.circle")
        .resizable()
        .frame(width: 12, height: 12)
    }
}

//MARK:- Stepper Content View
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct StepperContentView: View {
    var body: some View {
        return rectangleContent()
    }
    
    fileprivate func roundedRectangle() -> some View {
        return rectangleContent()
        .overlay(RoundedRectangle(cornerRadius: 8)
                    .frame(width: 300)
                    .foregroundColor(Color.clear)
                    .shadow(color: Color(UIColor.black).opacity(0.03), radius: 8, x: 5, y: -5)
                    .shadow(color: Color(UIColor.black).opacity(0.03), radius: 8, y: 5)
                    .border(Color.gray))
    }
    
    fileprivate func textContent(text: String) -> some View {
          return HStack {
                  Text(text)
                  .padding(.vertical , 10)
                  .padding(.horizontal, 5)
                  .foregroundColor(Color.gray)
              Spacer()
          }
      }
      
      fileprivate func rectangleContent() -> some View  {
          return
              VStack(alignment: .leading) {
                  ForEach([StepperAlignment.top.rawValue, StepperAlignment.center.rawValue, StepperAlignment.bottom.rawValue], id:\.self) { value in
                      self.textContent(text: value)
                  }
              }
      }
}
