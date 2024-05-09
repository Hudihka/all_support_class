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
        
        var badValue: Bool {
            value % 4 == 0 || value % 9 == 0
        }
        
        var isMoreFive: Bool {
            value > 5
        }
        
        var countOnce: Int {
            isMoreFive ? value - 5 : value
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
    
    func intToRoman(_ num: Int) -> String {
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


