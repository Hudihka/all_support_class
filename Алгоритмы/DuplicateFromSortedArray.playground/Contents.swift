import UIKit

//https://leetcode.com/problems/remove-duplicates-from-sorted-array-ii/description/?envType=study-plan-v2&envId=top-interview-150


func removeDublicate(array: inout [Int]) -> [String] {
    var countBig = 0
    var countSmall = 0
    var symbol: String?
    
    return array
        .map { "\($0)" }
        .map {
            if let sym = symbol {
                
                if sym == $0 {
                    
                    if countSmall == 1 {
                        countBig += 1
                        return "-"
                        
                    } else {
                        countSmall = 1
                        return $0
                    }
                } else {
                    symbol = $0
                    countSmall = 0
                    
                    return $0
                }
            } else {
                symbol = $0
                countSmall = 0
                
                return $0
            }
        }
        .filter({ Int($0) != nil }) + Array(repeating: "-", count: countBig)
}


var arrayTest = [1, 1, 2, 2, 2, 3, 3, 4, 4, 4, 4, 5, 5, 5]
removeDublicate(array: &arrayTest)
