# StepperView

[![CI Status](https://img.shields.io/travis/badrinathvm/StepperView.svg?style=flat)](https://travis-ci.org/badrinathvm/StepperView)
[![Version](https://img.shields.io/cocoapods/v/StepperView.svg?style=flat)](https://cocoapods.org/pods/StepperView)
[![License](https://img.shields.io/cocoapods/l/StepperView.svg?style=flat)](https://cocoapods.org/pods/StepperView)
[![Platform](https://img.shields.io/cocoapods/p/StepperView.svg?style=flat)](https://cocoapods.org/pods/StepperView)

<p align="center">
    <img src="https://raw.githubusercontent.com/badrinathvm/StepperView/master/images/stepperView.gif" width="290" alt="StepperView"/>
</p>

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
var body: some View {
  StepperView(cells: <List of all Views>, alignments: <alignment for the views>,verticalSpacing: 10.0)
}
```
## Parameters
- cells : Array of Views to be rendered
- alignments: View to be pointed to either .top, .center or .bottom
- verticalSpacing: option for custom spacing to place views

<p>
    <a href="https://github.com/badrinathvm/StepperView/blob/master/Example/StepperView/StepDesignerView.swift">Refer StepperView Example for More details usage of StepperView Parameters</a>
</p>

## Author

Badarinath Venkatnarayansetty

## License

StepperView is available under the MIT license. See the LICENSE file for more info.


