//
//  UITextField.swift
//  GinzaGO
//
//  Created by Username on 20.08.2019.
//  Copyright © 2019 ITMegastar. All rights reserved.
//

import Foundation

// MARK: - TextField
extension UITextField {
    func canBeEdited(lenght: Int, lenghtMax: Int, string: String) -> Bool {//можно редактировать тексФилд с телефонным номером

        if lenght < lenghtMax {
            return isBadSumbolRegistrationVC(string: string)
        } else if lenght == lenghtMax && string.isEmpty {
            return true
        } else {
            return false
        }
    }

    func editingCountryCode(range: NSRange) -> Bool {//запрет на редактирование кода страны
        let prefixNumber = TelephoneLocalize.prefixNumber

        if range.location < prefixNumber.count {
            return false
        }

        return true
    }

    func getPhoneNoLandCode() -> String { //получение текушего номера в текс филде без кода страны

        guard let text = self.text else {
            return ""
        }

        let textLeng = text.count
        let lengLand = TelephoneLocalize.prefixNumber.count

        return String(text.suffix(textLeng - lengLand))
    }

    func getCountCifr () -> Int { //функция возвращает количество чисел в строке но без кода страны
        let array = Array(self.getPhoneNoLandCode())
        let setGoodSumbol: NSSet = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]

        var counter = 0

        for i in array {
            if setGoodSumbol.contains(String(i)) {
                counter += 1
            }
        }

        return counter
    }

    func getCountCifrPassword () -> Int { //то же что и выше но для пароля

        guard let text = self.text else {
            return 0
        }

        let array = Array(text)

        let setGoodSumbol: NSSet = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]

        var counter = 0

        for i in array {
            if setGoodSumbol.contains(String(i)) {
                counter += 1
            }
        }

        return counter
    }

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
}
