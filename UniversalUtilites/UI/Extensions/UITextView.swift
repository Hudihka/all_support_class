//
//  UITextView.swift
//  UniversalUtilites
//
//  Created by Худышка К on 01.06.2024.
//

import Foundation
import UIKit

public extension UITextView {
    var numberOfLines: Int {
        guard compare(beginningOfDocument, to: endOfDocument).same == false else {
            return 0
        }

        let direction: UITextDirection = UITextDirection(rawValue: UITextStorageDirection.forward.rawValue)
        var lineBeginning = beginningOfDocument
        var lines = 0
        while true {
            lines += 1
            guard let lineEnd = tokenizer.position(from: lineBeginning, toBoundary: .line, inDirection: direction) else {
                fatalError()
            }
            guard compare(lineEnd, to: endOfDocument).same == false else {
                break
            }
            guard let newLineBeginning = tokenizer.position(from: lineEnd, toBoundary: .character, inDirection: direction) else {
                fatalError()
            }
            guard compare(newLineBeginning, to: endOfDocument).same == false else {
                return lines + 1
            }
            lineBeginning = newLineBeginning
        }
        return lines
    }
    
    @discardableResult
    func font(_ font: UIFont?) -> Self {
        guard let font else {
            return self
        }
        
        self.font = font
        
        return self
    }
    
    @discardableResult
    func setScrollEnabled(_ scrollEnabled: Bool) -> Self {
        self.isScrollEnabled = scrollEnabled
        
        return self
    }
    
    @discardableResult
    func setAutocorrectionType(_ autocorrectionType: UITextAutocorrectionType) -> Self {
        self.autocorrectionType = autocorrectionType
        
        return self
    }
    
    @discardableResult
    func setKeyboardType(_ keyboardType: UIKeyboardType) -> Self {
        self.keyboardType = keyboardType
        
        return self
    }
    
    @discardableResult
    func setText(_ text: String?) -> Self {
        self.text = text
        
        return self
    }
    
    @discardableResult
    func setTextColor(_ color: UIColor) -> Self {
        self.textColor = color
        
        return self
    }
    
    @discardableResult
    func setDelegate(_ delegate: UITextViewDelegate) -> Self {
        self.delegate = delegate
        
        return self
    }
}

private extension ComparisonResult {
    var ascending: Bool {
        switch self {
        case .orderedAscending:
            return true

        default:
            return false
        }
    }

    var descending: Bool {
        switch self {
        case .orderedDescending:
            return true

        default:
            return false
        }
    }

    var same: Bool {
        switch self {
        case .orderedSame:
            return true

        default:
            return false
        }
    }
}

