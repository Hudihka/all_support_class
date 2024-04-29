import UIKit

var greeting = "Hello, playground"


extension String {
    var isPalindrom: Bool {
        let array = self.map({ $0 })
        let count = array.count - 1
        
        for i in 0...count {
            let j = count - i
            
            if i <= j, array[i] != array[j] {
                return false
            }
        }
        
        return true
    }
}

greeting.isPalindrom
"hhu_uhh".isPalindrom
