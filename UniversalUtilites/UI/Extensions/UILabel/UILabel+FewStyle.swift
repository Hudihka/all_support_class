//
//  UILabel+FewStyle.swift
//  UniversalUtilites
//
//  Created by Худышка К on 25.05.2024.
//

import Foundation
import UIKit

// MARK: - несколько ширифтов, более удобная версия
//https://stackoverflow.com/questions/36486761/make-part-of-a-uilabel-bold-in-swift
/*
 titleLabel.text = "Welcome"
 titleLabel.font = UIFont.systemFont(ofSize: 70, weight: .bold)
 
 titleLabel.textColor = UIColor.black
 titleLabel.changeFont(ofText: "lc", with: UIFont.systemFont(ofSize: 60, weight: .light))
 titleLabel.changeTextColor(ofText: "el", with: UIColor.blue)
 titleLabel.changeTextColor(ofText: "co", with: UIColor.red)
 titleLabel.changeTextColor(ofText: "m", with: UIColor.green)
 */

private protocol ChangableFont: AnyObject {
    var text: String? { get set }
    var attributedText: NSAttributedString? { get set }
    var rangedAttributes: [RangedAttributes] { get }
    var getFont: UIFont? { get set }
    func resetFontChanges()
    
    @discardableResult
    func changePartFont(ofText text: String?, with font: UIFont?) -> Self
    @discardableResult
    func changePartFont(inRange range: NSRange?, with font: UIFont?) -> Self
    @discardableResult
    func changePartTextColor(ofText text: String?, with color: UIColor?) -> Self
    @discardableResult
    func changePartTextColor(inRange range: NSRange?, with color: UIColor?) -> Self
}

private struct RangedAttributes {
    let attributes: [NSAttributedString.Key: Any]
    let range: NSRange

    public init(_ attributes: [NSAttributedString.Key: Any], inRange range: NSRange) {
        self.attributes = attributes
        self.range = range
    }
}

extension UILabel: ChangableFont {
    var getFont: UIFont? {
        get {
            font
        }
        set {
            self.font = newValue
        }
    }
    
    @discardableResult
    func changePartFont(ofText text: String?, with font: UIFont?) -> Self {
        guard let text, let font else {
            return self
        }
        
        self.changeFont(ofText: text, with: font)
        
        return self
    }
    
    @discardableResult
    func changePartFont(inRange range: NSRange?, with font: UIFont?) -> Self {
        guard let range, let font else {
            return self
        }
        
        self.changeFont(inRange: range, with: font)
        
        return self
    }
    
    @discardableResult
    func changePartTextColor(ofText text: String?, with color: UIColor?) -> Self {
        guard let text, let color else {
            return self
        }
        
        self.changeTextColor(ofText: text, with: color)
        
        return self
    }
    
    @discardableResult
    func changePartTextColor(inRange range: NSRange?, with color: UIColor?) -> Self {
        guard let range, let color else {
            return self
        }
        
        self.changeTextColor(inRange: range, with: color)
        
        return self
    }

}

private extension ChangableFont {
    var rangedAttributes: [RangedAttributes] {
        guard let attributedText = attributedText else {
            return []
        }
        var rangedAttributes: [RangedAttributes] = []
        let fullRange = NSRange(
            location: 0,
            length: attributedText.string.count
        )
        attributedText.enumerateAttributes(
            in: fullRange,
            options: []
        ) { (attributes, range, _) in
            guard
                range != fullRange,
                !attributes.isEmpty
            else {
                return
            }
            rangedAttributes.append(RangedAttributes(attributes, inRange: range))
        }
        return rangedAttributes
    }

    func changeFont(ofText text: String, with font: UIFont) {
        guard
            let range = (self.attributedText?.string ?? self.text)?.range(ofText: text)
        else {
            return
        }
        changeFont(inRange: range, with: font)
    }

    func changeFont(inRange range: NSRange, with font: UIFont) {
        add(attributes: [.font: font], inRange: range)
    }

    func changeTextColor(ofText text: String, with color: UIColor) {
        guard
            let range = (self.attributedText?.string ?? self.text)?.range(ofText: text)
        else {
            return
        }
        changeTextColor(inRange: range, with: color)
    }

    func changeTextColor(inRange range: NSRange, with color: UIColor) {
        add(attributes: [.foregroundColor: color], inRange: range)
    }

    func add(attributes: [NSAttributedString.Key: Any], inRange range: NSRange) {
        guard !attributes.isEmpty else {
            return
        }

        var rangedAttributes: [RangedAttributes] = self.rangedAttributes

        var attributedString: NSMutableAttributedString

        if let attributedText = attributedText {
            attributedString = NSMutableAttributedString(attributedString: attributedText)
        } else if let text = text {
            attributedString = NSMutableAttributedString(string: text)
        } else {
            return
        }

        rangedAttributes.append(RangedAttributes(attributes, inRange: range))

        rangedAttributes.forEach { (rangedAttributes) in
            attributedString.addAttributes(
                rangedAttributes.attributes,
                range: rangedAttributes.range
            )
        }

        attributedText = attributedString
    }

    func resetFontChanges() {
        guard let text = text else {
            return
        }
        attributedText = NSMutableAttributedString(string: text)
    }
}

private extension String {
    func range(ofText text: String) -> NSRange {
        let fullText = self
        let range = (fullText as NSString).range(of: text)
        return range
    }
}
