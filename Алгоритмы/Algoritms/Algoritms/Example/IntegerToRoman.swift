//
//  IntegerToRoman.swift
//  Algoritms
//
//  Created by Худышка К on 09.05.2024.
//

import Foundation

// https://leetcode.com/problems/integer-to-roman/?envType=study-plan-v2&envId=top-interview-150

final class IntegerToRoman: TesterProtocol {
    struct Cifr {
        let value: Int
        let kind: Int
        
        var isBadValue: Bool {
            isFour || isNine
        }
        
        var isFour: Bool {
            value == 4
        }
        
        var isNine: Bool {
            value == 9
        }
        
        var countOnce: Int {
            value > 5 ? value - 5 : value
        }
        
        var isFive: Bool {
            value == 5
        }
        
        var valueForRoman: Int {
            value * kind
        }
    }
    
    let dictionary = [
        "I": 1,
        "V": 5,
        "X": 10,
        "L": 50,
        "C": 100,
        "D": 500,
        "M": 1000
    ]
    
    var opositDictionary = [Int: String]()
    
    func intToRoman(_ num: Int) -> String {
        dictionary.forEach({ opositDictionary[$0.value] = $0.key })
        
        let array = String(num).map({ String($0) }).reversed()
        
        var cifrs = [Cifr]()
        
        array.enumerated().forEach {
            if
                let kind = Int("1" + Array(repeating: "0", count: $0.offset).joined()),
                let value = Int($0.element)
            {
                cifrs.append(
                    Cifr(value: value, kind: kind)
                )
            }
        }
        
        var returnValue = ""
        
        cifrs.reversed().forEach({
            if $0.isBadValue {
                
                let sumbolFirst = opositDictionary[$0.kind] ?? ""
                var sumbolLast = ""
                
                if $0.isFour {
                    sumbolLast = opositDictionary[5 * $0.kind] ?? ""
                } else if $0.isNine {
                    sumbolLast = opositDictionary[10 * $0.kind] ?? ""
                }
                
                returnValue += "\(sumbolFirst)\(sumbolLast)"
                
            } else {
                if $0.isFive {
                    returnValue += opositDictionary[$0.valueForRoman] ?? ""
                } else {
                    let sumbol = opositDictionary[$0.kind] ?? ""
                    
                    let onceSumbols = Array(repeating: sumbol, count: $0.countOnce).joined()
                    
                    let five = $0.value > 5 ? opositDictionary[5 * $0.kind] ?? "" : ""
                    
                    returnValue += "\(five)\(onceSumbols)"
                }
            }
        })
        
        
        return returnValue
    }
    
    func test() {
        print(
            intToRoman(3749) == "MMMDCCXLIX"
        )
        
        print(
            intToRoman(58) == "LVIII"
        )
        
        print(
            intToRoman(1994) == "MCMXCIV"
        )
    }
}


