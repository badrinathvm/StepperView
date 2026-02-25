//
//  main.swift
//  StepperViewMCP
//
//  Entry point for the StepperView MCP stdio server.
//  Run this binary and point Claude Desktop / Cursor / VS Code at it.
//

import Foundation

// Load config once at startup, then launch the server.
Task {
    do {
        let config = YAMLLoader.load()
        let server = StepperMCPServer(config: config)
        // run() blocks until the MCP client disconnects (stdin closes).
        try await server.run()
    } catch {
        fputs("[StepperViewMCP] Fatal error: \(error)\n", stderr)
    }
    exit(0)
}

// Keep the main thread alive while the Task's async work runs.
RunLoop.main.run()
