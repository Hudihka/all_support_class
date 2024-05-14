//
//  TextJustification.swift
//  Algoritms
//
//  Created by Худышка К on 13.05.2024.
//

import Foundation

final class TextJustification: TesterProtocol {
    
    var words: [Set<String>] = []
    
    func fullJustify(_ words: [String], _ maxWidth: Int) -> [String] {
        []
    }
    
    func test() {
//        print(
//            fullJustify(["This", "is", "an", "example", "of", "text", "justification."], 16)
//        )
    }
}

private extension TextJustification {
    func fullJustifyTest(_ words: inout [String], _ maxWidth: Int) -> [String] {
        words = words.filter({ $0.count < maxWidth })
        
        
        
        for i in 0..<words.count {
            
            
            
            
        }
        
        
        
        return []
    }
    
    func test(inSet: Set<String>, word: String) {
        
    }
    
    

}

