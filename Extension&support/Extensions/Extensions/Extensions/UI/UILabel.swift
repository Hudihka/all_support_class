//
//  UILabel.swift
//  GinzaGO
//
//  Created by Username on 19.08.2019.
//  Copyright © 2019 Hudihka. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    func highlight(string: String, color: UIColor) {
        if let text = self.text, let range = text.range(of: string) {
            let attributedString = NSMutableAttributedString(string: text)
            let attributes = [NSAttributedString.Key.foregroundColor: color] as [NSAttributedString.Key: Any]
            attributedString.addAttributes(attributes, range: NSRange(range, in: text))

            attributedText = attributedString
        }
    }

    func getRange(word: String) -> NSRange? { //получить ранг в тексте
        if let text = self.text, let termsRange = text.range(of: word) {
            return NSRange(termsRange, in: text)
        }
        return nil
    }

    func twoColorLabel(location: Int, length: Int, color: UIColor) {
        guard let text = self.text else {
            return
        }

        let myMutableString = NSMutableAttributedString(string: text, attributes: [:])
        let range = NSRange(location: location, length: length)

        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)

        self.attributedText = myMutableString
    }

    //функция изменения ширифта
    func scaleUIFont(scale: CGFloat, label: UILabel) {
        label.minimumScaleFactor = scale
        label.adjustsFontSizeToFitWidth = true
    }

    //количество линий UILAbel
    func lines(label: UILabel) -> Int {
        let textSize = CGSize(width: label.frame.size.width, height: CGFloat(Float.infinity))
        let rHeight = lroundf(Float(label.sizeThatFits(textSize).height))
        let charSize = lroundf(Float(label.font.lineHeight))
        let lineCount = rHeight / charSize
        return lineCount
    }

    private func textWidth(text: String, font: UIFont?) -> CGFloat {
        let attributes = font != nil ? [NSAttributedString.Key.font: font] : [:]
        return text.size(withAttributes: attributes as [NSAttributedString.Key: Any]).width
    }
}



// MARK: - 2 ширифта, более удобная версия
//https://stackoverflow.com/questions/36486761/make-part-of-a-uilabel-bold-in-swift

/* использование
 titleLabel.text = "Welcome"
 titleLabel.font = UIFont.systemFont(ofSize: 70, weight: .bold)
 titleLabel.textColor = UIColor.black
 titleLabel.changeFont(ofText: "lc", with: UIFont.systemFont(ofSize: 60, weight: .light))
 titleLabel.changeTextColor(ofText: "el", with: UIColor.blue)
 titleLabel.changeTextColor(ofText: "co", with: UIColor.red)
 titleLabel.changeTextColor(ofText: "m", with: UIColor.green)
 */

public protocol ChangableFont: AnyObject {
    var text: String? { get set }
    var attributedText: NSAttributedString? { get set }
    var rangedAttributes: [RangedAttributes] { get }
    func getFont() -> UIFont?
    func changeFont(ofText text: String, with font: UIFont)
    func changeFont(inRange range: NSRange, with font: UIFont)
    func changeTextColor(ofText text: String, with color: UIColor)
    func changeTextColor(inRange range: NSRange, with color: UIColor)
    func resetFontChanges()
}

public struct RangedAttributes {
    let attributes: [NSAttributedString.Key: Any]
    let range: NSRange

    public init(_ attributes: [NSAttributedString.Key: Any], inRange range: NSRange) {
        self.attributes = attributes
        self.range = range
    }
}

extension UILabel: ChangableFont {
    public func getFont() -> UIFont? {
        return font
    }
}

extension UITextField: ChangableFont {
    public func getFont() -> UIFont? {
        return font
    }
}

public extension ChangableFont {
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
            guard range != fullRange, !attributes.isEmpty else { return }
            rangedAttributes.append(RangedAttributes(attributes, inRange: range))
        }
        return rangedAttributes
    }

    func changeFont(ofText text: String, with font: UIFont) {
        guard let range = (self.attributedText?.string ?? self.text)?.range(ofText: text) else { return }
        changeFont(inRange: range, with: font)
    }

    func changeFont(inRange range: NSRange, with font: UIFont) {
        add(attributes: [.font: font], inRange: range)
    }

    func changeTextColor(ofText text: String, with color: UIColor) {
        guard let range = (self.attributedText?.string ?? self.text)?.range(ofText: text) else { return }
        changeTextColor(inRange: range, with: color)
    }

    func changeTextColor(inRange range: NSRange, with color: UIColor) {
        add(attributes: [.foregroundColor: color], inRange: range)
    }

    private func add(attributes: [NSAttributedString.Key: Any], inRange range: NSRange) {
        guard !attributes.isEmpty else { return }

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
        guard let text = text else { return }
        attributedText = NSMutableAttributedString(string: text)
    }
}

public extension String {
    func range(ofText text: String) -> NSRange {
        let fullText = self
        let range = (fullText as NSString).range(of: text)
        return range
    }
}
