//
//  AIGeneratorView.swift
//  StepperView_Example
//
//  Created on 2/15/26.
//

import SwiftUI
import StepperView

#if canImport(FoundationModels)
import FoundationModels

@available(iOS 26.0, *)
struct AIGeneratorView: View {
    @State private var promptText: String = ""
    @State private var isLoading: Bool = false
    @State private var generatedConfig: GeneratedStepperConfig?
    @State private var errorMessage: String?

    private let systemPrompt = """
    You are a StepperView configuration generator. Given a user's description, produce a structured \
    stepper configuration. Follow these rules:
    - Generate exactly 5 steps unless the user specifies a different number.
    - Default to vertical mode with spacing 50.
    - Use valid color names: teal, red, green, blue, orange, lavender, cyan.
    - Use indicatorType values: numberedCircle, circle, or sfSymbol.
    - When using sfSymbol, you MUST only use SF Symbol names from this list: \
    checkmark.circle.fill, xmark.circle.fill, star.fill, heart.fill, bell.fill, \
    flag.fill, bookmark.fill, tag.fill, bolt.fill, cart.fill, \
    house.fill, gear, person.fill, envelope.fill, phone.fill, \
    mappin.circle.fill, location.fill, clock.fill, calendar, alarm.fill, \
    shippingbox.fill, cube.fill, gift.fill, creditcard.fill, banknote.fill, \
    doc.text.fill, folder.fill, tray.fill, archivebox.fill, paperplane.fill, \
    leaf.fill, drop.fill, flame.fill, snowflake, sun.max.fill, \
    moon.fill, cloud.fill, wrench.fill, hammer.fill, paintbrush.fill, \
    scissors, lock.fill, key.fill, wifi, antenna.radiowaves.left.and.right, \
    airplane, car.fill, bus.fill, bicycle, figure.walk. \
    Do NOT invent or guess symbol names outside this list.
    - Set indicatorWidth between 30 and 40.
    - Mark earlier steps as completed and later steps as pending to show progress.
    - Include pitStopText when the user's prompt implies descriptive content for each step.
    - Keep step titles concise (2-4 words).
    - Set autoSpacing to true when pitStopText is provided, false otherwise.
    """

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Describe your stepper")
                        .font(.headline)
                        .padding(.top)

                    TextField("e.g., Create a delivery tracking stepper with 5 stops",
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
                            Text(isLoading ? "Generating..." : "Generate StepperView")
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

                        StepperAIBuilder.buildStepperView(from: config)
                            .padding(.leading, 20)
                    }
                }
                .padding(.horizontal)
            }
            .navigationTitle("AI Stepper")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private func generateStepper() {
        let prompt = promptText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !prompt.isEmpty else { return }

        isLoading = true
        errorMessage = nil
        generatedConfig = nil

        Task {
            do {
                let session = LanguageModelSession(instructions: systemPrompt)
                let response = try await session.respond(to: prompt, generating: GeneratedStepperConfig.self)
                await MainActor.run {
                    generatedConfig = response.content
                    isLoading = false
                }
            } catch {
                await MainActor.run {
                    errorMessage = "Generation failed: \(error.localizedDescription)"
                    isLoading = false
                }
            }
        }
    }
}

#endif
