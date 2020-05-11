//
//  AnimateCircleView.swift
//  StepperView
//
//  Created by Venkatnarayansetty, Badarinath on 5/6/20.
//

import SwiftUI
import Combine

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public struct AnimatedCircleView: View {
    var text:String
    var delay:Double
    var width:CGFloat
    var color:Color
    var triggerAnimation:Bool
        
    public init(text: String, delay:Double = 0.0, width: CGFloat = 30.0, color: Color = Colors.teal.rawValue, triggerAnimation:Bool = false) {
        self.text = text
        self.delay = delay
        self.width = width
        self.color = color
        self.triggerAnimation = triggerAnimation
    }
    
    @State var animate:Bool = false
    public var body: some View {
        AnimatedCircle(text: text, delay: delay, width: width, color: color, triggerAnimation: triggerAnimation, animate: $animate)
    }
}

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct AnimatedCircle: View {
    var text:String
    var delay:Double
    var width:CGFloat
    var color:Color
    var triggerAnimation:Bool
    
    @State var circleProgress:CGFloat = 0
    @State var displayImage:Bool = false
    @Binding var animate:Bool
    
    var loadingTimer:LoadingTimer = LoadingTimer(value: 0.05)
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 2.0)
                .opacity(animate ? 0.3 : 1.0)
                .foregroundColor(color)
                .frame(width: width, height: width)
            
            Circle()
                .trim(from: 0.0, to: animate ? circleProgress : 1.0)
                .stroke(style: StrokeStyle(lineWidth: 2.0, lineCap: .round, lineJoin: .round))
                .frame(width: width, height: width)
                .foregroundColor(color)
                .rotationEffect(Angle(degrees: 270.0))
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
            if self.displayImage {
                Circle().frame(width: width, height: width)
                    .foregroundColor(Color.white)
                    .overlay(
                            Image(systemName: "checkmark")
                            .resizable()
                            .frame(width: Utils.standardSpacing, height: Utils.standardSpacing, alignment: .center)
                            .foregroundColor(Colors.teal.rawValue)
                    )
            } else {
               Circle().frame(width: width, height: width)
                .foregroundColor(Color.white)
                .overlay(Text(text).foregroundColor(color))
            }
        }
    }
}

// creates a publisher for loading time
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
class LoadingTimer {
    
    //create a publisher
    var publisher:Timer.TimerPublisher?
    
    private var cancellable: Cancellable?
    
    init(value: Double) {
        publisher = Timer.publish(every: value, on: .main, in: .default)
    }

    //start the publisher
    func start() {
        self.cancellable = publisher?.connect()
    }

    //cancel the publisher
    func cancel() {
        self.cancellable?.cancel()
    }
}



@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct Chart : View {
    var xValues: [String]
    var yValues: [Double]
    @Binding var showXValues: Bool

    var body: some View {
        if self.showXValues {
            return Text("Showing X Values")
        } else {
            return Text("Hiding X Values")
        }
    }
}

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct ContentView: View {
    @State var showXValues: Bool = false

    var body: some View {
        VStack {
            Chart(xValues: ["a", "b", "c"], yValues: [1, 2, 3], showXValues: self.$showXValues)
            Button(action: {
                self.showXValues.toggle()
            }, label: {
                if self.showXValues {
                    Text("Hide X Values")
                }else {
                    Text("Show X Values")
                }
            })
        }
    }
}
