//
//  TranslationView.swift
//  AppleIntelligenceExamples
//
//  Created by Ellen Shapiro on 3/4/25.
//

import SwiftUI
import Translation

public struct TranslationView: View {
    
    
    public var body: some View {
        TabView {
            Tab("Availability", systemImage: "list.bullet.clipboard.fill") {
                LanguageAvailabilityView()
            }
            Tab("Translate", systemImage: "translate") {
                TranslateTextView()
            }
        }
    }
}

#if DEBUG
#Preview {
    TranslationView()
}
#endif
