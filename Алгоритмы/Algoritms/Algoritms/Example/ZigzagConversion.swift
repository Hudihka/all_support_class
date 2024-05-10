//
//  ZigzagConversion.swift
//  Algoritms
//
//  Created by Худышка К on 10.05.2024.
//

import Foundation

final class ZigzagConversion: TesterProtocol {
    let offsets = [
        0: 0,
        1: 0,
        2: 1,
        3: 3
    ]
    
    func convert(_ s: String = "PAYPALISHIRING", numRows: Int) -> [String] {
        guard numRows > 1 else {
            return [s]
        }
                
        var array = [String]()
        
        var changeStr = s
        let step = numRows + max(0, numRows - 2)
        
        while changeStr != "" {
            let prefix = String(changeStr.prefix(step))
            array += convertPart(prefix, numRows: numRows)
            
            changeStr.removeFirst(step)
        }

        return array
    }
    
    
    private func convertPart(_ s: String, numRows: Int) -> [String] {
        var array = [String]()
        
        var changinString = s
        
        var first: String = String(s.prefix(numRows))

        if first.count < numRows {
            first = first + Array(repeating: " ", count: numRows - first.count).joined()
        }
        changinString.removeFirst(numRows)
        array.append(first)
        
        let spacer = max(0, numRows - 2)
        let arrayChair = changinString.map({ String($0) })
        
        
        for i in 0...spacer {
            if let chair = arrayChair[safe: i] {
                let firstSpaces = Array(repeating: " ", count: 1 + i).joined()
                let endSpaces = Array(repeating: " ", count: spacer - i).joined()
                
                array.append("\(firstSpaces)\(chair)\(endSpaces)")
            }
        }

        return array
    }
    
    func test() {
        print(convert(numRows: 4))
//        print(
//            convert(numRows: 3)
//        )
//
//        print(
//            convert(numRows: 4)
//        )
    }
}

extension String {
    mutating func removeFirst(_ n: Int) {
        self = String(self.suffix(self.count - n))
    }
}

private extension Collection {
    subscript (safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
