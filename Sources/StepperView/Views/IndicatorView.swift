//
//  IndicatorView.swift
//  StepperView
//
//  Created by Venkatnarayansetty, Badarinath on 4/6/20.
//

import SwiftUI

//MARK:- Indicator View for Stepper Indicator
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct IndicatorView: View {
    var type: StepperIndicationType<AnyView>
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color(red: 245/255, green: 245/255, blue: 245/255), lineWidth: 5)
                .frame(width: 12, height:12)
                .overlay(getViewForOverlay(of: type))
        }
    }
    
    func getViewForOverlay(of type: StepperIndicationType<AnyView> ) -> some View {
        switch type {
        case .circle:
            return Circle()
                .frame(width: 10, height:10)
                .foregroundColor(Color.green)
                .eraseToAnyView()
        case .image(let image):
            return image
                .resizable()
                .frame(width: 12, height:12)
                .eraseToAnyView()
        case .custom(let view):
            return view.eraseToAnyView()
        }
    }
}

