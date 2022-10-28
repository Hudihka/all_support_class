//
//  UILabel.swift
//  GinzaGO
//
//  Created by Username on 19.08.2019.
//  Copyright © 2019 ITMegastar. All rights reserved.
//

import Foundation

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

    func oneStuleLabel(color: UIColor, sizeFront: CGFloat) {
        self.textColor = color
        self.font = UIFont(name: ".SFUIText", size: sizeFront)
    }

    func twoStuleLabel(myString: String,
                       oneLenght: Int,
                       tupleSizeFront: (oneSizeFront: CGFloat, twoSizeFront: CGFloat),
                       tupleColor: (oneColor: UIColor, twoColor: UIColor),
                       isSemibold: (one: Bool, two: Bool) = (one: false, two: false)) {
        let oneSizeFront = tupleSizeFront.oneSizeFront
        let twoSizeFront = tupleSizeFront.twoSizeFront

        let oneColor = tupleColor.oneColor
        let twoColor = tupleColor.twoColor

        guard let defaultFront = UIFont(name: ".SFUIText", size: twoSizeFront) else {
            return
        }

        var myMutableString = NSMutableAttributedString()

        let font = UIFont(name: ".SFUIText", size: oneSizeFront) ?? defaultFront

        myMutableString = NSMutableAttributedString(string: myString,
                                                    attributes: [NSAttributedString.Key.font: font])

        let oneValue = isSemibold.one ? UIFont.systemFont(ofSize: twoSizeFront, weight: .semibold) :
            UIFont(name: ".SFUIText", size: oneSizeFront) ?? defaultFront

        let twoValue = isSemibold.two ? UIFont.systemFont(ofSize: twoSizeFront, weight: .semibold) :
            UIFont(name: ".SFUIText", size: oneSizeFront) ?? defaultFront

        myMutableString.addAttribute(NSAttributedString.Key.font,
                                     value: oneValue,
                                     range: NSRange(location: 0, length: oneLenght))

        let twoLenght = myString.count - oneLenght

        myMutableString.addAttribute(NSAttributedString.Key.font,
                                     value: twoValue,
                                     range: NSRange(location: oneLenght, length: twoLenght))

        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor,
                                     value: twoColor,
                                     range: NSRange(location: oneLenght, length: twoLenght))

        self.textColor = oneColor
        self.attributedText = myMutableString
    }

    func settingsFont(number: CGFloat) {
        self.font = UIFont(name: "Helvetica-Regular", size: number)
    }
    func settingsFontSemibold(number: CGFloat) {
        self.font = UIFont(name: "Helvetica-Semibold", size: number)
    }

    func priceAndCrossedOutPrice(myString: String, oneLenght: Int) { //цена и зачеркнутая цена

        let oneColor = SupportClass.Colors.orangeLogo
        let twoColor = UIColor.white

        guard let defaultFront = UIFont(name: ".SFUIText", size: 17) else {
            return
        }

        var myMutableString = NSMutableAttributedString()

        let font = UIFont(name: ".SFUIText", size: 15) ?? defaultFront

        myMutableString = NSMutableAttributedString(string: myString,
                                                    attributes: [NSAttributedString.Key.font: font])

        myMutableString.addAttribute(NSAttributedString.Key.font,
                                     value: UIFont(name: ".SFUIText", size: 15) ?? defaultFront,
                                     range: NSRange(location: 0, length: oneLenght))

        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor,
                                     value: twoColor,
                                     range: NSRange(location: oneLenght, length: myString.count - oneLenght))

        myMutableString.addAttribute(NSAttributedString.Key.strikethroughStyle,
                                     value: NSUnderlineStyle.single.rawValue,
                                     range: NSRange(location: 0, length: oneLenght))

        self.textColor = oneColor
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

//удали после после отмены акции мастер кард

extension UILabel {
    func labelMC(_ enumValue: EnumMC) {
        var font: CGFloat = 15
        if enumValue == .stockCell {
            font = 25
        } else if enumValue == .mcView {
            font = 17
        }

        self.twoStuleLabel(myString: enumValue.rawValue,
                           oneLenght: "Скидка 10%".count,
                           tupleSizeFront: (oneSizeFront: font, twoSizeFront: font),
                           tupleColor: (oneColor: UIColor(red: 247.0 / 255.0, green: 158.0 / 255.0, blue: 27.0 / 255.0, alpha: 1),
                                        twoColor: UIColor.white),
                           isSemibold: (one: true, two: true))
    }
}

enum EnumMC: String, CaseIterable {
    case mcView =    "Скидка 10%\nпо карте Masterсard"
    case infoOrder = "Скидка 10% по карте Masterсard"
    case stockCell = "Скидка 10% по\nкарте Masterсard"
}
