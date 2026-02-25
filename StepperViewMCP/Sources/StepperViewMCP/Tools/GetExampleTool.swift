//
//  GetExampleTool.swift
//  StepperViewMCP
//
//  MCP tool: returns copy-paste Swift code snippets for common StepperView patterns.
//

import MCP
import Foundation

enum GetExampleTool {

    static let toolName = "get_example"

    // Available example keys shown to the AI client
    static let availablePatterns: [String: String] = [
        "vertical":         "Basic vertical numbered stepper",
        "horizontal":       "Horizontal stepper with SF symbols",
        "pit_stops":        "Vertical stepper with pit stop descriptions",
        "hex_color":        "Stepper using a custom hex color",
        "mixed_lifecycle":  "Stepper showing completed and pending steps"
    ]

    static var definition: Tool {
        let patternList = availablePatterns
            .map { "'\($0.key)' — \($0.value)" }
            .sorted()
            .joined(separator: ", ")

        return Tool(
            name: toolName,
            description: "Return a ready-to-use Swift code snippet for a common StepperView pattern. Patterns: \(patternList).",
            inputSchema: .object([
                "type": .string("object"),
                "properties": .object([
                    "pattern": .object([
                        "type": .string("string"),
                        "description": .string("The pattern name to retrieve. Options: \(availablePatterns.keys.sorted().joined(separator: ", "))"),
                        "enum": .array(availablePatterns.keys.sorted().map { .string($0) })
                    ])
                ]),
                "required": .array([.string("pattern")])
            ])
        )
    }

    // MARK: - Handler

    static func handle(params: CallTool.Parameters) -> CallTool.Result {
        let args = ToolArguments(params.arguments)
        let pattern = args.string("pattern", default: "vertical")

        guard let snippet = examples[pattern] else {
            let available = availablePatterns.keys.sorted().joined(separator: ", ")
            return .init(
                content: [.text("Unknown pattern '\(pattern)'. Available: \(available)")],
                isError: true
            )
        }

        return .init(content: [.text(snippet)], isError: false)
    }

    // MARK: - Snippet Library

    private static let examples: [String: String] = [

        "vertical": """
        import SwiftUI
        import StepperView

        struct OnboardingView: View {

            let steps = [
                TextView(text: "Create Account", font: .system(size: 14, weight: .semibold)),
                TextView(text: "Verify Email", font: .system(size: 14, weight: .semibold)),
                TextView(text: "Set Preferences", font: .system(size: 14, weight: .semibold)),
                TextView(text: "All Done!", font: .system(size: 14, weight: .semibold))
            ]

            let indicators: [StepperIndicationType<AnyView>] = [
                .custom(NumberedCircleView(text: "1", width: 40, color: Colors.teal.rawValue).eraseToAnyView()),
                .custom(NumberedCircleView(text: "2", width: 40, color: Colors.teal.rawValue).eraseToAnyView()),
                .custom(NumberedCircleView(text: "3", width: 40, color: Colors.teal.rawValue).eraseToAnyView()),
                .custom(NumberedCircleView(text: "4", width: 40, color: Colors.teal.rawValue).eraseToAnyView())
            ]

            var body: some View {
                StepperView()
                    .addSteps(steps)
                    .indicators(indicators)
                    .stepLifeCycles([.completed, .completed, .pending, .pending])
                    .lineOptions(.custom(2, Colors.teal.rawValue))
                    .stepIndicatorMode(.vertical)
                    .spacing(50)
            }
        }
        """,

        "horizontal": """
        import SwiftUI
        import StepperView

        struct CheckoutView: View {

            let steps = [
                TextView(text: "Cart", font: .system(size: 12, weight: .semibold)),
                TextView(text: "Address", font: .system(size: 12, weight: .semibold)),
                TextView(text: "Payment", font: .system(size: 12, weight: .semibold)),
                TextView(text: "Confirm", font: .system(size: 12, weight: .semibold))
            ]

            let indicators: [StepperIndicationType<AnyView>] = [
                .custom(CircledIconView(image: Image(systemName: "cart.fill"), width: 40, strokeColor: Colors.blue(.teal).rawValue).eraseToAnyView()),
                .custom(CircledIconView(image: Image(systemName: "house.fill"), width: 40, strokeColor: Colors.blue(.teal).rawValue).eraseToAnyView()),
                .custom(CircledIconView(image: Image(systemName: "creditcard.fill"), width: 40, strokeColor: Colors.blue(.teal).rawValue).eraseToAnyView()),
                .custom(CircledIconView(image: Image(systemName: "checkmark.circle.fill"), width: 40, strokeColor: Colors.blue(.teal).rawValue).eraseToAnyView())
            ]

            var body: some View {
                StepperView()
                    .addSteps(steps)
                    .indicators(indicators)
                    .stepLifeCycles([.completed, .completed, .pending, .pending])
                    .lineOptions(.rounded(2, 4, Colors.blue(.teal).rawValue))
                    .stepIndicatorMode(.horizontal)
                    .spacing(70)
            }
        }
        """,

        "pit_stops": """
        import SwiftUI
        import StepperView

        struct DeliveryTrackingView: View {

            let steps = [
                TextView(text: "Order Placed", font: .system(size: 14, weight: .semibold)),
                TextView(text: "Processing", font: .system(size: 14, weight: .semibold)),
                TextView(text: "Shipped", font: .system(size: 14, weight: .semibold)),
                TextView(text: "Out for Delivery", font: .system(size: 14, weight: .semibold)),
                TextView(text: "Delivered", font: .system(size: 14, weight: .semibold))
            ]

            let indicators: [StepperIndicationType<AnyView>] = [
                .custom(NumberedCircleView(text: "1", width: 40, color: Colors.green(.normal).rawValue).eraseToAnyView()),
                .custom(NumberedCircleView(text: "2", width: 40, color: Colors.green(.normal).rawValue).eraseToAnyView()),
                .custom(NumberedCircleView(text: "3", width: 40, color: Colors.green(.normal).rawValue).eraseToAnyView()),
                .custom(NumberedCircleView(text: "4", width: 40, color: Colors.green(.normal).rawValue).eraseToAnyView()),
                .custom(NumberedCircleView(text: "5", width: 40, color: Colors.green(.normal).rawValue).eraseToAnyView())
            ]

            let pitStops: [AnyView] = [
                TextView(text: "Your order has been confirmed.").eraseToAnyView(),
                TextView(text: "We are preparing your items.").eraseToAnyView(),
                TextView(text: "Package dispatched via FedEx.").eraseToAnyView(),
                TextView(text: "Expected delivery by 6 PM.").eraseToAnyView(),
                TextView(text: "Package left at front door.").eraseToAnyView()
            ]

            let pitStopLines: [StepperLineOptions] = [
                .custom(1, Colors.green(.normal).rawValue),
                .custom(1, Colors.green(.normal).rawValue),
                .custom(1, Colors.green(.normal).rawValue),
                .custom(1, Colors.green(.normal).rawValue),
                .custom(1, Colors.green(.normal).rawValue)
            ]

            var body: some View {
                StepperView()
                    .addSteps(steps)
                    .indicators(indicators)
                    .stepLifeCycles([.completed, .completed, .completed, .pending, .pending])
                    .addPitStops(pitStops)
                    .pitStopLineOptions(pitStopLines)
                    .stepIndicatorMode(.vertical)
                    .autoSpacing(true)
            }
        }
        """,

        "hex_color": """
        import SwiftUI
        import StepperView

        struct BrandedStepperView: View {

            // Using a custom brand hex color — any 6-digit hex is supported.
            let brandColor = Color(hex: "#8B5CF6")!

            let steps = [
                TextView(text: "Sign Up", font: .system(size: 14, weight: .semibold)),
                TextView(text: "Choose Plan", font: .system(size: 14, weight: .semibold)),
                TextView(text: "Add Payment", font: .system(size: 14, weight: .semibold)),
                TextView(text: "Start Using", font: .system(size: 14, weight: .semibold))
            ]

            var indicators: [StepperIndicationType<AnyView>] {
                (1...4).map { n in
                    .custom(NumberedCircleView(text: "\\(n)", width: 40, color: brandColor).eraseToAnyView())
                }
            }

            var body: some View {
                StepperView()
                    .addSteps(steps)
                    .indicators(indicators)
                    .stepLifeCycles([.completed, .pending, .pending, .pending])
                    .lineOptions(.custom(2, Color(hex: "#8B5CF6")!))
                    .stepIndicatorMode(.vertical)
                    .spacing(50)
            }
        }
        """,

        "mixed_lifecycle": """
        import SwiftUI
        import StepperView

        struct ProgressTrackerView: View {

            let steps = [
                TextView(text: "Requirements", font: .system(size: 14, weight: .semibold)),
                TextView(text: "Design", font: .system(size: 14, weight: .semibold)),
                TextView(text: "Development", font: .system(size: 14, weight: .semibold)),
                TextView(text: "Testing", font: .system(size: 14, weight: .semibold)),
                TextView(text: "Deployment", font: .system(size: 14, weight: .semibold))
            ]

            // Mix colors to reflect lifecycle state visually
            let indicators: [StepperIndicationType<AnyView>] = [
                .custom(CircledIconView(image: Image(systemName: "checkmark.circle.fill"), width: 40, strokeColor: Colors.green(.normal).rawValue).eraseToAnyView()),
                .custom(CircledIconView(image: Image(systemName: "checkmark.circle.fill"), width: 40, strokeColor: Colors.green(.normal).rawValue).eraseToAnyView()),
                .custom(CircledIconView(image: Image(systemName: "gear"), width: 40, strokeColor: Colors.orange.rawValue).eraseToAnyView()),
                .custom(CircledIconView(image: Image(systemName: "clock.fill"), width: 40, strokeColor: Colors.teal.rawValue).eraseToAnyView()),
                .custom(CircledIconView(image: Image(systemName: "flag.fill"), width: 40, strokeColor: Colors.teal.rawValue).eraseToAnyView())
            ]

            var body: some View {
                StepperView()
                    .addSteps(steps)
                    .indicators(indicators)
                    .stepLifeCycles([.completed, .completed, .pending, .pending, .pending])
                    .lineOptions(.custom(2, Colors.teal.rawValue))
                    .stepIndicatorMode(.vertical)
                    .spacing(55)
            }
        }
        """
    ]
}
