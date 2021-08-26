//
//  View+Extensions.swift
//  StepperView
//
//  Created by Venkatnarayansetty, Badarinath on 4/6/20.
//

import SwiftUI
import Combine

// MARK: - Helper function of View to operate on.
/// Helper function of  `View`  to operate on
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public extension View {
        
    /// Stores the height for each of column which will be passed as part of onPreference change parent view.
    func heightPreference(column: Int) -> some View {
        background(GeometryReader { proxy in
            Color.clear.preference(key: HeightPreference.self, value: [column: proxy.size.height])
        })
    }
    
    /// Stores the width for each of column which will be passed as part of onPreference change to parent view.
    func widthPreference(column: Int) -> some View {
        background(GeometryReader { proxy in
            Color.clear.preference(key: WidthPreference.self, value: [column: proxy.size.width])
        })
    }
    
    /// Stores the width which will be passed as part of onPreference change to parent view.
    func widthKey() -> some View {
        background(GeometryReader { proxy in
            Color.clear.preference(key: WidthKey.self, value:  proxy.size.width)
        })
    }
    
    /// Stores the height for each of column which will be passed as part of onPreference change to parent view.
    func heightKey() -> some View {
        background(GeometryReader { proxy in
            Color.clear.preference(key: HeightKey.self, value:  proxy.size.height)
        })
    }
    
    /// Stores the height for each of column which will be passed as part of onPreferenceChange to parent view.
    func verticalHeightPreference(column: Int? = 0) -> some View {
        background(GeometryReader { proxy in
            Color.clear.preference(key: VerticalHeightPreference.self, value: [column!: proxy.size.height])
        })
    }
    
    /// Stores the height for each of column which will be passed as part of onPreferenceChange to parent view.
    func pitstopHeightPreference(column: Int? = 0) -> some View {
        background(GeometryReader { proxy in
            Color.clear.preference(key: PitstopHeightPreference.self, value: [column!: proxy.size.height])
        })
    }
    
    /// Stores CGRect data for each cell which will be passed as part of onPreferenceChange to the parent view.
    func cgRectPreference() -> some View {
        background(GeometryReader { proxy in
            Color.clear.preference(key: CGRectPreferenceKey.self, value: CGRectData(rect: proxy.frame(in: .global)))
        })
    }
    
    /// returns the alignment guide based on the alignemnt type.
    /// - Parameter type: sets the aligment guide.
    func setAlignment(type: StepperAlignment)-> some View {
        switch type {
        case .top:
            return self.alignmentGuide(.customTop) { alignment in alignment[VerticalAlignment.top] }
        case .center:
            return self.alignmentGuide(.customCenter) { alignment in alignment[VerticalAlignment.center] }
        case .bottom:
            return self.alignmentGuide(.customBottom) { alignment in alignment[VerticalAlignment.bottom] }
        }
    }
    
    /// returmns the alginment based ont he Stepper Alignment
    /// - Parameter type: StepperAlignment enum
    func getAlignment(type: StepperAlignment) -> VerticalAlignment {
        switch type {
        case .top:
            return .customTop
        case .center:
            return .customCenter
        case .bottom:
            return .customBottom
        }
    }
    
    /// Embeds the view in navigationView
    func embedINNavigationView() -> some View {
        #if os(iOS)
         return NavigationView { self }
        #else
         return EmptyView()
        #endif
    }
    
    /// Wrapper to  AnyView
    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
    
    /// Returns either `top`,  `center`  `bottom`  bound positions
    func getYPosition(for alignment: StepperAlignment) -> CGFloat {
        switch alignment {
        case .top:
            return VerticalAlignment.topValue
        case .center:
            return VerticalAlignment.centerValue
        case .bottom:
            return VerticalAlignment.bottomValue
        }
    }
    
    /// Configures Steps to environment value
    func addSteps<Cell:View>(_ steps: [Cell]) -> some View {
        self.environment(\EnvironmentValues.steps, steps.map { $0.eraseToAnyView() })
    }
    
    /// Sets alignments to environment value
    func alignments(_ alignments: [StepperAlignment] = []) -> some View {
        self.environment(\EnvironmentValues.alignments, alignments)
    }
    
    /// Sets lifecycle status to environment value
    func stepLifeCycles(_ lifecycle: [StepLifeCycle] = [.completed, .completed, .completed]) -> some View {
        self.environment(\EnvironmentValues.stepLifeCycle, lifecycle)
    }
    
    /// Sets indicators to environment value
    func indicators<Cell:View>(_ indicators: [StepperIndicationType<Cell>] = []) -> some View {
        self.environment(\EnvironmentValues.indicationType, indicators.map { value  in
            switch value {
            case .custom(let view): return StepperIndicationType.custom(view.eraseToAnyView())
            case .circle(let color, let width): return StepperIndicationType.circle(color, width)
            case .image(let image, let width): return StepperIndicationType.image(image, width)
            case .animation(let view):  return StepperIndicationType.animation(view)
            }
        })
    }
    
    /// Configures step Indicator mode to environment value
    func stepIndicatorMode(_ mode: StepperMode) -> some View {
        self.environment(\EnvironmentValues.stepperMode, mode)
    }
    
    /// Configures spacing to environment value
    func spacing(_ value: CGFloat) -> some View {
        self.environment(\EnvironmentValues.spacing, value)
    }
    
    /// Configures auto spacing to environment value
    func autoSpacing(_ value: Bool) -> some View {
        self.environment(\EnvironmentValues.autoSpacing, value)
    }
    
    /// Configures edgeInsets  to environment value
    func stepperEdgeInsets(_ value: EdgeInsets) -> some View {
        self.environment(\EnvironmentValues.stepperEdgeInsets, value)
    }
    
    /// Configures line options to environment value
    func lineOptions(_ options: StepperLineOptions) -> some View {
        self.environment(\EnvironmentValues.lineOptions, options)
    }
    
    /// Conditional modifier
    func ifTrue<Content: View>(_ conditional: Bool, content: (Self) -> Content) -> some View {
        if conditional {
            return content(self).eraseToAnyView()
        } else {
            return self.eraseToAnyView()
        }
    }

    /// Custom behavior for pitstops
    /// - Parameter steps: list of pitstop step views
    func addPitStops(_ steps: [AnyView]) -> some View {
        self.environment(\EnvironmentValues.pitStopOptions, steps.map { $0.eraseToAnyView() })
    }
    
    /// Custom behavior for pitstops
    /// - Parameter steps: list of pitstop line options views
    func pitStopLineOptions(_ options: [StepperLineOptions]) -> some View {
        self.environment(\EnvironmentValues.pitStopLineOptions, options)
    }
    
    /// Custom behavior for pitstops
    /// - Parameter steps: list of pitstop step views
    func animateSteps(_ count: Int) -> some View {
        return self.environment(\EnvironmentValues.stepAnimations, count)
    }
    
    /// Custom behavior for pitstops
    /// - Parameter steps: list of pitstop step views
    func loadingAnimationTime(_ time: Double) -> some View {
        return self.environment(\EnvironmentValues.loadAnimationTime, time)
    }
    
    /// Method to add logging in View
    /// - Parameter log: logging string to be displayed
    func log(_ log: String) -> EmptyView {
        print("** \(log)")
        return EmptyView()
    }
}
