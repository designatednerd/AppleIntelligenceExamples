//
//  ContentView.swift
//  AppleIntelligenceExamples
//
//  Created by Ellen Shapiro on 3/4/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                NavigationLink() {
                    ImagePlaygroundView()
                } label: {
                    Text("Image Playground")
                        .bold()
                        .padding()
                        .foregroundStyle(.white)
                        .background(RoundedRectangle(cornerRadius: 10)
                            .fill(.blue))
                }

                NavigationLink() {
                    GenmojiView()
                } label: {
                   Text("Genmoji")
                        .bold()
                        .padding()
                        .foregroundStyle(.white)
                        .background(RoundedRectangle(cornerRadius: 10)
                            .fill(.green))

                }
                NavigationLink {
                    TextToolsView()
                } label: {
                    Text("Text Tools")
                        .bold()
                        .padding()
                        .foregroundStyle(.white)
                        .background(RoundedRectangle(cornerRadius: 10)
                            .fill(.red))

                }
                NavigationLink {
                    TranslationView()
                } label: {
                    Text("Translation")
                        .bold()
                        .padding()
                        .foregroundStyle(.white)
                        .background(RoundedRectangle(cornerRadius: 10)
                            .fill(.purple))
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
