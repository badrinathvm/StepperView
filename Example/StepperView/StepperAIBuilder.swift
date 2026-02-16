//
//  StepperAIBuilder.swift
//  StepperView_Example
//
//  Created on 2/15/26.
//

import SwiftUI
import StepperView

#if canImport(FoundationModels)

@available(iOS 26.0, *)
struct StepperAIBuilder {

    // MARK: - Color Mapping

    static func color(from name: String) -> Color {
        switch name.lowercased() {
        case "teal":
            return Colors.teal.rawValue
        case "red":
            return Colors.red(.normal).rawValue
        case "green":
            return Colors.green(.normal).rawValue
        case "blue":
            return Colors.blue(.teal).rawValue
        case "orange":
            return Colors.orange.rawValue
        case "lavender":
            return Colors.lavendar.rawValue
        case "cyan":
            return Colors.cyan.rawValue
        default:
            return Colors.teal.rawValue
        }
    }

    // MARK: - Indicator Mapping

    private static let validSymbols: Set<String> = [
        "checkmark.circle.fill", "xmark.circle.fill", "star.fill", "heart.fill", "bell.fill",
        "flag.fill", "bookmark.fill", "tag.fill", "bolt.fill", "cart.fill",
        "house.fill", "gear", "person.fill", "envelope.fill", "phone.fill",
        "mappin.circle.fill", "location.fill", "clock.fill", "calendar", "alarm.fill",
        "shippingbox.fill", "cube.fill", "gift.fill", "creditcard.fill", "banknote.fill",
        "doc.text.fill", "folder.fill", "tray.fill", "archivebox.fill", "paperplane.fill",
        "leaf.fill", "drop.fill", "flame.fill", "snowflake", "sun.max.fill",
        "moon.fill", "cloud.fill", "wrench.fill", "hammer.fill", "paintbrush.fill",
        "scissors", "lock.fill", "key.fill", "wifi", "antenna.radiowaves.left.and.right",
        "airplane", "car.fill", "bus.fill", "bicycle", "figure.walk"
    ]

    static func indicator(for step: GeneratedStep) -> StepperIndicationType<AnyView> {
        let stepColor = color(from: step.color)
        let width = CGFloat(step.indicatorWidth)

        switch step.indicatorType.lowercased() {
        case "numberedcircle":
            return .custom(
                NumberedCircleView(text: "\(step.stepNumber)", width: width, color: stepColor)
                    .eraseToAnyView()
            )
        case "sfsymbol":
            let requested = step.sfSymbolName ?? "circle.fill"
            let symbolName = validSymbols.contains(requested) ? requested : "checkmark.circle.fill"
            return .custom(
                CircledIconView(image: Image(systemName: symbolName),
                                width: width,
                                strokeColor: stepColor)
                    .eraseToAnyView()
            )
        case "circle":
            return .circle(stepColor, width)
        default:
            return .circle(stepColor, width)
        }
    }

    // MARK: - Build StepperView

    @ViewBuilder
    static func buildStepperView(from config: GeneratedStepperConfig) -> some View {
        let steps = config.steps.sorted { $0.stepNumber < $1.stepNumber }

        let stepViews = steps.map { step in
            TextView(text: step.title, font: .system(size: 14, weight: .semibold))
        }

        let indicators = steps.map { step in
            indicator(for: step)
        }

        let lifeCycles = steps.map { step in
            step.lifeCycle.lowercased() == "completed" ? StepLifeCycle.completed : StepLifeCycle.pending
        }

        let hasPitStops = steps.contains { $0.pitStopText != nil }

        if hasPitStops {
            let pitStops = steps.map { step in
                TextView(text: step.pitStopText ?? "").eraseToAnyView()
            }

            let pitStopLines = steps.map { step in
                StepperLineOptions.custom(1, color(from: step.color))
            }

            StepperView()
                .addSteps(stepViews)
                .indicators(indicators)
                .stepLifeCycles(lifeCycles)
                .addPitStops(pitStops)
                .pitStopLineOptions(pitStopLines)
                .lineOptions(StepperLineOptions.rounded(4, 8, Colors.teal.rawValue))
                .stepIndicatorMode(config.mode.lowercased() == "horizontal" ? .horizontal : .vertical)
                .spacing(CGFloat(config.spacing))
                .autoSpacing(config.autoSpacing)
        } else {
            StepperView()
                .addSteps(stepViews)
                .indicators(indicators)
                .stepLifeCycles(lifeCycles)
                .lineOptions(StepperLineOptions.rounded(4, 8, Colors.teal.rawValue))
                .stepIndicatorMode(config.mode.lowercased() == "horizontal" ? .horizontal : .vertical)
                .spacing(CGFloat(config.spacing))
                .autoSpacing(config.autoSpacing)
        }
    }
}

#endif
