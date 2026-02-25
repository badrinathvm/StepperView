//
//  YAMLLoader.swift
//  StepperViewMCP
//
//  Provides typed config values used by all four MCP tools.
//  Values are inlined from ai_config.yaml — no resource bundle required,
//  making the binary fully self-contained when distributed via Homebrew.
//

import Foundation

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

// MARK: - Loader

enum YAMLLoader {
    static func load() -> AppConfig {
        AppConfig(
            validColors: [
                "teal", "red", "green", "blue", "orange",
                "lavender", "cyan", "black", "yellow", "polar"
            ],
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
            pitStopKeywords: [
                "pit stop", "pit stops", "pitstop", "pitstops",
                "description", "details", "subtitles"
            ],
            defaults: ConfigDefaults(
                defaultStepCount: 5,
                defaultMode: "vertical",
                defaultSpacing: 50,
                indicatorSize: 40
            )
        )
    }
}
