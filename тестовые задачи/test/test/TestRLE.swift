//
//  TestRLE.swift
//  test
//
//  Created by Константин Ирошников on 23.10.2022.
//

import Foundation

//final class TestRLE {
//
//    private let test = "AAAAAAAABBBBBYYYUIOAAAAAAAUUUUULLLLLLLLLLLT"
//    private let testDecode = "YUIOA8B5Y3UIOA7U5L11T2"
//
//    func addStr(_ array: [String]) -> String {
//        let first = array.first ?? ""
//        if array.count == 1 {
//            return first
//        } else {
//            return first + "\(array.count)"
//        }
//    }
//
//    var getRLE: String {
//        var array = [String]()
//        var str = ""
//
//        let arraySymbols = test.map({ $0 })
//
//        for (index, obj) in arraySymbols.enumerated() {
//            if let nextObj = arraySymbols[safe: index + 1] {
//                array.append(String(obj))
//
//                if nextObj != obj {
//                    str += addStr(array)
//                    array = []
//                }
//
//            } else {
//                array.append(String(obj))
//                str += addStr(array)
//            }
//        }
//
//        return str
//    }
//
//    var decode: String {
//        var arrayCifrs = [Int]()
//        var arrayLiteral = [String]()
//
//        var strTest = ""
//        var returnStr = ""
//
//        let arraySymbols = testDecode.map({ $0 })
//
//        for (index, obj) in arraySymbols.enumerated() {
//            if let nextObj = arraySymbols[safe: index + 1] {
//                if obj.isInt, nextObj.isInt {
//                    strTest += "\(obj)"
//                } else if obj.isInt, !nextObj.isInt {
//                    strTest += "\(obj)-"
//                } else if !obj.isInt, !nextObj.isInt {
//                    strTest += "\(obj)-1-"
//                } else if !obj.isInt, nextObj.isInt {
//                    strTest += "\(obj)-"
//                }
//            } else {
//                if obj.isInt {
//                    strTest += "\(obj)"
//                } else {
//                    strTest += "\(obj)-1"
//                }
//            }
//        }
//
//        let arrayCifrAndSumbols = strTest.split(separator: "-")
//
//        for obj in arrayCifrAndSumbols {
//            if let cifr = Int(String(obj)) {
//                arrayCifrs.append(cifr)
//            } else {
//                arrayLiteral.append("\(obj)")
//            }
//        }
//
//        for (literal, count) in zip(arrayLiteral, arrayCifrs) {
//            let array = Array(repeating: literal, count: count)
//            returnStr += array.joined()
//        }
//
//        return returnStr
//    }
//}
