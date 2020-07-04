# StepperView

#### SwiftUI iOS component for Step Indications

[![CI Status](https://img.shields.io/travis/badrinathvm/StepperView.svg?style=flat)](https://travis-ci.org/badrinathvm/StepperView)
[![License](https://img.shields.io/cocoapods/l/StepperView.svg?style=flat)](https://cocoapods.org/pods/StepperView)
[![Platform](https://img.shields.io/badge/platform-ios-orange)](https://cocoapods.org/pods/StepperView)
[![Version](https://img.shields.io/cocoapods/v/StepperView.svg?style=flat)](https://cocoapods.org/pods/StepperView)
[![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-orange)](https://swift.org/package-manager/)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-orange)](https://github.com/Carthage/Carthage)
[![documentation](https://img.shields.io/badge/documentation-100%25-normalgreen)](https://badrinathvm.github.io/StepperView/)
[![Twitter](https://img.shields.io/twitter/url/https/github.com/Juanpe/About-SwiftUI.svg?style=social)](https://twitter.com/intent/tweet?text=SwiftUI%20iOS%20library%20for%20StepIndications%20is%20awesome:&url=https%3A%2F%2Fgithub.com%2Fbadrinathvm%2FStepperView)

<br/>
<p align="center">
<img src="https://raw.githubusercontent.com/badrinathvm/StepperView/master/images/structure.png" height="450" alt="StepperView"/>
</p>

# Table of Contents

* [Features](#features)
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

## Documentation
**[StepperView Reference](https://badrinathvm.github.io/StepperView/)**


## Installation

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## CocoaPods

StepperView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile.

```ruby
pod 'StepperView','~> 1.5.2'
```

## Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks. To integrate StepperView into your Xcode project using Carthage, specify it in your Cartfile:

```ruby
github "badrinathvm/stepperView" == 1.5.2
```

## Swift Package Manager

StepperView is available through [Swift Package Manager](https://swift.org/package-manager/). To install it, simply add it to the `dependencies` of your `Package.swift`

```ruby
dependencies: [
      .package(url: "https://github.com/badrinathvm/StepperView.git", from: "1.5.2")
]
```

## Requirements
- iOS 13.0+
- Xcode 11.2+
- Swift 5.0+
- CocoaPods 1.6.1+

## Usecase
<table>
 <tr>
    <td><img src="https://raw.githubusercontent.com/badrinathvm/StepperView/master/images/example1.png" width="250"  alt="example1"  align="center"/></td>
    <td><img src="https://raw.githubusercontent.com/badrinathvm/StepperView/master/images/example2.png" width="250" alt="example2"  align="center"/></td>
    <td><img src="https://raw.githubusercontent.com/badrinathvm/StepperView/master/images/example3.png" width="250" alt="example2"  align="center"/></td>
    <td><img src="https://raw.githubusercontent.com/badrinathvm/StepperView/master/images/Indicator_Animation.gif" width="250" alt="example2"  align="center"/></td>
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

## Usage

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
        .stepIndicatorMode(StepperMode.horizontal)
        .spacing(50)
        .lineOptions(StepperLineOptions.custom(1, Colors.blue(.teal).rawValue))
}
```
## View Modifiers

```ruby
.addSteps(_ steps: [View]) : 
          1. list of views to be closer to indicator

.alignments(_ alignments: [StepperAlignment])
          1. optional modifier 
          2. defaults to .center, available with custom options either .top, .center, .bottom
          
.indicatorTypes(_ indicators:[StepperIndicationType]): 
          1. modifier to customize the step indications
          2. provides enum with cases .circle(color, width), .image(Image, width), .custom(AnyView), .animation(AnyView)
          
.lineOptions(_ options: StepperLineOptions): 
          1. line customization `Color` , `width`
          
.spacing(_ value: CGFloat): 
          1. spacing between each of the step views either vertically horizontally
          
.stepIndicatorMode(_ mode: StepperMode): 
          1. Step Indicator display modes either vertical, horizontal
          
.addPitStops(_ steps: [PitStopStep])
          1. optional modifier
          2. `PitStopStep` - structure that provides option to provide `View`, line customizations
          
.loadingAnimationTime(_ time: Double)
          1. controls the speed of the animation for step Indicator
          
.autoSpacing(true)
          1. Dynamcially calclulates the spacing between each of the steps.
```

## Custom Step Indicators

## NumberedCircleView
   This view places the number or any text inside the circle.

```swift  
NumberedCircleView(text: "1", width: 40)
```

## CircledIconView
   This view embeds a icon or image inside the circle.
   
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
<a href="https://medium.com/better-programming/6-amazing-swiftui-libraries-to-use-in-your-next-project-part-2-df5fb94680bc">Better Programming Medium Article</a>


## Author

Badarinath Venkatnarayansetty.Follow and contact me on <a href="https://twitter.com/badrivm">Twitter</a> or <a href="https://www.linkedin.com/in/badarinath-venkatnarayansetty-abb79146/">LinkedIn</a>

<a href="https://www.buymeacoffee.com/badrinathvm" target="_blank"><img src="https://camo.githubusercontent.com/031fc5a134cdca5ae3460822aba371e63f794233/68747470733a2f2f7777772e6275796d6561636f666665652e636f6d2f6173736574732f696d672f637573746f6d5f696d616765732f6f72616e67655f696d672e706e67" alt="Buy Me A Coffee" style="height: 51px !important;width: 200px !important;" ></a>

## Contribution

Feature requests, bug reports, and pull requests are all welcome. Refer <a href="https://github.com/badrinathvm/StepperView/blob/master/CONTRIBUTING.md">Contributing Guidelines</a> for more details.

## License

StepperView is available under the MIT license. See the [LICENSE](https://github.com/badrinathvm/StepperView/blob/master/LICENSE) file for more info.
