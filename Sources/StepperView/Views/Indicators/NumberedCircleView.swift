//
//  AnimateCircleView.swift
//  StepperView
//
//  Created by Venkatnarayansetty, Badarinath on 5/6/20.
//

import SwiftUI

/// Circle view with text inside for Step Indicator
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public struct NumberedCircleView: View {
    /// text to be paced inside the circle
    var text:String
    /// width of the step indicator
    var width:CGFloat
    /// color of the step indicator
    var color:Color
    /// delay for the animation to happen
    var delay:Double
    /// flag to tigger animation or not.
    var triggerAnimation:Bool
    /// animation state to render the view
    @State var animate:Bool = false
    /// loading time for animations
    @Environment(\.loadAnimationTime) var loadingTime
       
    ///initilazes `text` ,  `width`, `color` , `delay` and  `triggerAnimation`
    public init(text: String, width: CGFloat = 30.0, color: Color = Colors.teal.rawValue,
                delay:Double = 0.0,
                triggerAnimation:Bool = false) {
        self.text = text
        self.width = width
        self.color = color
        self.delay = delay
        self.triggerAnimation = triggerAnimation
    }
    
    /// provides the content and behavior of this view.
    public var body: some View {
        AnimatedCircle(text: text, width: width, color: color,
                       delay: delay, triggerAnimation: triggerAnimation,
                       loadingTimer: LoadingTimer(value: loadingTime),
                       animate: $animate)
    }
}

/// circles around the border with progress
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct AnimatedCircle: View {
    /// text to be paced inside the circle
    var text:String
    /// width of the step indicator
    var width:CGFloat
    /// color of the step indicator
    var color:Color
    /// delay for the animation to happen
    var delay:Double
    /// flag to tigger animation or not.
    var triggerAnimation:Bool
    /// loading time for animations
    var loadingTimer:LoadingTimer
    
    /// state to track the progress of the circle
    @State var circleProgress:CGFloat = 0
    /// handle completion status of the animation
    @State var completion:Bool = false
    /// state to render view based on the value
    @Binding var animate:Bool
    
    /// detect the color scheme i.e., light or dark mode
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    /// provides the content and behavior of this view.
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 2.0)
                .opacity(animate ? 0.3 : 1.0)
                .foregroundColor(self.color)
                .frame(width: width, height: width)
            
            Circle()
                .trim(from: 0.0, to: animate ? circleProgress : 1.0)
                .stroke(style: StrokeStyle(lineWidth: 2.0, lineCap: .round, lineJoin: .round))
                .frame(width: width, height: width)
                .foregroundColor(self.color)
                .rotationEffect(Angle(degrees: Utils.angleRotation))
                .onReceive(loadingTimer.publisher!, perform: { _ in
                    withAnimation(Animation.easeIn.delay(self.delay)) {
                        self.circleProgress += 0.01
                        if self.circleProgress >= 1.0 {
                            self.loadingTimer.cancel()
                        }
                    }
                })
                .overlay(image)
        }.onAppear {
            if self.triggerAnimation {
                self.animate.toggle()
                self.loadingTimer.start()
            }
        }.onDisappear {
            self.loadingTimer.cancel()
        }
    }
    
    private var image: some View {
        Group {
            if self.completion {
                 #if os(iOS) || os(watchOS)
                Circle().frame(width: width, height: width)
                    .foregroundColor(colorScheme == .light ? Color.white : Color.black)
                    .overlay(
                            Image(systemName: "checkmark")
                            .resizable()
                            .frame(width: Utils.standardSpacing, height: Utils.standardSpacing, alignment: .center)
                            .foregroundColor(Colors.teal.rawValue))
                #endif
            } else {
               Circle().frame(width: width, height: width)
                .foregroundColor(colorScheme == .light ? Color.white : Color.black)
                .overlay(Text(text).foregroundColor(color))
            }
        }
    }
}
