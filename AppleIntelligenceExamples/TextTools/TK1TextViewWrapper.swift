//
//  TK1TextView.swift
//  AppleIntelligenceExamples
//
//  Created by Ellen Shapiro on 3/4/25.
//

import Foundation
import SwiftUI
import UIKit

struct TK1TextViewWrapper: UIViewRepresentable {
    typealias UIViewType = TK1TextView

    func makeUIView(context: Context) -> TK1TextView {
        TK1TextView()
    }
    
    func updateUIView(_ uiView: TK1TextView, context: Context) {
        
    }
}

class TK1TextView: UITextView {
    
    let tk1Delegate = TK1Delegate()
    
    init() {
        super.init(frame: .zero, textContainer: nil)
        self.layoutManager.delegate = self.tk1Delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class TK1Delegate: NSObject, NSLayoutManagerDelegate {

    func layoutManagerDidInvalidateLayout(_ sender: NSLayoutManager) {
        print("TK1 Manager invalidated layout")
    }
}
