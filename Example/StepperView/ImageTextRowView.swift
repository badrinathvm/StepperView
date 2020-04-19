//
//  CustomView.swift
//  StepperView_Example
//
//  Created by Venkatnarayansetty, Badarinath on 4/9/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import SwiftUI
import StepperView

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct ImageTextRowView: View {
    var text:String
    var imageName:String
    var body: some View {
        VStack {
            HStack {
                Image(imageName)
                    .resizable()
                    .padding(.leading, 7)
                    .frame(width: 30, height: 30)
                    .aspectRatio(contentMode: .fit)
                
                Text(text)
                    .foregroundColor(Colors.blue(.teal).rawValue)
                    .font(.system(size: 16, weight: Font.Weight.medium))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(EdgeInsets(top: 10, leading: 2, bottom: 10, trailing: 10))
                
            }.padding(.horizontal, 5)
                .offset(x: -5)
                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(cornerRadius: 8.0)
                        .stroke(Color.gray, lineWidth: 0.5)
                        .foregroundColor(Color.white)
                        .shadow(color: Color(UIColor.black).opacity(0.03), radius: 8, x: 5, y: -5)
                        .shadow(color: Color(UIColor.black).opacity(0.03), radius: 8, y: 5))
            
        }
    }
}
