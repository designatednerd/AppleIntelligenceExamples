//
//  Genmoji.swift
//  AppleIntelligenceExamples
//
//  Created by Ellen Shapiro on 3/9/25.
//

import Foundation
import SwiftUI

struct GenmojiView: View {
    
    @State var text: NSAttributedString = NSAttributedString(string: "Some starter text")
    
    init() {
        self.openSavedDocument()
    }
    
    var body: some View {
        Text(AttributedString(self.text))
            .onAppear {
                self.openSavedDocument()
            }
            .font(.largeTitle)
    }
    
    func openSavedDocument() {
        do {
            let directoryURL = URL(filePath: "test.rtfd", relativeTo: .documentsDirectory)

            let loadedString = try NSMutableAttributedString(url: directoryURL,
                                                      options: [
                                                        .documentType: NSAttributedString.DocumentType.rtfd,
                                                      ],
                                                      documentAttributes: nil)
            
            guard !loadedString.string.isEmpty else {
                return
            }
            
            let wholeRange = NSRange(location: 0, length: loadedString.length)
            loadedString.addAttributes([.font: UIFont.systemFont(ofSize: 200)], range: wholeRange)
            
            self.text = loadedString
        } catch {
            print("Error opening saved document: \(error)")
        }
    }
}
