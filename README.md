# StepperView

#### SwiftUI iOS component for Step Indications

[![License](https://img.shields.io/cocoapods/l/StepperView.svg?style=flat)](https://cocoapods.org/pods/StepperView)
[![Platform](https://img.shields.io/badge/platform-ios%20%7C%20watchos%20%7C%20macos-orange)](https://cocoapods.org/pods/StepperView)
[![Version](https://img.shields.io/cocoapods/v/StepperView.svg?style=flat)](https://cocoapods.org/pods/StepperView)
[![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-orange)](https://swift.org/package-manager/)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-orange)](https://github.com/Carthage/Carthage)
[![documentation](https://img.shields.io/badge/documentation-100%25-normalgreen)](https://badrinathvm.github.io/StepperView/)
[![Twitter](https://img.shields.io/twitter/url/https/github.com/Juanpe/About-SwiftUI.svg?style=social)](https://twitter.com/intent/tweet?text=SwiftUI%20iOS%20library%20for%20StepIndications%20is%20awesome:&url=https%3A%2F%2Fgithub.com%2Fbadrinathvm%2FStepperView)

<br/>
<p align="center">
<img src="https://raw.githubusercontent.com/badrinathvm/StepperView/master/images/structure.png" alt="StepperView"/>
</p>

<br/>
<p align="center">
<img src="https://raw.githubusercontent.com/badrinathvm/StepperView/master/images/StepperViewLineLifeCycle.png"  alt="StepperViewLineLifeCycle"/>
</p>

# Table of Contents

* [Features](#features)
* [AI-Powered StepperView Generator](#ai-powered-stepperview-generator)
* [Documentation](#documentation)
* [Installation](#installation)
    * [CocoaPods](#cocoapods)
    * [Carthage](#carthage)
    * [Swift Package Manager](#swift-package-manager)
* [Requirements](#requirements)
* [Usecase](#usecase)
    * [iPhone](#iphone)
    * [Apple Watch](#apple-watch-support)
    * [More Examples](#more-examples)
* [Usage](#usage)
* [View Modifiers](#view-modifiers)
* [Custom Step Indicators](#custom-step-indicators)
   * [NumberedCircleView](#numberedcircleview)
   * [CircledIconView](#circlediconview)
* [Mentions](#mentions)
* [Contribution](#contribution)
* [License](#license)

## Features

- Support for Vertical and Horizontal Alignments.
- iOS and WatchOS capabilities
- Support for Circle, Image, Custom View, Animated Step Indicators
- Customizable line,spacing & animation options.
- Pitstop feature to add intermediate stages between Step Indicators
- Support for updating the life cycle status for each of the steps
- **NEW:** AI-Powered StepperView Generator using Apple's on-device Foundation Models (iOS 26+)

## AI-Powered StepperView Generator

Generate fully configured StepperViews from natural language prompts using Apple's on-device Foundation Models framework. Describe what you want in plain English, and the AI generates a complete StepperView with indicators, colors, pit stops, and lifecycle states — all rendered live with copyable Swift code.

<!-- TODO: Replace with actual gif -->
<p align="center">
<img src="https://raw.githubusercontent.com/badrinathvm/StepperView/master/images/ai_stepper_generator.gif" width="300" alt="AI StepperView Generator"/>
</p>

### Highlights

- Describe your stepper in natural language (e.g., *"Create a delivery tracking stepper with 5 stops"*)
- Supports **vertical** and **horizontal** modes
- Choose from **numbered circles**, **plain circles**, or **SF Symbol** indicators
- Use **named colors** or any **hex color** (e.g., `#FF6B35`)
- Optionally add **pit stops** with descriptions
- **Live preview** and **copyable Swift code** in a tabbed interface
- Fully on-device — no network calls, powered by Apple Foundation Models

### Quick Start

```swift
import StepperView

// Add to your SwiftUI view (iOS 26+ only)
if #available(iOS 26.0, *) {
    StepperViewAIGeneratorView()
}
```

### Example Prompts

| Prompt | What it generates |
|--------|-------------------|
| *"Create a 5-step checkout flow"* | Vertical stepper with numbered circles |
| *"Build a horizontal flight booking stepper with sfSymbol indicators"* | Horizontal stepper with SF Symbol icons |
| *"Make a recipe stepper in #E11D48 with details"* | Vertical stepper with hex color and pit stops |
| *"Create a 4-step onboarding flow in purple"* | Vertical stepper with AI-chosen purple hex color |

### Configuration

All AI generation behavior is configurable via `ai_config.yaml` — UI strings, default values, valid colors, SF Symbols allowlist, pit stop keywords, and the system prompt template can all be customized without touching Swift code.

## Documentation
**[StepperView Reference](https://badrinathvm.github.io/StepperView/)**


## Installation

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## CocoaPods

StepperView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile.

```ruby
pod 'StepperView','~> 2.0'
```

## Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks. To integrate StepperView into your Xcode project using Carthage, specify it in your Cartfile:

```ruby
github "badrinathvm/stepperView" == 2.0
```

## Swift Package Manager

StepperView is available through [Swift Package Manager](https://swift.org/package-manager/).

**In Xcode:**
1. Go to `File` > `Add Package Dependencies...`
2. Enter the repository URL: `https://github.com/badrinathvm/StepperView.git`
3. Select version `2.0` or later

**In `Package.swift`:**
```swift
dependencies: [
    .package(url: "https://github.com/badrinathvm/StepperView.git", from: "2.0.0")
]
```

## Requirements
- iOS 13.0+ (AI features require iOS 26.0+)
- watchOS 7.0+
- macOS 10.15+
- Xcode 16+
- Swift 5.9+

## Usecase
<table>
 <tr>
    <td><img src="https://raw.githubusercontent.com/badrinathvm/StepperView/master/images/example1.png" width="250"  alt="example1"  align="center"/></td>
    <td><img src="https://raw.githubusercontent.com/badrinathvm/StepperView/master/images/example2.png" width="250" alt="example2"  align="center"/></td>
    <td><img src="https://raw.githubusercontent.com/badrinathvm/StepperView/master/images/example3.png" width="250" alt="example2"  align="center"/></td>
    <td><img src="https://raw.githubusercontent.com/badrinathvm/StepperView/master/images/Indicator_Animation.gif" width="250" alt="example2"  align="center"/></td>
 </tr>
</table>

<table>
 <tr>
    <td><img src="https://raw.githubusercontent.com/badrinathvm/StepperView/master/images/lifecycle1.png" alt="lifecycle1"  align="center"/></td>
    <td><img src="https://raw.githubusercontent.com/badrinathvm/StepperView/master/images/lifecycle2.png" alt="lifecycle2" align="center"/></td>
    <td><img src="https://raw.githubusercontent.com/badrinathvm/StepperView/master/images/lifecycle3.png" alt="lifecycle3"  align="center"/></td>
    <td><img src="https://raw.githubusercontent.com/badrinathvm/StepperView/master/images/lifecycle4.png" alt="lifecycle3"  align="center"/></td>
 </tr>
</table>

## iPhone

<table>
  <tr>
   <td><img src="https://raw.githubusercontent.com/badrinathvm/StepperView/master/images/stepperView_with_usecases.gif" width="250" alt="StepperView" align="left"/> </td>
   <td><img src="https://raw.githubusercontent.com/badrinathvm/StepperView/master/images/stepperView_pitStops.gif" width="250" alt="StepperViewWithPitStops" align = "center"/> </td>
    <td><img src="https://raw.githubusercontent.com/badrinathvm/StepperView/master/images/stepperView_multiple_options.gif" width="250" alt="StepperViewWithMultipleOptions" align = "center"/> </td>
  </tr>
</table>

## Apple Watch Support

<table>
 <tr>
    <td><img src="https://raw.githubusercontent.com/badrinathvm/StepperView/master/images/Watch_StepperView_1.png" width="250"  alt="Watch_StepperView_Vertical" align="center"/></td>
    <td><img src="https://raw.githubusercontent.com/badrinathvm/StepperView/master/images/Watch_StepperView_2.png" width="250" alt="Watch_StepperView_Icon" align="center"/></td>
    <td><img src="https://raw.githubusercontent.com/badrinathvm/StepperView/master/images/Watch_StepperView_3.png" width="250" alt="Watch_StepperView_Horizontal" align="center"/></td>
   <td><img src="https://raw.githubusercontent.com/badrinathvm/StepperView/master/images/Watch_StepperView_4.png" width="250" alt="Watch_StepperView_Pitstop" align="center"/></td>
 </tr>
</table>

## View Modifiers

```ruby
.addSteps(_ steps: [View]) : 
          1. list of views to be closer to the indicator

.alignments(_ alignments: [StepperAlignment])
          1. optional modifier 
          2. defaults to .center, available with custom options either .top, .center, .bottom
          
.indicatorTypes(_ indicators:[StepperIndicationType]): 
          1. modifier to customize the step indications
          2. provides enum with cases .circle(color, width), .image(Image, width), .custom(AnyView), .animation(AnyView)
          
.lineOptions(_ options: StepperLineOptions): 
          1. line customization `color` , `width` , `corner radius`
          2. Has the option of `defaults`, `custom` , `rounded`
          
.spacing(_ value: CGFloat): 
          1. spacing between each of the step views either vertically or horizontally
          
.autoSpacing(_ value: Bool):
          1. if set to `true` - Dynamically calculates the spacing between each of the steps.
          
.stepIndicatorMode(_ mode: StepperMode): 
          1. Step Indicator display modes either vertical or horizontal
          
.loadingAnimationTime(_ time: Double):
          1. controls the speed of the animation for step Indicator

.stepLifeCycles(_ lifecycle: [StepLifeCycle]):
          1. Can set the life cycle status for each of the steps as `completed`, `pending`
              
.addPitStops(_ steps: [View]):
          1. optional modifier
          2. list of views which will be displayed below the step text

.pitStopLineOptions(_ options: [StepperLineOptions])
          1. line customization `color` , `width` , `corner radius`
          
.stepperEdgeInsets(_ value: EdgeInsets)
         1. Provides custom `leading`, `trailing`, `top` & `bottom` spacing.  
```

## Usage

<p align="center">
    <img src="https://raw.githubusercontent.com/badrinathvm/StepperView/master/images/StepperView_1.png"  height="250"  alt="Vertical Stepper View" align="center"/>
</p>

``` swift
import StepperView

let steps = [ Text("Cart").font(.caption),
              Text("Delivery Address").font(.caption),
              Text("Order Summary").font(.caption),
              Text("Payment Method").font(.caption),
              Text("Track").font(.caption)]

let indicationTypes = [StepperIndicationType.custom(NumberedCircleView(text: "1")),
                        .custom(NumberedCircleView(text: "2")),
                        .custom(NumberedCircleView(text: "3")),
                        .custom(NumberedCircleView(text: "4")),
                        .custom(NumberedCircleView(text: "5"))]
                        
var body: some View {
    StepperView()
        .addSteps(steps)
        .indicators(indicationTypes)
        .stepIndicatorMode(StepperMode.vertical)
        .spacing(30)
        .lineOptions(StepperLineOptions.custom(1, Colors.blue(.teal).rawValue))
}
```
<p align="center">
    <img src="https://raw.githubusercontent.com/badrinathvm/StepperView/master/images/StepperView_2.png"  height="250"  alt="Horizontal Stepper View" align="center"/>
</p>

```swift
import StepperView

let steps = [
    TextView(text: "Card details", font: Font.system(size: 12, weight: Font.Weight.regular)),
    TextView(text: "Application review", font: Font.system(size: 12, weight: Font.Weight.regular)),
    TextView(text: "Authenticate OTP", font: Font.system(size: 12, weight: Font.Weight.regular)),
    TextView(text: "Create password", font: Font.system(size: 12, weight: Font.Weight.regular))
]

let indicators = [
    StepperIndicationType.custom(Image(systemName:"1.circle.fill").font(.largeTitle).eraseToAnyView()),
    StepperIndicationType.custom(Image(systemName:"2.circle.fill").font(.largeTitle).eraseToAnyView()),
    StepperIndicationType.custom(Image(systemName:"3.circle.fill").font(.largeTitle).eraseToAnyView()),
    StepperIndicationType.custom(Image(systemName:"4.circle.fill").font(.largeTitle).eraseToAnyView())
]

var body: some View {
    StepperView()
        .addSteps(steps)
        .indicators(indicators)
        .stepIndicatorMode(StepperMode.horizontal)
        .lineOptions(StepperLineOptions.rounded(4, 8, Color.black)) 
        .stepLifeCycles([StepLifeCycle.completed, .completed, .completed, .pending])
        .spacing(50)
}
```

<p align="center">
    <img src="https://raw.githubusercontent.com/badrinathvm/StepperView/master/images/StepperView_3.png"  height="250"  alt="Pitstop Stepper View" align="center"/>
</p>

```swift

let steps = [TextView(text:"Manage Tasks", font: .system(size: 14, weight: .semibold)),
             TextView(text:"Branch", font: .system(size: 14, weight: .semibold)),
             TextView(text:"Commit", font: .system(size: 14, weight: .semibold)),
             TextView(text:"Code review", font: .system(size: 14, weight: .semibold)),
             TextView(text:"Merge and release", font: .system(size: 14, weight: .semibold))]

let indicators = [
    StepperIndicationType.custom(Image(systemName:"1.circle.fill").font(.largeTitle).eraseToAnyView()),
    StepperIndicationType.custom(Image(systemName:"2.circle.fill").font(.largeTitle).eraseToAnyView()),
    StepperIndicationType.custom(Image(systemName:"3.circle.fill").font(.largeTitle).eraseToAnyView()),
    StepperIndicationType.custom(Image(systemName:"4.circle.fill").font(.largeTitle).eraseToAnyView()),
    StepperIndicationType.custom(Image(systemName:"5.circle.fill").font(.largeTitle).eraseToAnyView())
]

let pitStopLineOptions = [
    StepperLineOptions.custom(1, Color.black),
    StepperLineOptions.custom(1, Color.black),
    StepperLineOptions.custom(1, Color.black),
    StepperLineOptions.custom(1, Color.black),
    StepperLineOptions.custom(1, Color.black)
]

let pitStops = [
    TextView(text:GithubPitstops.p1).eraseToAnyView(),
    TextView(text:GithubPitstops.p2).eraseToAnyView(),
    TextView(text:GithubPitstops.p3).eraseToAnyView(),
    TextView(text:GithubPitstops.p4).eraseToAnyView(),
    TextView(text:GithubPitstops.p5).eraseToAnyView()
]

var body: some View {
    StepperView()
        .addSteps(steps)
        .indicators(indicators)
        .addPitStops(pitStops)
        .pitStopLineOptions(pitStopLineOptions)
        .spacing(80) // auto calculates spacing between steps based on the content.
        .padding()
}

struct GithubPitstops {
    static var p1 = "Triage Notifications\nBrowse Repos\nCreate an issue"
    static var p2 = "Fork or Clone repo\ngit checkout -b branch\ngit stash"
    static var p3 = "git add -p\ngit diff .\ngit commit -m\ngit push origin branch"
    static var p4 = "Open pull request\ngit checkout pr-branch\nReview and comment"
    static var p5 = "View checks\ngit rebase\ngit merge\ngit tag"
}
```


## Custom Step Indicators

## NumberedCircleView
   This view places the number or any text inside the circle.

```swift  
NumberedCircleView(text: "1", width: 40)
```

## CircledIconView
   This view embeds an icon or image inside the circle.
   
```swift  
CircledIconView(image: Image("flag"), width: 40, strokeColor: Color.red)
```

## More Examples
   <a href="https://github.com/badrinathvm/StepperView/tree/master/Example/StepperView">iOS Usecases</a><br>
   <a href="https://github.com/badrinathvm/StepperView/tree/master/Example/StepperView_Watch%20Extension/Views">watchOS Usecases</a>
   
  <table>
  <tr>
   <td><img src="https://raw.githubusercontent.com/badrinathvm/StepperView/master/images/pitstop.png" width="250" alt="StepperView_pistops" align="center"/> </td>
  <td><img src="https://raw.githubusercontent.com/badrinathvm/StepperView/master/images/github_workflow.png" width="300" alt="StepperView_github_workflow" align = "center"/> </td>
   <td><img src="https://raw.githubusercontent.com/badrinathvm/StepperView/master/images/github_workflow_right.png" width="250" alt="StepperView_github_workflow" align = "center"/> </td>
  </tr>
</table>

## Mentions

<a href="http://weekly.swiftwithmajid.com/issues/swiftui-weekly-issue-5-238795">SwiftUI Weekly #5</a><br>
<a href="https://ios-goodies.com/post/617487329928626176/week-333">iOS Goodies #333</a><br>
<a href="https://digest.mbltdev.ru/digests/302">MBLT DEV DIGEST #302</a><br>
<a href="https://ios.libhunt.com/newsletter/201">Awesome iOS Newsletter #201</a><br>
<a href="https://juanpe.github.io/About-SwiftUI/">About-SwiftUI Articles</a><br>
<a href="https://medium.com/better-programming/6-amazing-swiftui-libraries-to-use-in-your-next-project-part-2-df5fb94680bc">Better Programming - 6 Amazing SwiftUI Libraries</a><br>
<a href="https://betterprogramming.pub/10-swiftui-libraries-to-use-in-2021-d21c0384e619">10 SwiftUI Libraries in 2021</a>

## Apps Using StepperView
<a href="https://www.watchto5k.com/">WatchTo5K</a>


## MCP Server (AI Tool Integration)

StepperView ships with a Swift-based [Model Context Protocol](https://modelcontextprotocol.io) server that lets any MCP-compatible AI tool (Claude Desktop, Cursor, VS Code) generate production-ready StepperView code directly in your workflow — no example app required.

### Build

```bash
cd StepperViewMCP
swift build -c release
```

### Tools

| Tool | Description |
|---|---|
| `generate_stepper_code` | Generate a complete SwiftUI `StepperView` struct from structured parameters |
| `list_colors` | List all valid named colors + hex color support |
| `list_sf_symbols` | List the curated SF Symbol allowlist |
| `get_example` | Return copy-paste Swift code for common patterns (`vertical`, `horizontal`, `pit_stops`, `hex_color`, `mixed_lifecycle`) |

### Claude Desktop Integration

Add to `~/Library/Application Support/Claude/claude_desktop_config.json`:

```json
{
  "mcpServers": {
    "stepperview": {
      "command": "/path/to/StepperView/StepperViewMCP/.build/release/StepperViewMCP"
    }
  }
}
```

Then ask Claude: *"Generate a 4-step onboarding stepper in teal with numbered circle indicators"*

---

## Author

Badarinath Venkatnarayansetty.Follow and contact me on <a href="https://twitter.com/badrivm">Twitter</a> or <a href="https://www.linkedin.com/in/badarinath-venkatnarayansetty-abb79146/">LinkedIn</a>

<a href="https://www.buymeacoffee.com/badrinathvm" target="_blank"><img src="https://img.buymeacoffee.com/button-api/?username=badrinathvm&button_colour=FFDD00&font_colour=000000&font_family=Cookie&outline_colour=000000&coffee_colour=FFDD00" alt="Buy Me A Coffee" style="height: 51px !important;width: 200px !important;" ></a>

## Contribution

Feature requests, bug reports, and pull requests are all welcome. Refer <a href="https://github.com/badrinathvm/StepperView/blob/master/CONTRIBUTING.md">Contributing Guidelines</a> for more details.

## License

StepperView is available under the MIT license. See the [LICENSE](https://github.com/badrinathvm/StepperView/blob/master/LICENSE) file for more info.
