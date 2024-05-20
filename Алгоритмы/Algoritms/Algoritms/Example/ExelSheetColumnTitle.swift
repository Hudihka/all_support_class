//
//  ExelSheetColumnTitle.swift
//  Algoritms
//
//  Created by Худышка К on 20.05.2024.
//

import Foundation

// https://leetcode.com/problems/excel-sheet-column-title/

class ExelSheetColumnTitle: TesterProtocol {
    var dict: [Int: String] = {
        var dic = [Int: String]()
        
        [
         "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M",
         "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"
        ].enumerated().forEach({ dic[$0.offset + 1] = $0.element })
        
        return dic
    }()
    
    func convertToTitle(_ columnNumber: Int) -> String {
        let count = dict.count
        
        if columnNumber <= count {
            return dict[columnNumber] ?? ""
        }
        
        var symbols = [Int]()
        var number = columnNumber
        
        while number >= count {
            let have = number / count
            symbols.append(have)
            
            number = number % count
        }
        symbols.append(number)
        
        return symbols.map({ dict[$0] ?? "" }).joined()
    }
    
    func test() {
        print(convertToTitle(28) == "AB")
        print(convertToTitle(701) == "ZY")
        print(convertToTitle(27) == "AA")

        print(convertToTitle(1) == "A")
        print(convertToTitle(26) == "Z")
//        Z -> 26
//        AA -> 27
    }
}
