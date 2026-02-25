//
//  ListSymbolsTool.swift
//  StepperViewMCP
//
//  MCP tool: returns the curated SF Symbol allowlist from ai_config.yaml.
//  Only symbols from this list are valid for the 'sfSymbol' indicator type.
//

import MCP
import Foundation

enum ListSymbolsTool {

    static let toolName = "list_sf_symbols"

    static var definition: Tool {
        Tool(
            name: toolName,
            description: "List all SF Symbol names that are valid for StepperView's 'sfSymbol' indicator type. Using a symbol outside this list will fall back to 'checkmark.circle.fill'.",
            inputSchema: .object([
                "type": .string("object"),
                "properties": .object([:])
            ])
        )
    }

    static func handle(config: AppConfig) -> CallTool.Result {
        var lines: [String] = []
        lines.append("# Valid SF Symbols for StepperView\n")
        lines.append("Use these names with `indicatorType: \"sfSymbol\"` in `generate_stepper_code`.\n")

        // Group into rows of 4 for readability
        let symbols = config.validSFSymbols
        stride(from: 0, to: symbols.count, by: 4).forEach { start in
            let slice = symbols[start..<min(start + 4, symbols.count)]
            lines.append("  " + slice.joined(separator: ", "))
        }

        lines.append("")
        lines.append("Total: \(symbols.count) symbols")
        lines.append("Any symbol not in this list is replaced with 'checkmark.circle.fill' at render time.")

        return .init(content: [.text(lines.joined(separator: "\n"))], isError: false)
    }
}
