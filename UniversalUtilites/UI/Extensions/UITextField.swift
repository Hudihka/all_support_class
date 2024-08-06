//
//  UITextField.swift
//  UniversalUtilites
//
//  Created by Худышка К on 26.05.2024.
//

import Foundation
import UIKit

public extension UITextField {
    func resultString(string: String, range: NSRange) -> String {
        let text: NSString = (self.text ?? "") as NSString
        return text.replacingCharacters(in: range, with: string)
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
    func setDelegate(_ delegate: UITextFieldDelegate) -> Self {
        self.delegate = delegate
        
        return self
    }

        @discardableResult
    func setPlaceholder(_ text: String) -> Self {
        self.placeholder = text

        return self
    }

    @discardableResult
    func setPlaceholder(_ text: String, color: UIColor) -> Self {
        self.attributedPlaceholder = NSAttributedString(
            string: text,
            attributes: [NSAttributedString.Key.foregroundColor: color]
        )

        return self
    }

    @discardableResult
    func setTintColor(_ tintColor: UIColor) -> Self {
        self.tintColor = tintColor

        return self
    }

    @discardableResult
    func setBorderStyle(_ borderStyle: UITextField.BorderStyle) -> Self {
        self.borderStyle = borderStyle

        return self
    }

    @discardableResult
    func makeFirstResponder() -> Self {
        self.becomeFirstResponder()

        return self
    }

    @discardableResult
    func endFirstResponder() -> Self {
        self.resignFirstResponder()

        return self
    }
}
