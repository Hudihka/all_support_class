//
//  TextJustification.swift
//  Algoritms
//
//  Created by Худышка К on 13.05.2024.
//

import Foundation

// https://leetcode.com/problems/text-justification/?envType=study-plan-v2&envId=top-interview-150
final class TextJustification: TesterProtocol {
    let wordsAll = ["a", "b", "c"]
    var combinations: [[String]] = []
    
    func generateCombinations(words: [String]) -> [String] {
        var combinations = [String]()
        
        combine("", remaining: words, combinations: &combinations)
        return combinations
    }

    func combine(_ prefix: String, remaining: [String], combinations: inout [String]) {
        if !prefix.isEmpty {
            combinations.append(prefix)
        }
        
        for (index, word) in remaining.enumerated() {
            let newRemaining = remaining[(index + 1)...]
            print(newRemaining)
            
            combine(
                prefix + word,
                remaining: Array(newRemaining),
                combinations: &combinations
            )
        }
    }
    
    func test() {
        print(generateCombinations(words: wordsAll))
        
    }
}

//final class TextJustification: TesterProtocol {
//    
//    var words: [Set<String>] = []
//    
//    func fullJustify(_ words: [String], _ maxWidth: Int) -> [String] {
//        []
//    }
//    
//    func test() {
////        print(
////            fullJustify(["This", "is", "an", "example", "of", "text", "justification."], 16)
////        )
//    }
//}
//
//private extension TextJustification {
//    func fullJustifyTest(_ words: inout [String], _ maxWidth: Int) -> [String] {
//        words = words.filter({ $0.count < maxWidth })
//        
//        
//        
//        for i in 0..<words.count {
//            
//            
//            
//            
//        }
//        
//        
//        
//        return []
//    }
//    
//    func test(inSet: Set<String>, word: String) {
//        
//    }
//    
//    
//
//}
//
