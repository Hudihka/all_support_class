//
//  UITextField.swift
//  GinzaGO
//
//  Created by Username on 20.08.2019.
//  Copyright © 2019 Hudihka. All rights reserved.
//

import Foundation
import UIKit

// MARK: - TextField
extension UITextField {


    func isBadSumbolRegistrationVC(string: String) -> Bool { //благодаря этой ф-ии нельзя вводить ни чего кроме чисел в телефон текстФилд
        let setGoodSumbol: NSSet = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0", ""]

        return setGoodSumbol.contains(string)
    }

    func isBadSumbolName(string: String) -> Bool { //имя по формату
        let setBadSumbol: NSSet = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0",
                                   "!", "@", "#", "$", "%", "^", "&", "*", "(", ")",
                                   "№", ":", ",", ";", "/", "*", "+", "{", "}", "?",
                                   "<", ">", "\""]

        return !setBadSumbol.contains(string)
    }

    func isBadSumbolEMail(string: String, range: NSRange) -> Bool { //емейл по формату
        guard let text = self.text else {
            return false
        }

        let arrayText = Array(text)

        let setSumbol: NSSet = ["_", "%", "+", "-"]

        let setAll: NSSet = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0",
                             "q", "w", "e", "r", "t", "y", "u", "i", "o", "p",
                             "a", "s", "d", "f", "g", "h", "j", "k", "l", "z",
                             "x", "c", "v", "b", "n", "m",
                             "Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P",
                             "A", "S", "D", "F", "G", "H", "J", "K", "L", "Z",
                             "X", "C", "V", "B", "N", "M", "@",
                             ".", "_", "%", "+", "-", "", " "]

        if string == "@" && text.contains("@") {
            return false
        }

        let location = arrayText.firstIndex(of: "@")

        if let loc = location {
            if range.location > loc {
                if setSumbol.contains(string) {
                    return false
                }

                let newArray = arrayText.suffix(from: loc)

                if string == "." {
                    return !newArray.contains(".")
                }
            }
        }

        print(string)
        if text.count > 63 || string.count > 63 {
            return false
        } else if string.count > 1 {
            for sumbol in Array(string) {
                if !setAll.contains(String(sumbol)) {
                    return false
                }
            }
            return true
        }

        return setAll.contains(string)
    }

    func resultString(string: String, range: NSRange) -> String {
        let text: NSString = (self.text ?? "") as NSString
        return text.replacingCharacters(in: range, with: string)
    }

    var isClear: Bool{
        if let text = self.text {
            return text == ""
        }

        return true
    }

    var count: Int? {
        guard let text = self.text else {return nil}

        return Int(text)

    }

}


extension UITextView{

    func resultString(string: String, range: NSRange) -> String {
        let text: NSString = (self.text ?? "") as NSString
        return text.replacingCharacters(in: range, with: string)
    }
}

extension UISearchBar{

    func resultString(string: String, range: NSRange) -> String {
        let text: NSString = (self.text ?? "") as NSString
        return text.replacingCharacters(in: range, with: string)
    }
}
