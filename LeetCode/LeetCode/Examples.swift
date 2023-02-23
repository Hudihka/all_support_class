//
//  Examples.swift
//  LeetCode
//
//  Created by Худышка К on 17.02.2023.
//

import Foundation

class Examples0 {
    
//    Example 1:
//    Input: nums = [2,7,11,15], target = 9
//    Output: [0,1]
//    Explanation: Because nums[0] + nums[1] == 9, we return [0, 1].
    
//    Example 2:
//    Input: nums = [3,2,4], target = 6
//    Output: [1,2]
    
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var hash = [Int: Int]()
        
        for (index, value) in nums.enumerated() {
            let ost = target - value
            
            if let indexFirst = hash[value] {
                return [indexFirst, index]
            }
            hash[ost] = index
        }
        
        print(hash)
        
        return []
    }
}

class Examples1 {
    func addTwoNumbers(_ l1: ListNode, _ l2: ListNode) -> [Int] {
        var returnArray = [Int]()
        
        let firstArray = l1.values
        let secondArray = l2.values
        
        let array = firstArray.count > secondArray.count ? firstArray : secondArray
        let arraySecond = firstArray.count < secondArray.count ? firstArray : secondArray
        
        var ost: Int?
        
        for (index, value) in array.enumerated() {
            let summ = value + (arraySecond[safe: index] ?? 0) + (ost ?? 0)
            
            let newValue = summ % 10
            
            returnArray.append(newValue)
            
            ost = summ / 10
        }
        
        return returnArray
    }
    
    func test(_ l1: [Int], _ l2: [Int]) -> [Int] {
        var returnArray = [Int]()
        
        let array = l1.count > l2.count ? l1 : l2
        let arraySecond = l1.count < l2.count ? l1 : l2
        
        var ost: Int?
        
        for (index, value) in array.enumerated() {
            let summ = value + (arraySecond[safe: index] ?? 0) + (ost ?? 0)
            
            let newValue = summ % 10
            
            returnArray.append(newValue)
            
            ost = summ / 10
        }
        
        if let ost = ost {
            returnArray.append(ost)
        }
        
        return returnArray
    }
}

class Example3 {
    /*
     Вход: s = "abcabcbb" Выход: Объяснение: Ответ - "abc", длиной 3.
     Пример 2:

     Вход: s = "bbbbb"Выход: Объяснение: Ответ "b" длиной 1.
     Пример 3:

     Вход: s = "pwwkew"Выход: Объяснение: Ответ - "wke", длиной 3.
     */
    
    func lengthOfLongestSubstring(_ s: String) -> Int {
        var returnCount = 0
        let arr = s.map({ $0 })
        
        var dict = [Character: Character]()
        
        arr.forEach { value in
            
            if dict[value] == nil {
                dict[value] = value
            } else {
                let newCount = dict.count
                returnCount = max(newCount, returnCount)
                dict = [:]
            }
        }
        
        if !dict.isEmpty {
            let newCount = dict.count
            returnCount = max(newCount, returnCount)
            dict = [:]
        }
        
        
        return returnCount
    }
}

class Example4 {
    // max palindromic substring in s.
    func longestPalindrome(_ s: String) -> String {
        let arr = s.map({ String($0) })
        let max = arr.count - 1
        
        var maxStr = ""
        
        for i in 0...max {
            for j in i...max {
                
                let new = isPolindrom(arr, startInd: i, finish: j)
                maxStr = new.count > maxStr.count ? new : maxStr
                
            }
        }
        
        return maxStr
    }
    
    func isPolindrom(_ arr: [String], startInd: Int, finish: Int) -> String {
        var indStart = startInd
        var indFinish = finish
        
        var startStr = ""
        var finishStr = ""
        
        while indStart < indFinish {
            let startValue = arr[indStart]
            let finishValue = arr[indFinish]
            
            if startValue != finishValue {
                return ""
            }
            
            startStr += startValue
            finishStr = finishValue + finishStr
            
            indStart += 1
            indFinish -= 1
        }
        
        return startStr + finishStr
    }
}

class Example6 {
    /*
     Example 1:
     Input: x = 123
     Output: 321
     
     Example 2:
     Input: x = -123
     Output: -321
     
     Example 3:
     Input: x = 120
     Output: 21
     */
    
    func reverse(_ x: Int) -> Int {
        let koef = x < 0 ? -1 : 1
        let arr = "\(abs(x))".map({ $0 })
        var new = ""
        var zeroFlag = false
        
        arr.reversed().forEach { value in
            if value == "0", zeroFlag {
                new += String(value)
            } else if value == "0", zeroFlag == false {
                //
            } else if value != "0" {
                new += String(value)
                zeroFlag = true
            }
        }
        
        return (Int(new) ?? 0) * koef
    }
    
}

class Example7 {
    /*
     Вам дан целочисленный массив высоты длины n. Нарисовано n вертикальных линий,
     две конечные точки i-й линии равны (i, 0) и (i, height[i]).

     Найдите две линии, которые вместе с осью абсцисс образуют контейнер,
     содержащий наибольшее количество воды.

     Возвращает максимальное количество воды,
     которое может храниться в контейнере.

     Обратите внимание, что вы не можете наклонять контейнер.

     Вышеупомянутые вертикальные линии представлены массивом [1,8,6,2,5,4,8,3,7].
     В этом случае максимальная площадь воды (синяя секция),
     которую может содержать контейнер, составляет 49.
    */
    
    func maxArea(_ height: [Int]) -> Int {
        var maxVol = 0
        
        for i in 0...height.count - 2 {
            for j in i+1...height.count - 1 {
                let delta = j - i
                let min = min(height[i], height[j])
                let newVol = delta * min
                
                maxVol = newVol > maxVol ? newVol : maxVol
            }
        }
        
        return maxVol
    }
}

// int to roman

class Example8 {
    /*
     I             1
     V             5
     X             10
     L             50
     C             100
     D             500
     M             1000
     */
    private let dict = [
       1 : "I",
       5 : "V",
       10 : "X",
       50 : "L",
       100 : "C",
       500 : "D",
       1000 : "M"
    ]
}
