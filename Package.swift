// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "StepperView",
    platforms: [
        .iOS(.v13), .macOS(.v10_15), .watchOS(.v7)
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "StepperView",
            targets: ["StepperView"]),
    ],
    dependencies: [
        .package(url: "https://github.com/jpsim/Yams.git", from: "5.0.0")
    ],
    targets: [
        .target(
            name: "StepperView",
            dependencies: ["Yams"],
            resources: [
                .process("Resources")
            ]),
        .testTarget(
            name: "StepperViewTests",
            dependencies: ["StepperView"])
    ]
)
