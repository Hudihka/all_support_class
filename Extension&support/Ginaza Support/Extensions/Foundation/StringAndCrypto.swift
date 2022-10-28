//
//  String.swift
//  GinzaGO
//
//  Created by Username on 19.08.2019.
//  Copyright © 2019 ITMegastar. All rights reserved.
//

import Foundation
import CommonCrypto

func randomString(WithLength len: Int) -> String {
    let letters: NSString = "abcdefABCDEF123456789"

    let randomString: NSMutableString = NSMutableString(capacity: len)

    for _ in 0 ..< len {
        let length = UInt32 (letters.length)
        let rand = arc4random_uniform(length)
        randomString.appendFormat("%C", letters.character(at: Int(rand)))
    }

    return randomString as String
}

extension NSMutableAttributedString {   //делает часть строки другим цветом

    func setColorForText(textForAttribute: String, withColor color: UIColor) {
        let range: NSRange = self.mutableString.range(of: textForAttribute, options: .caseInsensitive)
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
    }

    public func setAsLink(textToFind: String, linkURL: String) -> Bool {
        let foundRange = self.mutableString.range(of: textToFind)
        if foundRange.location != NSNotFound {
            self.addAttribute(.link, value: linkURL, range: foundRange)
            return true
        }
        return false
    }
}

extension String {
    func hmac(algorithm: HMACAlgorithm, key: String) -> String {
        var digest = [UInt8](repeating: 0, count: Int(algorithm.digestLength()))
        CCHmac(CCHmacAlgorithm(algorithm.toCCHmacAlgorithm()), key, key.count, self, self.count, &digest)
        let data = Data(bytes: digest)
        return data.map { String(format: "%02hhx", $0) }.joined()
    }

    subscript (bounds: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start...end])
    }

    subscript (bounds: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start..<end])
    }

    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let attributes = [NSAttributedString.Key.font: font]
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)

        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let attributes = [NSAttributedString.Key.font: font]
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)

        return ceil(boundingBox.width)
    }

    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }

    init?(_ int: Int?) {
        if let nonnil = int {
            self.init(nonnil)
        }
        return nil
    }

    func localized(_ lang: String) -> String {
        if let path = Bundle.main.path(forResource: lang, ofType: "lproj"), let bundle = Bundle(path: path) {
            return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
        }
        return self
    }

    func md5() -> String {
        if let messageData = self.data(using: .utf8) {
            var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))

            _ = digestData.withUnsafeMutableBytes { digestBytes in
                messageData.withUnsafeBytes { messageBytes in
                    CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
                }
            }

            return digestData.map { String(format: "%02hhx", $0) }.joined()
        }
        return self
    }

    func highlighted(string: String, color: UIColor, defaultTextColor: UIColor) -> NSAttributedString {
        let attributes = [NSAttributedString.Key.foregroundColor: defaultTextColor] as [NSAttributedString.Key: Any]
        let attributedString = NSMutableAttributedString(string: self, attributes: attributes)

        guard let range = self.range(of: string) else {
            return attributedString
        }

        let highlightAttributes = [NSAttributedString.Key.foregroundColor: color] as [NSAttributedString.Key: Any]
        attributedString.addAttributes(highlightAttributes, range: NSRange(range, in: self))

        return attributedString
    }

    func getDigits() -> String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }

    func strikeThrough(_ clear: Bool = true) -> NSAttributedString { //делает текст зачеркнутым
        let attributeString = NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle,
                                     value: NSUnderlineStyle.single.rawValue,
                                     range: NSRange(location: 0, length: clear ? attributeString.length : 0))
        return attributeString
        //        используется
        //        label.attributedText = "222222".strikeThrough()
    }

    func separatedPrice() -> String { //выдает цену в более удобном виде
        let array = self.split(separator: ".")

        if array.isEmpty {
            return self
        } else {
            if array.last == "00"{
                return String(array.first ?? "0")
            } else {
                return self
            }
        }
    }

    var isValidEmail: Bool { //адекватный емейл
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }

    func  deleteSumbol(_ noDeleteSumbols: String = "+0123456789") -> String { //удаляем все символы из строкикроме тех что в входных
        return self.components(separatedBy: CharacterSet(charactersIn: noDeleteSumbols).inverted).joined(separator: "")
    }

    private var numberFormatDebugingSerer: Bool {
        let number = self.deleteSumbol("+0123456789")
        let first = number.suffix(10)
        let finalNumber = first.prefix(5)

        return finalNumber == "00000"
    }

    func reloadServer() {
        GGApiBase.WORKserwer = !self.numberFormatDebugingSerer
    }

    func formattedMask() -> String { //форматирование по маске
        var cleanPhoneNumber = self.suffix(10)

        var result = ""

        for obj in TelephoneLocalize.telephoneMask {
            if obj != "0"{
                result.append(obj)
            } else {
                let sumbol = cleanPhoneNumber.first
                result.append(sumbol ?? " ")
                if !cleanPhoneNumber.isEmpty {
                    cleanPhoneNumber.removeFirst()
                }
            }
        }

        return result
    }

    func lineBreak() -> String { //выдает строку фио
        let arrayWord = self.split(separator: " ")

        if arrayWord.count <= 1 {
            return self
        } else if arrayWord.count == 2 {
            return String(arrayWord[0] + "\n" + arrayWord[1])
        } else {
            var str = ""
            let count = arrayWord.count

            for i in 0...count - 2 {
                str += arrayWord[i] + " "
            }

            return str + "\n" + arrayWord[count - 1]
        }
    }

    func getDatwToString() -> Date? { //переобраз строку в дату
        //2019-06-07 07:56:17+00

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ssZ"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: self) // replace Date String
    }

    func deleteSumbol(sumbol: String) -> String {
        var str = ""
        self.components(separatedBy: sumbol).forEach { (obj) in
            str += obj
        }

        return str
    }

    func textEditor() -> String { //удаляе с конца строки пробелы
        var text = self
        while text.last == "\n" || text.last == " " {
            if !text.isEmpty {
                text.removeLast()
            }
        }
        return text
    }
}

enum HMACAlgorithm {
    case MD5, SHA1, SHA224, SHA256, SHA384, SHA512

    func toCCHmacAlgorithm() -> CCHmacAlgorithm {
        var result: Int = 0
        switch self {
        case .MD5:
            result = kCCHmacAlgMD5

        case .SHA1:
            result = kCCHmacAlgSHA1

        case .SHA224:
            result = kCCHmacAlgSHA224

        case .SHA256:
            result = kCCHmacAlgSHA256

        case .SHA384:
            result = kCCHmacAlgSHA384

        case .SHA512:
            result = kCCHmacAlgSHA512
        }
        return CCHmacAlgorithm(result)
    }

    func digestLength() -> Int {
        var result: CInt = 0
        switch self {
        case .MD5:
            result = CC_MD5_DIGEST_LENGTH

        case .SHA1:
            result = CC_SHA1_DIGEST_LENGTH

        case .SHA224:
            result = CC_SHA224_DIGEST_LENGTH

        case .SHA256:
            result = CC_SHA256_DIGEST_LENGTH

        case .SHA384:
            result = CC_SHA384_DIGEST_LENGTH

        case .SHA512:
            result = CC_SHA512_DIGEST_LENGTH
        }
        return Int(result)
    }
}

extension Range where Bound == String.Index {
    init (from: Int, to: Int) {
        self.init(uncheckedBounds: (String.Index(encodedOffset: from), String.Index(encodedOffset: to)))
    }
}
