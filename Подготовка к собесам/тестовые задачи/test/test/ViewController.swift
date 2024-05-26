//
//  ViewController.swift
//  test
//
//  Created by Константин Ирошников on 30.07.2022.
//

import UIKit

var array = [Int]()

for i in 0...1000 {
    DispatchQueue.main.asyncAfter(deadline: randomTime()) {
        array.append(i)
    }
}

//class ViewController: UIViewController {
//    let quу = DispatchQueue.global()
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        var counter = 0
//        let semafor = DispatchSemaphore(value: 1)
//
//        DispatchQueue.global().async {
//            semafor.wait()
//            for _ in 0...9999 {
//                counter += 1
//            }
//            semafor.signal()
//        }
//
//        DispatchQueue.global().async {
//            semafor.wait()
//            for _ in 0...9999 {
//                counter += 1
//            }
//            semafor.signal()
//        }
//
//        print("start: \(counter)")
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//            print("start wait: \(counter)")
//        }
//    }
//}
//
////MARK: - UITextViewDelegate
//extension ViewController: UITextViewDelegate {
//
//    func textViewDidChange(_ textView: UITextView) {
//        guard
//            let text = textView.text,
//            text.isConteinsBadSumbol
//        else {
//            return
//        }
//
//        textView.text = text.replaceBadSymbols
//    }
//
//    func textViewDidEndEditing(_ textView: UITextView) {
//        print("----1")
//    }
//
//    func textViewDidBeginEditing(_ textView: UITextView) {
//        print("----2")
//    }
//
//    func textView(
//        _ textView: UITextView,
//        shouldChangeTextIn range: NSRange,
//        replacementText text: String
//    ) -> Bool {
//
//        //        if
//        //            text != "\n",
//        //            text.count > 1,
//        //            range.location < textView.text.count
//        //        {
//        //            let cleveText = text.replaceBadSymbols
//        //            textView.text = textView.resultString(string: cleveText, range: range)
//        //
//        //            return false
//        //        }
//        //
//        //        if text.isBadSumbol {
//        //            guard
//        //                let tvText = textView.text,
//        //                let previosSumbol = tvText.map({ $0 })[safe: range.location - 1]
//        //            else {
//        //                textView.text = " "
//        //                return false
//        //            }
//        //
//        //            if previosSumbol != " " {
//        //                textView.text = textView.resultString(string: " ", range: range)
//        //            }
//        //
//        //            return false
//        //        }
//
//        return true
//    }
//}
//
//// можно вводить только разрещенный символ
//extension String {
//    var unicode: Int? {
//
//        if self == "" || self == "\n" {
//            return 0
//        }
//
//        guard let first = self.first else {
//            return nil
//        }
//
//        let characterString = String(first)
//        let scalars = characterString.unicodeScalars
//
//        return Int(scalars[scalars.startIndex].value)
//    }
//
//    // юникод кодировки разрешенных
//    static var allowedCharacterCodes: [Int] {
//        let latinLiteral = Array(65...90) + Array(97...122)
//        // ё Ё
//        let russianLiteral = Array(1040...1103)
//        let cifrSmallLiteral = Array(48...57)
//
//        let specialSumbols = Array(32...47) + Array(58...64) + Array(91...96) + Array(123...126) + [8470, 0, 1105, 1025]
//
//        return latinLiteral + russianLiteral + cifrSmallLiteral + specialSumbols
//    }
//
//    var isBadSumbol: Bool {
//        guard let unicode = unicode else {
//            return false
//        }
//
//        return !String.allowedCharacterCodes.contains(unicode)
//    }
//
//    var replaceBadSymbols: String {
//
//        var flagIsNowBadSymbols = false
//        let array = self.map({ String($0) })
//
//        var returnArray = [String]()
//
//        for (index, i) in array.enumerated() {
//
//            if i.isBadSumbol {
//
//                if let previodSumbol = array[safe: index - 1], previodSumbol == " " {
//                    flagIsNowBadSymbols = true
//                    continue
//                } else if flagIsNowBadSymbols == false {
//                    flagIsNowBadSymbols = true
//                    returnArray.append(" ")
//                } else {
//                    continue
//                }
//            } else {
//                flagIsNowBadSymbols = false
//                returnArray.append(i)
//            }
//        }
//
//        return returnArray.joined(separator: "")
//    }
//
//    var isConteinsBadSumbol: Bool {
//        self.first(where: { String($0).isBadSumbol }) != nil
//    }
//}
//
//extension UITextView {
//    func resultString(string: String, range: NSRange) -> String {
//        let text: NSString = (self.text ?? "") as NSString
//        return text.replacingCharacters(in: range, with: string)
//    }
//}
