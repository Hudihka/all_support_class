import UIKit

// https:leetcode.com/problems/rotate-array/description/?envType=study-plan-v2&envId=top-interview-150


func rotate(array: inout [Int], step: Int) -> [Int] {
    var k = 0
    
    while k < step {
        let last = array.removeLast()
        array.insert(last, at: 0)
        
        k += 1
    }
    
    return array
}


var array = [0, 1, 2, 3, 4, 5]
rotate(array: &array, step: 1)
