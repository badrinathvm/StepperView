# CLAUDE.md - StepperView

## Project Overview

StepperView is a SwiftUI component library for displaying step indicators in vertical and horizontal orientations. It supports iOS, watchOS, tvOS, and macOS. Published via CocoaPods (v1.6.7), Swift Package Manager, and Carthage.

## Project Structure

```
Sources/StepperView/          # Main library source
  Views/                      # Core views (StepperView, PitStopView, indicators, lines)
  Extension/                  # SwiftUI extensions (colors, environment, preferences, modifiers)
  Utils/                      # Constants and animation utilities
Example/                      # Example iOS + watchOS app (CocoaPods workspace)
  StepperView/                # iOS example app
  StepperView_Watch/          # watchOS example app
  Tests/                      # Snapshot tests
Tests/StepperViewTests/       # SPM unit tests
.github/workflows/            # CI: build, swiftlint, cocoapods deploy
```

## Build & Test

```bash
# SPM
swift build
swift test

# CocoaPods (Example app)
cd Example && pod install
# Open Example/StepperView.xcworkspace in Xcode
```

## Key Configuration Files

- `Package.swift` - SPM manifest (Swift 5.1+, iOS 11.0+)
- `StepperView.podspec` - CocoaPods spec (Swift 5.0, iOS 11.0+, watchOS 6.0+)
- `.swiftlint.yml` - Linting rules
- `.github/workflows/swift.yml` - CI pipeline (build + test on push/PR)

## Coding Conventions

- **SwiftUI-native**: No UIKit in the library; UIKit only in Example app hosting
- **Fluent API**: Public modifiers via View extensions (e.g., `.addSteps()`, `.indicators()`, `.spacing()`)
- **Environment-driven config**: Uses `@Environment` and custom `EnvironmentKey` for passing options
- **PreferenceKeys**: Used for child-to-parent communication between views
- **Naming**: PascalCase for types, camelCase for properties/functions
- **Line length**: 160 characters max
- **Identifier length**: Warning at 45, error at 60 characters

## SwiftLint

Disabled rules: `trailing_whitespace`, `colon`, `implicit_getter`, `empty_enum_arguments`
Opted-in: `trailing_semicolon`

## Platform Targets

| Platform | Minimum Version |
|----------|----------------|
| iOS      | 11.0           |
| watchOS  | 6.0            |
| tvOS     | 13.0           |
| macOS    | 10.15          |

## Testing

- Snapshot tests use **SnapshotTesting** (~1.7.2) in `Example/Tests/`
- SPM tests in `Tests/StepperViewTests/`

## CI/CD

- **swift.yml**: Builds and tests on push to master and PRs
- **swiftlint.yml**: Lints Swift file diffs on PRs
- **deploy_to_cocoapods.yml**: Deploys on `deploy` tag push (requires `COCOAPODS_TRUNK_TOKEN`)

## Release Process

1. Update version in `StepperView.podspec`
2. Push a `deploy` tag to trigger CocoaPods trunk publish
