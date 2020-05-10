//
//  TextView.swift
//  StepperView
//
//  Created by Venkatnarayansetty, Badarinath on 4/16/20.
//

import SwiftUI

/// A `View` for hostign text with proper `frame`  `alignment` , `lineLimit` modifiers
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public struct TextView: View {
    /// placeholder for text
    public var text:String
    /// variable to hold font type
    public var font:Font
    
    /// initilzes `text` and  `font`
    public init(text:String, font:Font = .caption) {
        self.text = text
        self.font = font
    }
    
    /// provides the content and behavior of this view.
    public var body: some View {
        Text(text)
            .font(font)
            .frame(maxWidth: .infinity, alignment: .leading)
            .fixedSize(horizontal: false, vertical: true)
            .lineLimit(nil)
            .padding(.leading, Utils.halfSpacing)
    }
}
