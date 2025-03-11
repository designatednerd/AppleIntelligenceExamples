//
//  TK1TextViewWrapper.swift
//  AppleIntelligenceExamples
//
//  Created by Ellen Shapiro on 3/4/25.
//

import Foundation
import SwiftUI
import UIKit

struct TK2TextViewWrapper: UIViewRepresentable {
    typealias UIViewType = TK2TextView
    
    let textView: TK2TextView

    init (didChangeClosure: @escaping (NSAttributedString) -> Void) {
        self.textView = TK2TextView(didChangeClosure: didChangeClosure)
    }
    
    func makeUIView(context: Context) -> TK2TextView {
        self.textView
    }
    
    func updateUIView(_ uiView: TK2TextView, context: Context) {
    }
}


class TK2TextView: UITextView {
    
    let tk2Delegate: TK2Delegate
        
    init(didChangeClosure: @escaping (NSAttributedString) -> Void) {
        self.tk2Delegate = TK2Delegate(didChangeClosure: didChangeClosure)
        super.init(frame: .zero, textContainer: nil)
        self.supportsAdaptiveImageGlyph = true 
        self.textLayoutManager?.delegate = self.tk2Delegate
        self.delegate = self.tk2Delegate
        
        self.allowedWritingToolsResultOptions = [ .list, .plainText, .richText ]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    } 
}

class TK2Delegate: NSObject {
    
    let didChangeClosure: (NSAttributedString) -> Void
    
    init(didChangeClosure: @escaping (NSAttributedString) -> Void) {
        self.didChangeClosure = didChangeClosure
    }
}

extension TK2Delegate: NSTextLayoutManagerDelegate {
    
    func textLayoutManager(_ textLayoutManager: NSTextLayoutManager,
                           textLayoutFragmentFor location: any NSTextLocation,
                           in textElement: NSTextElement) -> NSTextLayoutFragment {
        
        var papyrusMode = false
        if
            let contentStorage = textLayoutManager.textContentManager as? NSTextContentStorage,
            let contentsAsString = contentStorage.attributedString(for: textElement)?.string,
            contentsAsString.localizedCaseInsensitiveContains("Papyrus") {
                papyrusMode = true
        }
        
        return TK2TextLayoutFragment(textElement: textElement,
                                     range: textElement.elementRange,
                                     papyrusMode: papyrusMode)
    }
}

extension TK2Delegate: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        self.didChangeClosure(textView.attributedText)
    }
}
