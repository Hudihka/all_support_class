import UIKit

//Ввод: gcd(12, 15)
//Вывод: 3
//
//Ввод: gcd(24, 36)
//Вывод: 12
//
//Ввод: gcd(17, 31)
//Вывод: 1


func NOD(_ value1: Int, value2: Int) -> Int {
    var maxValue = max(value1, value2)
    
    if value1 == 0 || value2 == 0 || value1 == value2 {
        return maxValue
    }
    
    var minValue = min(value1, value2)
    
    while minValue >= 0 {
        let remaider1 = value1 % minValue
        let remaider2 = value2 % minValue
        
        if remaider1 == 0, remaider2 == 0 {
            return minValue
        }
        
        minValue -= 1
    }
    
    return 1
}

print(NOD(12, value2: 15))
print(NOD(24, value2: 36))
print(NOD(17, value2: 31))
