# StepperView

#### SwiftUI iOS component for Step Indications

[![CI Status](https://img.shields.io/travis/badrinathvm/StepperView.svg?style=flat)](https://travis-ci.org/badrinathvm/StepperView)
[![Version](https://img.shields.io/cocoapods/v/StepperView.svg?style=flat)](https://cocoapods.org/pods/StepperView)
[![License](https://img.shields.io/cocoapods/l/StepperView.svg?style=flat)](https://cocoapods.org/pods/StepperView)
[![Platform](https://img.shields.io/badge/platform-ios-orange)](https://cocoapods.org/pods/StepperView)
[![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-orange)](https://swift.org/package-manager/)

<br/>
<p align="center">
<img src="https://raw.githubusercontent.com/badrinathvm/StepperView/master/images/structure.png" height="450" alt="StepperView"/>
</p>

<table>
  <tr>
   <td><img src="https://raw.githubusercontent.com/badrinathvm/StepperView/master/images/stepperView_with_usecases.gif" width="250" alt="StepperView" align="left"/> </td>
   <td><img src="https://raw.githubusercontent.com/badrinathvm/StepperView/master/images/stepperView_pitStops.gif" width="250" alt="StepperViewWithPitStops" align = "center"/> </td>
    <td><img src="https://raw.githubusercontent.com/badrinathvm/StepperView/master/images/stepperView_multiple_options.gif" width="250" alt="StepperViewWithMultipleOptions" align = "center"/> </td>
  </tr>
</table>

## Usecase
<table align= "center">
 <tr>
    <td><img src="https://raw.githubusercontent.com/badrinathvm/StepperView/master/images/example1.png" width="250"  alt="example1"  align="center"/></td>
    <td><img src="https://raw.githubusercontent.com/badrinathvm/StepperView/master/images/example2.png" width="250" alt="example2"  align="center"/></td>
    <td><img src="https://raw.githubusercontent.com/badrinathvm/StepperView/master/images/example3.png" width="250" alt="example2"  align="center"/></td>
 </tr>
</table>

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
- iOS 13.0+
- Xcode 11.2+
- Swift 5.0+
- CocoaPods 1.6.1+

## Installation

StepperView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile.

```ruby
pod 'StepperView','~> 1.3.0'
```

## Swift Package Manager

StepperView is available through Swift Package Manager. To install it, simply add the following dependency to your Package.swift

```ruby
.package(url: "https://github.com/badrinathvm/StepperView.git", from: "1.3.0")
```

## Usage

```
import StepperView

let steps = [ Text("Cart").font(.caption),
              Text("Delivery Address").font(.caption),
              Text("Order Summary").font(.caption),
              Text("Payment Method").font(.caption),
              Text("Track").font(.caption)]

let alignments = [StepperAlignment.center,.center,.center, .center, .center]

let indicationTypes = [StepperIndicationType.custom(NumberedCircleView(text: "1")),
                        .custom(NumberedCircleView(text: "2")),
                        .custom(NumberedCircleView(text: "3")),
                        .custom(NumberedCircleView(text: "4")),
                        .custom(NumberedCircleView(text: "5"))]
                        
var body: some View {
     var body: some View {
         StepperView()
            .addSteps(steps)
            .indicators(indicationTypes)
            .stepIndicatorMode(StepperMode.horizontal)
            .spacing(50)
            .lineOptions(StepperLineOptions.custom(1, Colors.blue(.teal).rawValue))
     }
}
```
## Methods ( View Modifiers )

```ruby
.addSteps(_ steps: [View]) : 
          1. list of views to be closer to indicator

.alignments(_ alignments: [StepperAlignment])
          1. optional modifier 
          2. defaults to .center, available with custom options either .top, .center, .bottom
          
.indicatorTypes(_ indicators:[StepperIndicationType]): 
          1. modifier to customize the step indications
          2. provides enum with cases .circle(color, width), .image(Image, width) , .custom(AnyView)
          
.lineOptions(_ options: StepperLineOptions): 
          1. line customization `Color` , `width`
          
.spacing(_ value: CGFloat): 
          1. spacing between each of the step views either vertically horizontally
          
.stepIndicatorMode(_ mode: StepperMode): 
          1. Step Indicator display modes either vertical, horizontal
          
.addPitStops(_ steps: [PitStopStep])
          1. optional modifier
          2. `PitStopStep` - structure that provides option to provide `View`, line customizations
```

<p>
    <a href="https://github.com/badrinathvm/StepperView/tree/master/Example/StepperView">Refer Example for more details on usage of StepperView</a>
</p>

## Author

Badarinath Venkatnarayansetty

## Contact
Follow and contact me on <a href="https://twitter.com/badrivm">Twitter</a> or <a href="https://www.linkedin.com/in/badarinath-venkatnarayansetty-abb79146/">LinkedIn</a>. If you find an issue, just open a ticket. Pull requests are welcome.

## License

StepperView is available under the MIT license. See the LICENSE file for more info.
