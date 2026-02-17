//
//  AIGeneratorView.swift
//  StepperView_Example
//
//  Created on 2/15/26.
//

import SwiftUI

#if canImport(FoundationModels)
import FoundationModels

@available(iOS 26.0, *)
public struct StepperViewAIGeneratorView: View {
    @State private var promptText: String = ""
    @State private var isLoading: Bool = false
    @State private var generatedConfig: GeneratedStepperConfig?
    @State private var errorMessage: String?
    @State private var selectedTab: Int = 0
    
    public init() {}

    public var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .leading, spacing: 16) {
                    Text(StepperAIConfig.UIStrings.headerText)
                        .font(.headline)
                        .padding(.top)

                    TextField(StepperAIConfig.UIStrings.placeholder,
                              text: $promptText,
                              axis: .vertical)
                        .textFieldStyle(.roundedBorder)
                        .lineLimit(3...6)

                    Button(action: generateStepper) {
                        HStack {
                            if isLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle())
                                    .padding(.trailing, 4)
                            }
                            Text(isLoading ? StepperAIConfig.UIStrings.generatingButton : StepperAIConfig.UIStrings.generateButton)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(promptText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || isLoading
                                    ? Color.gray.opacity(0.3)
                                    : Colors.teal.rawValue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    .disabled(promptText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || isLoading)

                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.caption)
                    }

                    if let config = generatedConfig {
                        Divider()

                        Text(config.title)
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.top, 8)

                        Picker("View", selection: $selectedTab) {
                            Text(StepperAIConfig.UIStrings.previewTab).tag(0)
                            Text(StepperAIConfig.UIStrings.codeTab).tag(1)
                        }
                        .pickerStyle(.segmented)

                        if selectedTab == 0 {
                            let hasPitStops = config.steps.contains { $0.pitStopText != nil && !($0.pitStopText?.isEmpty ?? true) }
                            let stepCount = CGFloat(config.steps.count)
                            let estimatedHeight: CGFloat = hasPitStops
                                ? stepCount * StepperAIConfig.defaults.pitStopHeightPerStep
                                : stepCount * StepperAIConfig.defaults.defaultHeightPerStep

                            if config.mode.lowercased() == "horizontal" {
                                ScrollView(.horizontal, showsIndicators: false) {
                                    StepperAIBuilder.buildStepperView(from: config)
                                        .padding(.all, 40)
                                }
                            } else {
                                StepperAIBuilder.buildStepperView(from: config)
                                    .frame(height: estimatedHeight)
                            }
                        } else {
                            let code = StepperAIBuilder.generateCode(from: config)
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Spacer()
                                    Button(action: {
                                        UIPasteboard.general.string = code
                                    }) {
                                        Label(StepperAIConfig.UIStrings.copyButton, systemImage: "doc.on.doc")
                                            .font(.caption)
                                    }
                                }

                                ScrollView(.horizontal, showsIndicators: true) {
                                    Text(code)
                                        .font(.system(.caption, design: .monospaced))
                                        .textSelection(.enabled)
                                        .padding(12)
                                }
                                .background(Color(.systemGray6))
                                .cornerRadius(8)
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
            .navigationTitle(StepperAIConfig.UIStrings.navigationTitle)
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(.stack)
    }

    private func generateStepper() {
        let prompt = promptText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !prompt.isEmpty else { return }

        isLoading = true
        errorMessage = nil
        generatedConfig = nil

        Task {
            do {
                let session = LanguageModelSession(instructions: StepperAIConfig.systemPrompt)
                let response = try await session.respond(to: prompt, generating: GeneratedStepperConfig.self)
                var config = response.content

                // Enforce uniform indicator type and color across all steps using the first step's values.
                if let firstStep = config.steps.first {
                    let uniformType = firstStep.indicatorType
                    let uniformColor = firstStep.color
                    config.steps = config.steps.map { step in
                        var s = step
                        s.indicatorType = uniformType
                        s.color = uniformColor
                        return s
                    }
                }

                // Strip pit stops unless the user explicitly requested them.
                let lowered = prompt.lowercased()
                let wantsPitStops = StepperAIConfig.pitStopKeywords.contains { lowered.contains($0) }
                if !wantsPitStops {
                    config.steps = config.steps.map { step in
                        var s = step
                        s.pitStopText = nil
                        return s
                    }
                    config.autoSpacing = false
                }

                await MainActor.run {
                    generatedConfig = config
                    isLoading = false
                }
            } catch {
                await MainActor.run {
                    errorMessage = "\(StepperAIConfig.UIStrings.errorPrefix)\(error.localizedDescription)"
                    isLoading = false
                }
            }
        }
    }
}

#endif
