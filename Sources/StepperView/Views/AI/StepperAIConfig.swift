//
//  AIConfig.swift
//  StepperView
//
//  Created on 2/16/26.
//

#if canImport(Yams)

import Foundation
import Yams

// MARK: - YAML Codable Models

struct StepperAIConfigYAML: Codable {
    let ui: UIStringsYAML
    let defaults: DefaultsYAML
    let validColors: [String]
    let validIndicatorTypes: [String]
    let validSFSymbols: [String]
    let pitStopKeywords: [String]
    let systemPrompt: String
}

struct UIStringsYAML: Codable {
    let navigationTitle: String
    let headerText: String
    let placeholder: String
    let generateButton: String
    let generatingButton: String
    let previewTab: String
    let codeTab: String
    let copyButton: String
    let errorPrefix: String
}

struct DefaultsYAML: Codable {
    let defaultStepCount: Int
    let defaultMode: String
    let defaultSpacing: Int
    let indicatorWidthMin: Int
    let indicatorWidthMax: Int
    let indicatorSize: CGFloat
    let pitStopHeightPerStep: CGFloat
    let defaultHeightPerStep: CGFloat
    let horizontalHeight: CGFloat
}

// MARK: - StepperAIConfig (Public Interface)

struct StepperAIConfig {

    private static let yaml: StepperAIConfigYAML = {
        guard let url = resourceBundle.url(forResource: "ai_config", withExtension: "yaml"),
              let data = try? Data(contentsOf: url),
              let yamlString = String(data: data, encoding: .utf8),
              let config = try? YAMLDecoder().decode(StepperAIConfigYAML.self, from: yamlString)
        else {
            fatalError("Failed to load ai_config.yaml from bundle resources.")
        }
        return config
    }()

    /// Resolves the correct resource bundle for both SPM (`Bundle.module`) and CocoaPods (`resource_bundles`).
    private static let resourceBundle: Bundle = {
        #if SWIFT_PACKAGE
        return Bundle.module
        #else
        // CocoaPods: resource_bundles creates a "StepperView.bundle" inside the framework bundle.
        let frameworkBundle = Bundle(for: BundleToken.self)
        guard let url = frameworkBundle.url(forResource: "StepperView", withExtension: "bundle"),
              let bundle = Bundle(url: url)
        else {
            return frameworkBundle
        }
        return bundle
        #endif
    }()

    // MARK: - System Prompt

    static var systemPrompt: String {
        yaml.systemPrompt
            .replacingOccurrences(of: "{defaultStepCount}", with: "\(yaml.defaults.defaultStepCount)")
            .replacingOccurrences(of: "{defaultMode}", with: yaml.defaults.defaultMode)
            .replacingOccurrences(of: "{defaultSpacing}", with: "\(yaml.defaults.defaultSpacing)")
            .replacingOccurrences(of: "{validColors}", with: yaml.validColors.joined(separator: ", "))
            .replacingOccurrences(of: "{validIndicatorTypes}", with: yaml.validIndicatorTypes.joined(separator: ", "))
            .replacingOccurrences(of: "{validSFSymbols}", with: yaml.validSFSymbols.joined(separator: ", "))
            .replacingOccurrences(of: "{indicatorWidthMin}", with: "\(yaml.defaults.indicatorWidthMin)")
            .replacingOccurrences(of: "{indicatorWidthMax}", with: "\(yaml.defaults.indicatorWidthMax)")
    }

    // MARK: - UI Strings

    struct UIStrings {
        static var navigationTitle: String { yaml.ui.navigationTitle }
        static var headerText: String { yaml.ui.headerText }
        static var placeholder: String { yaml.ui.placeholder }
        static var generateButton: String { yaml.ui.generateButton }
        static var generatingButton: String { yaml.ui.generatingButton }
        static var previewTab: String { yaml.ui.previewTab }
        static var codeTab: String { yaml.ui.codeTab }
        static var copyButton: String { yaml.ui.copyButton }
        static var errorPrefix: String { yaml.ui.errorPrefix }
    }

    // MARK: - Defaults

    static var defaults: DefaultsYAML { yaml.defaults }

    // MARK: - Valid Values

    static var validColors: [String] { yaml.validColors }
    static var validIndicatorTypes: [String] { yaml.validIndicatorTypes }
    static var validSFSymbols: [String] { yaml.validSFSymbols }
    static var pitStopKeywords: [String] { yaml.pitStopKeywords }
}

#if !SWIFT_PACKAGE
/// Anchor class for CocoaPods bundle lookup.
private class BundleToken {}
#endif

#endif // canImport(Yams)
