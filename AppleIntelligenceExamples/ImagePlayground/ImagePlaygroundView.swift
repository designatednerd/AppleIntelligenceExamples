//
//  ImagePlaygroundView.swift
//  AppleIntelligenceExamples
//
//  Created by Ellen Shapiro on 3/4/25.
//

import SwiftUI
import ImagePlayground

public struct ImagePlaygroundView: View {
    
    @Environment(\.supportsImagePlayground) var supportsImagePlayground

    @State private var imagePlaygroundIsPresented: Bool = false
    @State private var text: String = ""
    
    @State var generatedImageURL: URL?

    private let prompt = "Enter text here..."
    
    public var body: some View {
        VStack {
            Text("What do you want the image playground to generate?")
            TextField("Do it!", text: self.$text, prompt: Text(self.prompt))
                .textFieldStyle(.roundedBorder)

            if self.supportsImagePlayground {
                Button("GENERATE", action: {
                    self.imagePlaygroundIsPresented = true
                })
            } else {
                Text("Image playground not supported here")
                    .foregroundStyle(.red)
            }
            
            if let generatedImageURL {
                AsyncImage(url: generatedImageURL) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                } placeholder: {
                    ProgressView()
                }
            }
            
            Spacer()
        }
        .padding(20)
        .imagePlaygroundSheet(isPresented: self.$imagePlaygroundIsPresented,
                              concept: self.text,
                              onCompletion: { url in
            self.generatedImageURL = url
        })
    }
}

#if DEBUG

#Preview {
    ImagePlaygroundView()
}

#endif
