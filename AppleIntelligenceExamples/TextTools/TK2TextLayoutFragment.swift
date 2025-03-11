//
//  TK2TextLayoutFragment.swift
//  AppleIntelligenceExamples
//
//  Created by Ellen Shapiro on 3/4/25.
//

import Foundation
import UIKit

class TK2TextLayoutFragment: NSTextLayoutFragment {
    
    let papyrusMode: Bool
    
    init(textElement: NSTextElement,
         range: NSTextRange?,
         papyrusMode: Bool) {
        self.papyrusMode = papyrusMode
        super.init(textElement: textElement, range: range)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func draw(at point: CGPoint, in context: CGContext) {
        if self.papyrusMode {
            context.saveGState()
            
            let strokeFrame = self.layoutFragmentFrame
                .insetBy(dx: -4, dy: 0)
                .offsetBy(dx: -4, dy: 0)
            
            context.setStrokeColor(UIColor.red.cgColor)
            context.stroke(strokeFrame, width: 2)
            
            context.restoreGState()
            
            super.draw(at: point, in: context)
        } else {
            super.draw(at: point, in: context)
        }
    }
    
    
    
    
    
    
}
