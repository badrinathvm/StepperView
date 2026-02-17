//
//  StepperAIModels.swift
//  StepperView_Example
//
//  Created on 2/15/26.
//

import Foundation
#if canImport(FoundationModels)
import FoundationModels

@available(iOS 26.0, *)
@Generable
public struct GeneratedStepperConfig: Codable {
    @Guide(description: "A short descriptive title for the stepper, e.g. 'Delivery Tracking'")
    public var title: String

    @Guide(description: "Layout mode: 'vertical' or 'horizontal'")
    public var mode: String

    @Guide(description: "Spacing between steps, typically 30–80")
    public var spacing: Double

    @Guide(description: "Whether to auto-calculate spacing based on content height")
    public var autoSpacing: Bool

    @Guide(description: "The list of steps in the stepper")
    public var steps: [GeneratedStep]
}

@available(iOS 26.0, *)
@Generable
public struct GeneratedStep: Codable {
    @Guide(description: "1-based sequential step number")
    var stepNumber: Int

    @Guide(description: "Concise label for the step, 2-4 words")
    var title: String

    @Guide(description: "Indicator style: 'numberedCircle', 'circle', or 'sfSymbol'")
    var indicatorType: String

    @Guide(description: "SF Symbol name when indicatorType is 'sfSymbol', e.g. 'checkmark.circle.fill'")
    var sfSymbolName: String?

    @Guide(description: "Color name from: 'teal', 'red', 'green', 'blue', 'orange', 'lavender', 'cyan'")
    var color: String

    @Guide(description: "Width of the indicator circle, typically 30-40")
    var indicatorWidth: Double

    @Guide(description: "Step lifecycle status: 'completed' or 'pending'")
    var lifeCycle: String

    @Guide(description: "Optional descriptive text content for pit stop display")
    var pitStopText: String?
}

#endif
