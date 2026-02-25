// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "StepperViewMCP",
    platforms: [
        .macOS(.v14)
    ],
    dependencies: [
        .package(url: "https://github.com/modelcontextprotocol/swift-sdk.git", from: "0.9.0"),
        .package(url: "https://github.com/jpsim/Yams.git", from: "5.0.0")
    ],
    targets: [
        .executableTarget(
            name: "stepperview-mcp",
            dependencies: [
                .product(name: "MCP", package: "swift-sdk"),
                .product(name: "Yams", package: "Yams")
            ],
            path: "Sources/StepperViewMCP",
            resources: [
                .process("Resources")
            ],
            swiftSettings: [
                .swiftLanguageMode(.v6)
            ]
        )
    ]
)
