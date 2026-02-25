//
//  GenerateCodeTool.swift
//  StepperViewMCP
//
//  Core MCP tool: accepts structured parameters and returns production-ready
//  SwiftUI StepperView code using the same fluent API format as the
//  StepperAIBuilder.generateCode(from:) method in the main library.
//
//  All code-generation logic is plain Swift — no SwiftUI imports required.
//

import MCP
import Foundation

// MARK: - Plain config models (no SwiftUI / @Generable)

struct StepperConfig: Sendable {
    var title: String
    var mode: String          // "vertical" | "horizontal"
    var spacing: Double
    var steps: [StepConfig]
}

struct StepConfig: Sendable {
    var stepNumber: Int
    var title: String
    var indicatorType: String // "numberedCircle" | "circle" | "sfSymbol"
    var sfSymbolName: String?
    var color: String         // named color or hex
    var lifeCycle: String     // "completed" | "pending"
    var pitStopText: String?
}

// MARK: - Tool definition

enum GenerateCodeTool {

    static let toolName = "generate_stepper_code"

    static var definition: Tool {
        Tool(
            name: toolName,
            description: "Generate production-ready SwiftUI StepperView code from structured parameters. Returns an import-ready Swift file using StepperView's fluent API.",
            inputSchema: .object([
                "type": .string("object"),
                "properties": .object([
                    "stepCount": .object([
                        "type": .string("integer"),
                        "description": .string("Number of steps to generate (default: 5)"),
                        "default": .int(5)
                    ]),
                    "mode": .object([
                        "type": .string("string"),
                        "description": .string("Layout orientation"),
                        "enum": .array([.string("vertical"), .string("horizontal")]),
                        "default": .string("vertical")
                    ]),
                    "color": .object([
                        "type": .string("string"),
                        "description": .string("Named color (teal, red, green, blue, orange, lavender, cyan, black, yellow, polar) or hex string like #FF6B35"),
                        "default": .string("teal")
                    ]),
                    "indicatorType": .object([
                        "type": .string("string"),
                        "description": .string("Indicator style for all steps"),
                        "enum": .array([.string("numberedCircle"), .string("circle"), .string("sfSymbol")]),
                        "default": .string("numberedCircle")
                    ]),
                    "sfSymbolName": .object([
                        "type": .string("string"),
                        "description": .string("SF Symbol name when indicatorType is 'sfSymbol' (e.g. 'checkmark.circle.fill')")
                    ]),
                    "includePitStops": .object([
                        "type": .string("boolean"),
                        "description": .string("Include pit stop content below each step indicator"),
                        "default": .bool(false)
                    ]),
                    "title": .object([
                        "type": .string("string"),
                        "description": .string("Short descriptive title used as the SwiftUI struct name (e.g. 'Onboarding', 'DeliveryTracking')"),
                        "default": .string("Generated")
                    ]),
                    "stepTitles": .object([
                        "type": .string("array"),
                        "description": .string("Optional array of step label strings. If omitted, generic labels are generated."),
                        "items": .object(["type": .string("string")])
                    ]),
                    "lifeCycles": .object([
                        "type": .string("array"),
                        "description": .string("Optional array of 'completed' or 'pending' per step. Defaults to first half completed."),
                        "items": .object(["type": .string("string")])
                    ])
                ]),
                "required": .array([])
            ])
        )
    }

    // MARK: - Handler

    static func handle(params: CallTool.Parameters, config: AppConfig) -> CallTool.Result {
        let args = ToolArguments(params.arguments)

        let stepCount = max(1, args.int("stepCount", default: config.defaults.defaultStepCount))
        let mode = args.string("mode", default: config.defaults.defaultMode)
        let color = normalizeColor(args.string("color", default: "teal"), validColors: config.validColors)
        let indicatorType = normalizeIndicatorType(args.string("indicatorType", default: "numberedCircle"))
        let sfSymbolName = normalizeSymbol(args.string("sfSymbolName", default: ""), validSymbols: config.validSFSymbols)
        let includePitStops = args.bool("includePitStops", default: false)
        let title = args.string("title", default: "Generated")
        let spacing = Double(config.defaults.defaultSpacing)

        let customTitles = args.strings("stepTitles")
        let customLifeCycles = args.strings("lifeCycles")

        // Build step configs
        var steps: [StepConfig] = []
        for i in 1...stepCount {
            let stepTitle: String
            if i <= customTitles.count {
                stepTitle = customTitles[i - 1]
            } else {
                stepTitle = "Step \(i)"
            }

            let lifeCycle: String
            if i <= customLifeCycles.count {
                lifeCycle = customLifeCycles[i - 1].lowercased() == "completed" ? "completed" : "pending"
            } else {
                // Default: first half completed, rest pending
                lifeCycle = i <= stepCount / 2 ? "completed" : "pending"
            }

            let pitStopText: String? = includePitStops ? "Description for step \(i)" : nil

            steps.append(StepConfig(
                stepNumber: i,
                title: stepTitle,
                indicatorType: indicatorType,
                sfSymbolName: sfSymbolName.isEmpty ? nil : sfSymbolName,
                color: color,
                lifeCycle: lifeCycle,
                pitStopText: pitStopText
            ))
        }

        let stepperConfig = StepperConfig(
            title: title,
            mode: mode,
            spacing: spacing,
            steps: steps
        )

        let generatedCode = generateCode(from: stepperConfig, validSymbols: Set(config.validSFSymbols))
        return .init(content: [.text(generatedCode)], isError: false)
    }

    // MARK: - Code Generation
    // Ported from StepperAIBuilder.generateCode(from:) — plain Swift, no SwiftUI.

    static func generateCode(from config: StepperConfig, validSymbols: Set<String>) -> String {
        let steps = config.steps.sorted { $0.stepNumber < $1.stepNumber }
        let hasPitStops = steps.contains { $0.pitStopText != nil && !($0.pitStopText!.isEmpty) }
        let structName = config.title
            .split(separator: " ")
            .map { $0.prefix(1).uppercased() + $0.dropFirst() }
            .joined()

        var code = "import SwiftUI\nimport StepperView\n\n"
        code += "struct \(structName)View: View {\n\n"

        // Steps array
        code += "    let steps = [\n"
        for (i, step) in steps.enumerated() {
            let comma = i < steps.count - 1 ? "," : ""
            code += "        TextView(text: \"\(step.title)\", font: .system(size: 14, weight: .semibold))\(comma)\n"
        }
        code += "    ]\n\n"

        // Indicators array
        code += "    let indicators: [StepperIndicationType<AnyView>] = [\n"
        for (i, step) in steps.enumerated() {
            let comma = i < steps.count - 1 ? "," : ""
            let colorCode = colorCodeString(from: step.color)
            switch step.indicatorType.lowercased() {
            case "numberedcircle":
                code += "        .custom(\n"
                code += "            NumberedCircleView(text: \"\(step.stepNumber)\", width: 40, color: \(colorCode))\n"
                code += "                .eraseToAnyView())\(comma)\n"
            case "sfsymbol":
                let requested = step.sfSymbolName ?? "circle.fill"
                let symbolName = validSymbols.contains(requested) ? requested : "checkmark.circle.fill"
                code += "        .custom(\n"
                code += "            CircledIconView(image: Image(systemName: \"\(symbolName)\"),\n"
                code += "                            width: 40,\n"
                code += "                            strokeColor: \(colorCode))\n"
                code += "                .eraseToAnyView())\(comma)\n"
            default: // "circle"
                code += "        .custom(\n"
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
            code += "    let pitStops: [AnyView] = [\n"
            for (i, step) in steps.enumerated() {
                let comma = i < steps.count - 1 ? "," : ""
                let text = step.pitStopText ?? " "
                code += "        TextView(text: \"\(text)\").eraseToAnyView()\(comma)\n"
            }
            code += "    ]\n\n"

            code += "    let pitStopLines: [StepperLineOptions] = [\n"
            for (i, step) in steps.enumerated() {
                let comma = i < steps.count - 1 ? "," : ""
                let colorCode = colorCodeString(from: step.color)
                code += "        .custom(1, \(colorCode))\(comma)\n"
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
                code += "            .lineOptions(.rounded(2, 4, \(lineColorCode)))\n"
            } else {
                code += "            .lineOptions(.custom(2, \(lineColorCode)))\n"
            }
            code += "            .stepIndicatorMode(.\(config.mode.lowercased()))\n"
            code += "            .spacing(\(isHorizontal ? 70 : Int(config.spacing)))\n"
        }

        code += "    }\n"
        code += "}\n"

        return code
    }

    // MARK: - Helpers

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
            if isHexColor(name) {
                let hex = name.hasPrefix("#") ? name : "#\(name)"
                return "Color(hex: \"\(hex)\")!"
            }
            return "Colors.teal.rawValue"
        }
    }

    private static func isHexColor(_ name: String) -> Bool {
        let trimmed = name.hasPrefix("#") ? String(name.dropFirst()) : name
        return trimmed.count == 6 && trimmed.allSatisfy(\.isHexDigit)
    }

    private static func normalizeColor(_ color: String, validColors: [String]) -> String {
        let lower = color.lowercased()
        if validColors.map({ $0.lowercased() }).contains(lower) { return lower }
        if isHexColor(color) { return color }
        return "teal"
    }

    private static func normalizeIndicatorType(_ type: String) -> String {
        switch type.lowercased() {
        case "numberedcircle": return "numberedCircle"
        case "sfsymbol":       return "sfSymbol"
        case "circle":         return "circle"
        default:               return "numberedCircle"
        }
    }

    private static func normalizeSymbol(_ symbol: String, validSymbols: [String]) -> String {
        guard !symbol.isEmpty else { return "" }
        return validSymbols.contains(symbol) ? symbol : "checkmark.circle.fill"
    }
}

// MARK: - ToolArguments helper

/// Type-safe argument extractor for MCP tool parameters.
/// Handles the `[String: Value]?` arguments dictionary from CallTool.Parameters.
struct ToolArguments: Sendable {
    private let values: [String: Value]

    init(_ arguments: [String: Value]?) {
        self.values = arguments ?? [:]
    }

    func string(_ key: String, default defaultValue: String = "") -> String {
        guard let v = values[key] else { return defaultValue }
        if case .string(let s) = v { return s }
        return defaultValue
    }

    func int(_ key: String, default defaultValue: Int = 0) -> Int {
        guard let v = values[key] else { return defaultValue }
        switch v {
        case .int(let n):    return n
        case .double(let d): return Int(d)
        default:             return defaultValue
        }
    }

    func bool(_ key: String, default defaultValue: Bool = false) -> Bool {
        guard let v = values[key] else { return defaultValue }
        if case .bool(let b) = v { return b }
        return defaultValue
    }

    func strings(_ key: String) -> [String] {
        guard let v = values[key], case .array(let arr) = v else { return [] }
        return arr.compactMap {
            if case .string(let s) = $0 { return s }
            return nil
        }
    }
}
