//
//  StepperAIBuilder.swift
//  StepperView_Example
//
//  Created on 2/15/26.
//

import SwiftUI

#if canImport(FoundationModels)

@available(iOS 26.0, *)
struct StepperAIBuilder {

    // MARK: - Color Mapping

    static func color(from name: String) -> Color {
        // Try named colors first
        switch name.lowercased() {
        case "teal":        return Colors.teal.rawValue
        case "red":         return Colors.red(.normal).rawValue
        case "green":       return Colors.green(.normal).rawValue
        case "blue":        return Colors.blue(.teal).rawValue
        case "orange":      return Colors.orange.rawValue
        case "lavender":    return Colors.lavendar.rawValue
        case "cyan":        return Colors.cyan.rawValue
        case "black":       return Colors.black.rawValue
        case "yellow":      return Colors.yellow(.regular).rawValue
        case "polar":       return Colors.polar.rawValue
        default:
            break
        }
        // Try hex color (e.g. "#FF6B35" or "FF6B35")
        if let hexColor = Color(hex: name) {
            return hexColor
        }
        return Colors.teal.rawValue
    }

    /// Checks whether a color string is a hex value (as opposed to a named color).
    static func isHexColor(_ name: String) -> Bool {
        let trimmed = name.hasPrefix("#") ? String(name.dropFirst()) : name
        return trimmed.count == 6 && trimmed.allSatisfy(\.isHexDigit)
    }

    // MARK: - Indicator Mapping

    private static let validSymbols: Set<String> = Set(StepperAIConfig.validSFSymbols)

    private static let indicatorSize: CGFloat = StepperAIConfig.defaults.indicatorSize

    static func indicator(for step: GeneratedStep) -> StepperIndicationType<AnyView> {
        let stepColor = color(from: step.color)

        switch step.indicatorType.lowercased() {
        case "numberedcircle":
            return .custom(
                NumberedCircleView(text: "\(step.stepNumber)", width: indicatorSize, color: stepColor)
                    .eraseToAnyView()
            )
        case "sfsymbol":
            let requested = step.sfSymbolName ?? "circle.fill"
            let symbolName = validSymbols.contains(requested) ? requested : "checkmark.circle.fill"
            return .custom(
                CircledIconView(image: Image(systemName: symbolName),
                                width: indicatorSize,
                                strokeColor: stepColor)
                    .eraseToAnyView()
            )
        case "circle":
            return .custom(
                CircledIconView(image: Image(systemName: "circle.fill"),
                                width: indicatorSize,
                                color: stepColor,
                                strokeColor: stepColor)
                    .eraseToAnyView()
            )
        default:
            return .custom(
                CircledIconView(image: Image(systemName: "circle.fill"),
                                width: indicatorSize,
                                color: stepColor,
                                strokeColor: stepColor)
                    .eraseToAnyView()
            )
        }
    }

    // MARK: - Code Generation

    static func generateCode(from config: GeneratedStepperConfig) -> String {
        let steps = config.steps.sorted { $0.stepNumber < $1.stepNumber }
        let hasPitStops = steps.contains { $0.pitStopText != nil && !$0.pitStopText!.isEmpty }

        var code = "import SwiftUI\nimport StepperView\n\n"
        code += "struct Generated\(config.title.replacingOccurrences(of: " ", with: ""))View: View {\n\n"

        // Steps array
        code += "    let steps = [\n"
        for (i, step) in steps.enumerated() {
            let comma = i < steps.count - 1 ? "," : ""
            code += "        TextView(text: \"\(step.title)\", font: .system(size: 14, weight: .semibold))\(comma)\n"
        }
        code += "    ]\n\n"

        // Indicators array
        code += "    let indicators = [\n"
        for (i, step) in steps.enumerated() {
            let comma = i < steps.count - 1 ? "," : ""
            let colorCode = colorCodeString(from: step.color)
            switch step.indicatorType.lowercased() {
            case "numberedcircle":
                code += "        StepperIndicationType<AnyView>.custom(\n"
                code += "            NumberedCircleView(text: \"\(step.stepNumber)\", width: 40, color: \(colorCode))\n"
                code += "                .eraseToAnyView())\(comma)\n"
            case "sfsymbol":
                let requested = step.sfSymbolName ?? "circle.fill"
                let symbolName = validSymbols.contains(requested) ? requested : "checkmark.circle.fill"
                code += "        StepperIndicationType<AnyView>.custom(\n"
                code += "            CircledIconView(image: Image(systemName: \"\(symbolName)\"),\n"
                code += "                            width: 40,\n"
                code += "                            strokeColor: \(colorCode))\n"
                code += "                .eraseToAnyView())\(comma)\n"
            default:
                code += "        StepperIndicationType<AnyView>.custom(\n"
                code += "            CircledIconView(image: Image(systemName: \"circle.fill\"),\n"
                code += "                            width: 40,\n"
                code += "                            color: \(colorCode),\n"
                code += "                            strokeColor: \(colorCode))\n"
                code += "                .eraseToAnyView())\(comma)\n"
            }
        }
        code += "    ]\n\n"

        // Pit stops
        if hasPitStops {
            code += "    let pitStops = [\n"
            for (i, step) in steps.enumerated() {
                let comma = i < steps.count - 1 ? "," : ""
                let text = step.pitStopText ?? " "
                code += "        TextView(text: \"\(text)\").eraseToAnyView()\(comma)\n"
            }
            code += "    ]\n\n"

            code += "    let pitStopLines = [\n"
            for (i, step) in steps.enumerated() {
                let comma = i < steps.count - 1 ? "," : ""
                let colorCode = colorCodeString(from: step.color)
                code += "        StepperLineOptions.custom(1, \(colorCode))\(comma)\n"
            }
            code += "    ]\n\n"
        }

        // Body
        code += "    var body: some View {\n"
        code += "        StepperView()\n"
        code += "            .addSteps(steps)\n"
        code += "            .indicators(indicators)\n"

        // Life cycles
        let lcValues = steps.map { $0.lifeCycle.lowercased() == "completed" ? ".completed" : ".pending" }
        code += "            .stepLifeCycles([\(lcValues.joined(separator: ", "))])\n"

        if hasPitStops {
            code += "            .addPitStops(pitStops)\n"
            code += "            .pitStopLineOptions(pitStopLines)\n"
            code += "            .stepIndicatorMode(.\(config.mode.lowercased()))\n"
            code += "            .autoSpacing(true)\n"
        } else {
            let lineColorCode = steps.first.map { colorCodeString(from: $0.color) } ?? "Colors.teal.rawValue"
            let isHorizontal = config.mode.lowercased() == "horizontal"
            if isHorizontal {
                code += "            .lineOptions(StepperLineOptions.rounded(2, 4, \(lineColorCode)))\n"
            } else {
                code += "            .lineOptions(StepperLineOptions.custom(2, \(lineColorCode)))\n"
            }
            code += "            .stepIndicatorMode(.\(config.mode.lowercased()))\n"
            code += "            .spacing(\(isHorizontal ? 70 : Int(config.spacing)))\n"
        }

        code += "    }\n"
        code += "}\n"

        return code
    }

    private static func colorCodeString(from name: String) -> String {
        switch name.lowercased() {
        case "teal":     return "Colors.teal.rawValue"
        case "red":      return "Colors.red(.normal).rawValue"
        case "green":    return "Colors.green(.normal).rawValue"
        case "blue":     return "Colors.blue(.teal).rawValue"
        case "orange":   return "Colors.orange.rawValue"
        case "lavender": return "Colors.lavendar.rawValue"
        case "cyan":     return "Colors.cyan.rawValue"
        case "black":    return "Colors.black.rawValue"
        case "yellow":   return "Colors.yellow(.regular).rawValue"
        case "polar":    return "Colors.polar.rawValue"
        default:
            // Hex color → generate Color(hex:) initializer in code output
            if isHexColor(name) {
                let hex = name.hasPrefix("#") ? name : "#\(name)"
                return "Color(hex: \"\(hex)\")!"
            }
            return "Colors.teal.rawValue"
        }
    }

    // MARK: - Build StepperView

    @ViewBuilder
    public static func buildStepperView(from config: GeneratedStepperConfig) -> some View {
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

        let hasPitStops = steps.contains { $0.pitStopText != nil && !$0.pitStopText!.isEmpty }

        if hasPitStops {
            // Ensure every step has pit stop content; use a space placeholder for nil entries
            // so the pit stop array count matches and connector lines render properly.
            let pitStops = steps.map { step in
                TextView(text: (step.pitStopText ?? "").isEmpty ? " " : step.pitStopText!,
                         font: .caption)
                    .eraseToAnyView()
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
                .stepIndicatorMode(config.mode.lowercased() == "horizontal" ? .horizontal : .vertical)
                .autoSpacing(true)
        } else {
            let lineColor = steps.first.map { color(from: $0.color) } ?? Colors.teal.rawValue
            let isHorizontal = config.mode.lowercased() == "horizontal"
            let lineOption = isHorizontal
                ? StepperLineOptions.rounded(2, 4, lineColor)
                : StepperLineOptions.custom(2, lineColor)
            StepperView()
                .addSteps(stepViews)
                .indicators(indicators)
                .stepLifeCycles(lifeCycles)
                .lineOptions(lineOption)
                .stepIndicatorMode(isHorizontal ? .horizontal : .vertical)
                .spacing(isHorizontal ? 70 : CGFloat(config.spacing))
        }
    }
}

#endif
