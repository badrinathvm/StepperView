//
//  main.swift
//  StepperViewMCP
//
//  Entry point for the StepperView MCP stdio server.
//  Run this binary and point Claude Desktop / Cursor / VS Code at it.
//

import Foundation

let config = YAMLLoader.load()
let server = StepperMCPServer(config: config)
try await server.run()
