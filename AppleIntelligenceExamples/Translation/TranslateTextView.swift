//
//  TranslateTextView.swift
//  AppleIntelligenceExamples
//
//  Created by Ellen Shapiro on 3/11/25.
//

import SwiftUI
import Translation

struct TranslateTextView: View {
    
    @State private var textToTranslate: String = ""
    @State private var translatedText: String?
    @State private var errorString: String?
    
    @State private var language: Locale.Language?
    
    @State private var configuration: TranslationSession.Configuration?
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Language:")
            Picker("Language", selection: self.$language) {
                ForEach(self.availableLanguages()) { languagePair in
                    Text(languagePair.language.localizedDescription)
                        .tag(languagePair.language)
                }
                .pickerStyle(.wheel)
            } currentValueLabel: {
                Text(self.language?.localizedDescription ?? "(Pick a language)")
            }
            .onChange(of: self.language) { _, _ in
                self.setUpConfiguration()
            }
             
            TextField("English to translate",
                      text: self.$textToTranslate,
                      prompt: Text("Enter your English text here"))
                .textFieldStyle(.roundedBorder)
            
            Button {
                self.translate()
            } label: {
                Text("Translate to \(self.language?.localizedDescription ?? "(Select a language)")")
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10)
                .fill(self.buttonDisabled ?  Color.gray.opacity(0.5) : Color.blue))
            .foregroundStyle(.white)
            .disabled(self.buttonDisabled)
            
            if let translatedText {
                Text("Translation:")
                Text(translatedText)
                    .padding()
                    .border(.black)
                    .padding()
            }
            
            if let errorString {
                Text(errorString)
                    .padding()
                    .border(.red)
            }
        }
        .translationTask(configuration) { session in
            do {
                // Use the session the task provides to translate the text.
                let response = try await session.translate(self.textToTranslate)

                // Update the view with the translated result.
                self.translatedText = response.targetText
                self.errorString = nil
            } catch {
                self.errorString = error.localizedDescription
            }
        }
        .padding()
    }
    
    var buttonDisabled: Bool {
        self.language == nil
    }
    
    func availableLanguages() -> [LanguagePair] {
        LanguageFetcher.shared.availableLanguages
            .filter { $0.status != .unsupported }
            .sorted {
                $0.language.localizedDescription < $1.language.localizedDescription
            }
    }
    
    func setUpConfiguration() {
        // Let the framework automatically determine the language pairing.
        configuration = TranslationSession.Configuration(source: LanguageFetcher.shared.usEnglish.language,
                                                         target: self.language)
    }
    
    func translate() {
        if self.configuration != nil {
            self.configuration?.invalidate()
        } else {
            self.setUpConfiguration()
        }
    }
}

#if DEBUG
#Preview {
    TranslateTextView()
}
#endif
