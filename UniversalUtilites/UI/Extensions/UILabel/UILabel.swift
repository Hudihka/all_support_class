//
//  UILabel.swift
//  UniversalUtilites
//
//  Created by Худышка К on 25.05.2024.
//

import Foundation
import UIKit

public extension UILabel {
    // количество линий UILAbel
    var lines: Int {
        let textSize = CGSize(width: self.frame.size.width, height: CGFloat(Float.infinity))
        let rHeight = lroundf(Float(self.sizeThatFits(textSize).height))
        let charSize = lroundf(Float(self.font.lineHeight))
        let lineCount = rHeight / charSize
        return lineCount
    }
    
    // получить ранг в тексте
    func getRange(word: String) -> NSRange? {
        guard
            let text = text,
            let termsRange = text.range(of: word)
        else {
            return nil
        }
        return NSRange(termsRange, in: text)
    }
    
    // MARK: - @discardableResult
    
    @discardableResult
    func setText(_ text: String?) -> Self {
        self.text = text
        
        return self
    }
    
    @discardableResult
    func setTextColor(_ color: UIColor?) -> Self {
        guard let color else {
            return self
        }
        self.textColor = color
        
        return self
    }
    
    @discardableResult
    func setTextFont(_ font: UIFont?) -> Self {
        guard let font else {
            return self
        }
        self.font = font
        
        return self
    }
    
    @discardableResult
    func setNumberLines(_ lines: Int?) -> Self {
        guard
            let lines,
            lines >= 0
        else {
            return self
        }
        self.numberOfLines = lines
        
        return self
    }
    
    @discardableResult
    func setAligment(_ aligment: NSTextAlignment) -> Self {
        self.textAlignment = aligment
        
        return self
    }
}
