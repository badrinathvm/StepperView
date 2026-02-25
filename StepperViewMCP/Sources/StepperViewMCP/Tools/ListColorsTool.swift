//
//  ListColorsTool.swift
//  StepperViewMCP
//
//  MCP tool: returns all valid named colors and a note about hex support.
//

import MCP
import Foundation

enum ListColorsTool {

    static let toolName = "list_colors"

    static var definition: Tool {
        Tool(
            name: toolName,
            description: "List all valid named colors supported by StepperView. Hex colors (e.g. #FF6B35) are also accepted anywhere a color is required.",
            inputSchema: .object([
                "type": .string("object"),
                "properties": .object([:])
            ])
        )
    }

    static func handle(config: AppConfig) -> CallTool.Result {
        var lines: [String] = []
        lines.append("# StepperView Valid Colors\n")
        lines.append("## Named Colors")
        for color in config.validColors {
            lines.append("  - \(color)")
        }
        lines.append("")
        lines.append("## Hex Colors")
        lines.append("  Any 6-digit hex color is accepted (with or without #).")
        lines.append("  Examples: #FF6B35, #8B5CF6, EC4899")
        lines.append("")
        lines.append("Pass any of the above to the `color` parameter of `generate_stepper_code`.")

        return .init(content: [.text(lines.joined(separator: "\n"))], isError: false)
    }
}
