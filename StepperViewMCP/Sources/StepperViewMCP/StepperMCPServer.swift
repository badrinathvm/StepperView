//
//  StepperMCPServer.swift
//  StepperViewMCP
//
//  Registers the four MCP tools and starts the stdio transport.
//

import MCP
import Foundation

// MARK: - Server

struct StepperMCPServer: Sendable {

    private let config: AppConfig

    init(config: AppConfig) {
        self.config = config
    }

    func run() async throws {
        let server = Server(
            name: "StepperView MCP",
            version: "1.0.0",
            capabilities: .init(tools: .init(listChanged: false))
        )

        let allTools: [Tool] = [
            GenerateCodeTool.definition,
            ListColorsTool.definition,
            ListSymbolsTool.definition,
            GetExampleTool.definition
        ]

        let transport = StdioTransport()
        try await server.start(transport: transport)

        let config = self.config  // capture value type for Sendable closures

        await server.withMethodHandler(ListTools.self) { _ in
            return .init(tools: allTools)
        }

        await server.withMethodHandler(CallTool.self) { params in
            do {
                return try Self.dispatch(params: params, config: config)
            } catch {
                return .init(
                    content: [.text("Error: \(error.localizedDescription)")],
                    isError: true
                )
            }
        }

        await server.waitUntilCompleted()
    }

    // MARK: - Dispatch

    private static func dispatch(
        params: CallTool.Parameters,
        config: AppConfig
    ) throws -> CallTool.Result {
        switch params.name {
        case GenerateCodeTool.toolName:
            return GenerateCodeTool.handle(params: params, config: config)
        case ListColorsTool.toolName:
            return ListColorsTool.handle(config: config)
        case ListSymbolsTool.toolName:
            return ListSymbolsTool.handle(config: config)
        case GetExampleTool.toolName:
            return GetExampleTool.handle(params: params)
        default:
            return .init(
                content: [.text("Unknown tool: '\(params.name)'. Available: generate_stepper_code, list_colors, list_sf_symbols, get_example")],
                isError: true
            )
        }
    }
}
