//
//  LanguageFetcher.swift
//  AppleIntelligenceExamples
//
//  Created by Ellen Shapiro on 3/11/25.
//

import Observation
import Translation

extension Locale.Language: @retroactive Identifiable {
    public var id: String { self.minimalIdentifier }
    
    var localizedDescription: String {
        Locale.current.localizedString(forIdentifier: self.minimalIdentifier) ?? self.minimalIdentifier
    }
}

extension LanguageAvailability.Status: @retroactive Identifiable {
    public var description: String {
        switch self {
        case .supported:
            return "Supported"
        case .unsupported:
            return "Unsupported"
        case .installed:
            return "Installed"
        @unknown default:
            fatalError()
        }
    }
    
    public var id: String { description }
}

struct LanguagePair: Identifiable {
    var id: String { self.language.minimalIdentifier }
    
    let language: Locale.Language
    let status: LanguageAvailability.Status
}

@Observable
class LanguageFetcher {
    
    static let shared = LanguageFetcher()
    
    var availableLanguages: [LanguagePair] = []
    
    private let languageAvailability = LanguageAvailability()
    let usEnglish = Locale(languageComponents: Locale.Language.Components(identifier: "en_US"))
    
    func getAvailableLanguages() async {
        let availableLanguages = await self.languageAvailability.supportedLanguages
        
        for language in availableLanguages
                {
            let status = await self.languageAvailability.status(from: language, to: self.usEnglish.language)
            self.availableLanguages.append(LanguagePair(language: language, status: status))
        }
    }
}
