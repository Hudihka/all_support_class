//
//  RomanToInteger.swift
//  Algoritms
//
//  Created by Худышка К on 09.05.2024.
//

import Foundation

//https://leetcode.com/problems/roman-to-integer/description/?envType=study-plan-v2&envId=top-interview-150https://leetcode.com/problems/roman-to-integer/description/?envType=study-plan-v2&envId=top-interview-150

final class RomanToInteger: TesterProtocol {
    let dictionary = [
        "I": 1,
        "V": 5,
        "X": 10,
        "L": 50,
        "C": 100,
        "D": 500,
        "M": 1000
    ]
    
    func romanToInt(_ s: String) -> Int {
        var setBadIndexses = Set<Int>()
        var summ = 0
        
        let array = s.toArray
        
        for (offset, element) in array.enumerated() {
            
            if
                let value1 = dictionary[element],
                let nextKey = array[safe: offset + 1],
                let value2 = dictionary[nextKey],
                value2 > value1
            {
                setBadIndexses.insert(offset)
                setBadIndexses.insert(offset + 1)
                
                summ += value2 - value1
            }
            
        }
        
        array.enumerated().forEach {
            if
                setBadIndexses.contains($0.offset) == false,
                let value = dictionary[$0.element]
            {
                summ += value
            }
        }
        
        
        return summ
    }
    
    func test() {
        print(
            romanToInt("III") == 3
        )
        
        print(
            romanToInt("LVIII") == 58
        )
        
        print(
            romanToInt("MCMXCIV") == 1994
        )
    }
}

private extension String {
    var toArray: [String] {
        map({ String($0) })
    }
}

private extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
