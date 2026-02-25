//
//  YAMLLoader.swift
//  StepperViewMCP
//
//  Loads ai_config.yaml from the bundle at startup and exposes typed config
//  values used by all four MCP tools.
//

import Foundation
import Yams

// MARK: - Public config types

struct ConfigDefaults: Sendable {
    let defaultStepCount: Int
    let defaultMode: String
    let defaultSpacing: Int
    let indicatorSize: Double
}

struct AppConfig: Sendable {
    let validColors: [String]
    let validSFSymbols: [String]
    let validIndicatorTypes: [String]
    let pitStopKeywords: [String]
    let defaults: ConfigDefaults
}

// MARK: - Raw YAML Codable models (mirrors StepperAIConfig in the main library)

private struct RawConfig: Codable {
    let defaults: RawDefaults
    let validColors: [String]
    let validIndicatorTypes: [String]
    let validSFSymbols: [String]
    let pitStopKeywords: [String]
}

private struct RawDefaults: Codable {
    let defaultStepCount: Int
    let defaultMode: String
    let defaultSpacing: Int
    let indicatorSize: Double
}

// MARK: - Loader

enum YAMLLoader {
    static func load() -> AppConfig {
        if let url = Bundle.module.url(forResource: "ai_config", withExtension: "yaml"),
           let yamlString = try? String(contentsOf: url, encoding: .utf8),
           let raw = try? YAMLDecoder().decode(RawConfig.self, from: yamlString) {
            return AppConfig(
                validColors: raw.validColors,
                validSFSymbols: raw.validSFSymbols,
                validIndicatorTypes: raw.validIndicatorTypes,
                pitStopKeywords: raw.pitStopKeywords,
                defaults: ConfigDefaults(
                    defaultStepCount: raw.defaults.defaultStepCount,
                    defaultMode: raw.defaults.defaultMode,
                    defaultSpacing: raw.defaults.defaultSpacing,
                    indicatorSize: raw.defaults.indicatorSize
                )
            )
        }

        // Fallback: hardcoded values that mirror ai_config.yaml
        fputs("[StepperViewMCP] Warning: failed to load ai_config.yaml — using built-in defaults.\n", stderr)
        return AppConfig(
            validColors: ["teal", "red", "green", "blue", "orange", "lavender", "cyan", "black", "yellow", "polar"],
            validSFSymbols: [
                "checkmark.circle.fill", "xmark.circle.fill", "star.fill", "heart.fill",
                "bell.fill", "flag.fill", "bookmark.fill", "tag.fill", "bolt.fill", "cart.fill",
                "house.fill", "gear", "person.fill", "envelope.fill", "phone.fill",
                "mappin.circle.fill", "location.fill", "clock.fill", "calendar", "alarm.fill",
                "shippingbox.fill", "cube.fill", "gift.fill", "creditcard.fill", "banknote.fill",
                "doc.text.fill", "folder.fill", "tray.fill", "archivebox.fill", "paperplane.fill",
                "leaf.fill", "drop.fill", "flame.fill", "snowflake", "sun.max.fill",
                "moon.fill", "cloud.fill", "wrench.fill", "hammer.fill", "paintbrush.fill",
                "scissors", "lock.fill", "key.fill", "wifi", "antenna.radiowaves.left.and.right",
                "airplane", "car.fill", "bus.fill", "bicycle", "figure.walk"
            ],
            validIndicatorTypes: ["numberedCircle", "circle", "sfSymbol"],
            pitStopKeywords: ["pit stop", "pit stops", "pitstop", "pitstops", "description", "details", "subtitles"],
            defaults: ConfigDefaults(
                defaultStepCount: 5,
                defaultMode: "vertical",
                defaultSpacing: 50,
                indicatorSize: 40
            )
        )
    }
}
