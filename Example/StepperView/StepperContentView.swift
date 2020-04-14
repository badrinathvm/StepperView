//
//  StepperContentView.swift
//  StepperView_Example
//
//  Created by Venkatnarayansetty, Badarinath on 4/7/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import SwiftUI
import StepperView

// MARK: - Stepper Content View
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
                  .padding(.vertical, 10)
                  .padding(.horizontal, 5)
                  .foregroundColor(Color.gray)
                 Spacer()
            }
    }
      
      fileprivate func rectangleContent() -> some View {
          return
              VStack(alignment: .leading) {
                  ForEach([StepperAlignment.top.rawValue,
                           StepperAlignment.center.rawValue,
                           StepperAlignment.bottom.rawValue], id:\.self) { value in
                      self.textContent(text: value)
                  }
              }
      }
}

// MARK: - Image View to host Image
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct ImageView: View {
    var name:String
    var body: some View {
        Image(systemName: name)
        .resizable()
        .frame(width: 12, height: 12)
    }
}
