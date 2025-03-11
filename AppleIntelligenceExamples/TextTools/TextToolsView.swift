//
//  TextToolsView.swift
//  AppleIntelligenceExamples
//
//  Created by Ellen Shapiro on 3/4/25.
//

import SwiftUI
import Foundation

public struct TextToolsView: View {
    
    @State private var content = NSAttributedString("")
    
    public var body: some View {
        Text("Text Tools View")
        VStack {
            NavigationLink("Text Kit 1") {
                TK1TextViewWrapper()
                    .border(Color.blue, width: 4)
                    .navigationTitle("Text Kit 1")
            }
            
            NavigationLink("Text Kit 2") {
                TK2TextViewWrapper(didChangeClosure: { updatedString in
                    self.content = updatedString
                    })
                    .border(Color.green, width: 4)
                    .toolbar() {
                        ToolbarItem(placement: .primaryAction) {
                            Button("Save") {
                                self.saveContentsAsHTML()
                            }
                        }
                    }
                    .navigationTitle("Text Kit 2")
            }
        }
    }
    
    func saveContentsAsRTFD() {
        do {
            let rtfFileWrapper = try self.content.fileWrapper(from: NSRange(location: 0, length: self.content.length), documentAttributes: [
                .documentType: NSAttributedString.DocumentType.rtfd,
                .characterEncoding: String.Encoding.utf8
            ])
            
            
            let fileURL = URL(filePath: "test.rtfd", directoryHint: .inferFromPath, relativeTo: .documentsDirectory)
            
            if FileManager.default.fileExists(atPath: fileURL.path) {
                try FileManager.default.removeItem(at: fileURL)
            }
            
            try rtfFileWrapper.write(to: fileURL, originalContentsURL: nil)
            
            
            print("Dir contents: \(try FileManager.default.contentsOfDirectory(at: fileURL, includingPropertiesForKeys: nil))")
            
        } catch {
            print("Error saving contents as RTFD: \(error.localizedDescription)")
        }
    }
    
    
    func saveContentsAsHTML() {
        do {
            let htmlFileWrapper = try self.content.fileWrapper(from: NSRange(location: 0, length: self.content.length), documentAttributes: [
                .documentType: NSAttributedString.DocumentType.html,
            ])
            
            let fileURL = URL(filePath: "test.html", directoryHint: .inferFromPath, relativeTo: .documentsDirectory)

            if FileManager.default.fileExists(atPath: fileURL.path) {
                try FileManager.default.removeItem(at: fileURL)
            }
            
            try htmlFileWrapper.write(to: fileURL, originalContentsURL: nil)
            
            print("Dir contents: \(try FileManager.default.contentsOfDirectory(at: fileURL, includingPropertiesForKeys: nil))")
        } catch {
            print("Error saving contents as HTML: \(error.localizedDescription)")
        }
    }
    
}

#if DEBUG
#Preview {
    TextToolsView()
}
#endif
