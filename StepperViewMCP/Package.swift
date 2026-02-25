// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "StepperViewMCP",
    platforms: [
        .macOS(.v14)
    ],
     products: [
        .executable(name: "stepperview-mcp", targets: ["stepperview-mcp"])
    ],
    dependencies: [
        .package(url: "https://github.com/modelcontextprotocol/swift-sdk.git", from: "0.9.0")
    ],
    targets: [
        .executableTarget(
            name: "stepperview-mcp",
            dependencies: [
                .product(name: "MCP", package: "swift-sdk")
            ],
            path: "Sources/StepperViewMCP"
        )
    ]
)
