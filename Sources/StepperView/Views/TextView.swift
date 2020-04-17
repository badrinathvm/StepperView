//
//  TextView.swift
//  StepperView
//
//  Created by Venkatnarayansetty, Badarinath on 4/16/20.
//

import SwiftUI

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public struct TextView: View {
    public var text:String
    public var font:Font
    
    public init(text:String, font:Font = .caption) {
        self.text = text
        self.font = font
    }
    
    public var body: some View {
        Text(text)
            .font(font)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}
