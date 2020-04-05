# StepperView

[![CI Status](https://img.shields.io/travis/badrinathvm/StepperView.svg?style=flat)](https://travis-ci.org/badrinathvm/StepperView)
[![Version](https://img.shields.io/cocoapods/v/StepperView.svg?style=flat)](https://cocoapods.org/pods/StepperView)
[![License](https://img.shields.io/cocoapods/l/StepperView.svg?style=flat)](https://cocoapods.org/pods/StepperView)
[![Platform](https://img.shields.io/cocoapods/p/StepperView.svg?style=flat)](https://cocoapods.org/pods/StepperView)

<p align="center">
    <img src="https://raw.githubusercontent.com/badrinathvm/StepperView/master/images/stepperView.gif" width="290" alt="StepperView"/>
</p>

SwiftUI iOS component for Step Indications.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
- iOS 11.0+
- Xcode 10.2+
- Swift 5.0+
- CocoaPods 1.6.1+

## Installation

StepperView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'StepperView'
```
## Usage

```
import StepperView

var body: some View {
  StepperView(cells: <List of Views>, alignments: <alignment for the views>,verticalSpacing: 10.0)
}
```
## Parameters
- cells : Array of Views to be rendered
- alignments: view to be pointed to either .top , .center , .bottom sections.
- verticalSpacing: option for custom spacing to place views
<p>
    <a href="https://github.com/badrinathvm/StepperView/blob/master/Example/StepperView/StepDesignerView.swift">Refer Example for More details usage of StepperView and Parameters</a>
</p>

## Author

Badarinath Venkatnarayansetty

## Contact
Follow and contact me on <a href="https://twitter.com/badrivm">Twitter</a> or <a href="https://www.linkedin.com/in/badarinath-venkatnarayansetty-abb79146/">LinkedIn</a>. If you find an issue, just open a ticket. Pull requests are welcome.

## License

StepperView is available under the MIT license. See the LICENSE file for more info.
