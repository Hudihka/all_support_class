//
//  UIButton.swift
//  GinzaGO
//
//  Created by Username on 19.08.2019.
//  Copyright © 2019 ITMegastar. All rights reserved.
//

import Foundation

// MARK: - Button

extension UIButton {
    func grayButton(_ text: String) {
        self.backgroundColor = SupportClass.Colors.imageCirkle

        self.setTitleColor(SupportClass.Colors.cellText, for: .normal)

        self.setTitle(text, for: .normal)
        self.setTitle(text, for: .highlighted)

        self.addRadius(number: 8)
    }

    func underline() { //подчеркнутый текст на кнопке
        guard let text = self.titleLabel?.text else {
            return
        }

        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle,
                                      value: NSUnderlineStyle.single.rawValue,
                                      range: NSRange(location: 0, length: text.count))

        self.setAttributedTitle(attributedString, for: .normal)
    }
}
