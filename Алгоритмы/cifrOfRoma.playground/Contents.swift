import UIKit

let cifr = [
    "I": 1,
    "V": 5,
    "X": 10,
    "L": 50,
    "C": 100,
    "D": 500,
    "M": 1000
]

let fourAndNeinType = [
    "IV": 4,
    "IX": 9,
    "XL": 40,
    "XC": 90,
    "CD": 400,
    "CM": 900
]

func convertor(_ cifrOfRoma: String) -> Int {
    var summ = 0
    var str = cifrOfRoma
    
    fourAndNeinType.forEach {
        if str.contains($0.key), let range = str.range(of: $0.key) {
            str.removeSubrange(range)
            summ += $0.value
        }
    }
    
    str.forEach { summ += cifr[String($0)] ?? 0 }
    
    return summ
}


print(convertor("MDCXLIX"))
