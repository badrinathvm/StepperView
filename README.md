# StepperView

[![CI Status](https://img.shields.io/travis/badrinathvm/StepperView.svg?style=flat)](https://travis-ci.org/badrinathvm/StepperView)
[![Version](https://img.shields.io/cocoapods/v/StepperView.svg?style=flat)](https://cocoapods.org/pods/StepperView)
[![License](https://img.shields.io/cocoapods/l/StepperView.svg?style=flat)](https://cocoapods.org/pods/StepperView)
[![Platform](https://img.shields.io/cocoapods/p/StepperView.svg?style=flat)](https://cocoapods.org/pods/StepperView)

<img src="https://raw.githubusercontent.com/badrinathvm/StepperView/master/images/stepperView.gif" width="200" alt="StepperView" align="left" hspace= "150"/>
<img src="https://raw.githubusercontent.com/badrinathvm/StepperView/master/images/stepperView_multiple_options.gif" width="200" alt="StepperViewWithMultipleOptions" align = "center"/>

SwiftUI iOS component for Step Indications.

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
pod 'StepperView'
```

## Swift Package Manager

StepperView is available through Swift Package Manager. To install it, simply add the foollowing dependency to your Package.swift

```ruby
.package(url: "https://github.com/badrinathvm/StepperView.git", from: "1.0.6")
```

## Usage

```
import StepperView

let alignments = [StepperAlignment.top,StepperAlignment.center,StepperAlignment.bottom]

let indicatorTypes = [  StepperIndicationType<AnyView>.circle,
                        StepperIndicationType.image(Image(systemName: "arrow.right.circle")),
                        StepperIndicationType.image(Image(systemName: "arrow.uturn.right"))
                    ]

var body: some View {
      StepperView(cells: [cellBody, cellBody , cellBody], alignments: alignments,indicationType:indicatorTypes)
}

var cellBody:some View {
    VStack(alignment: .leading) {
        ForEach(["Top","Center","Bottom"], id:\.self) { value in
            HStack {
                Text(value)
                    .foregroundColor(Color.gray)
                    .padding(.vertical , 10)
                    .padding(.horizontal, 5)
                Spacer()
            }
        }
    }
}
```
## Parameters
- cells : Array of Views to be rendered next to step Indicator 
- alignments: list of view alignments to be pointed for eg: can be  .top , .center , .bottom sections
- indicatorTypes: provides the option to customise the indicator.
- verticalSpacing: custom spacing to place views vertically (optional)

<p>
    <a href="https://github.com/badrinathvm/StepperView/blob/master/Example/StepperView/StepDesignerView.swift">Refer Example for more details on usage of StepperView</a>
</p>

## Author

Badarinath Venkatnarayansetty

## Contact
Follow and contact me on <a href="https://twitter.com/badrivm">Twitter</a> or <a href="https://www.linkedin.com/in/badarinath-venkatnarayansetty-abb79146/">LinkedIn</a>. If you find an issue, just open a ticket. Pull requests are welcome.

## License

StepperView is available under the MIT license. See the LICENSE file for more info.



