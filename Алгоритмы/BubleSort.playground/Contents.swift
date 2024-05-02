import UIKit

func sort(array: inout [Int]) -> [Int] {
    var count = array.count - 1
    
    while count > 0 {
        
        for i in 0...count - 1 {
            let a = array[i]
            let b = array[i+1]
            
            if a > b {
                array.swapAt(i, i+1)
            }
        }
        
        count -= 1
    }
    
    return array
}

var testArr = [10, 9, 8, 7, 6, 5, 4, 3, 2, 1]
sort(array: &testArr)
