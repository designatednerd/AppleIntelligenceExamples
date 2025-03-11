//
//  LanguageAvailabilityView.swift
//  AppleIntelligenceExamples
//
//  Created by Ellen Shapiro on 3/11/25.
//

import SwiftUI
import Translation



public struct LanguageAvailabilityView: View {
        
    public var body: some View {
        VStack {
            Text("Available Languages:")
                .padding(.bottom, 20)
            if LanguageFetcher.shared.availableLanguages.count == 0 {
                Button {
                    Task {
                        await LanguageFetcher.shared.getAvailableLanguages()
                    }
                } label: {
                    Image(systemName: "translate")
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
                .foregroundStyle(.white)
            } else {
                HStack {
                    Text("Language")
                    Spacer()
                    Text("Status for en_US")
                }
                .bold()
                .padding(.horizontal, 8)
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 1)
                    .padding(.horizontal, 8)
                LazyVStack {
                    ForEach(LanguageFetcher.shared.availableLanguages) { languagePair in
                        HStack() {
                            Text(languagePair.language.localizedDescription)
                            Spacer()
                            Text(languagePair.status.description)
                        }
                        .padding(.horizontal, 8)
                    }
                }
            }
        }
    }
}

#if DEBUG
#Preview {
    LanguageAvailabilityView()
}
#endif
