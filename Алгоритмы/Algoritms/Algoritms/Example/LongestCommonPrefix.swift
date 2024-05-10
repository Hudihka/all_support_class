//
//  LongestCommonPrefix.swift
//  Algoritms
//
//  Created by Худышка К on 10.05.2024.
//

import Foundation

// https://leetcode.com/problems/longest-common-prefix/?envType=study-plan-v2&envId=top-interview-150

final class LongestCommonPrefix: TesterProtocol {
    
    func longestCommonPrefix(_ strs: [String]) -> String {
        var returnValue = ""
        
        guard let firstWord = strs.first else {
            return returnValue
        }
        
        let count = strs.count
        
        guard count != 1 else {
            return firstWord
        }
        
        var maxCount = 0
        
        for i in 0...200 {
            let prefix = firstWord.prefix(i)
            
            if strs.filter({ $0.prefix(i) == prefix }).count == count {
                maxCount = i
            } else {
                if i == 0 {
                    return returnValue
                }
                
                return String(firstWord.prefix(maxCount))
            }
        }
        
        return returnValue
    }
    
    func test() {
        print(
            longestCommonPrefix(["flower","flow","flight"]) == "fl"
        )
        
        print(
            longestCommonPrefix(["dog","racecar","car"]) == ""
        )
    }
}
