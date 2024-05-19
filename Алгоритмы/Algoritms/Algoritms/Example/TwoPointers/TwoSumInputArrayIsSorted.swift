//
//  TwoSumInputArrayIsSorted.swift
//  Algoritms
//
//  Created by Худышка К on 17.05.2024.
//

import Foundation

// https://leetcode.com/problems/two-sum-ii-input-array-is-sorted/?envType=study-plan-v2&envId=top-interview-150

final class TwoSumInputArrayIsSorted: TesterProtocol {
    
    func twoSum(_ numbers: [Int], _ target: Int) -> [Int] {
        for i in 0..<numbers.count {
            for j in i+1..<numbers.count {
                let goal = numbers[i] + numbers[j]
                
                if goal == target {
                    return [i + 1, j + 1]
                }
            }
        }
        
        return []
    }
    
    func test() {
        print(twoSum([2,7,11,15], 9) == [1,2])
        print(twoSum([2,3,4], 6) == [1,3])
        print(twoSum([-1,0], -1) == [1,2])
    }
}

//Input: numbers = [2,7,11,15], target = 9
//Output: [1,2]
//Explanation: The sum of 2 and 7 is 9. Therefore, index1 = 1, index2 = 2. We return [1, 2].
//Example 2:
//
//Input: numbers = [2,3,4], target = 6
//Output: [1,3]
//Explanation: The sum of 2 and 4 is 6. Therefore index1 = 1, index2 = 3. We return [1, 3].
//Example 3:
//
//Input: numbers = [-1,0], target = -1
//Output: [1,2]
//Explanation: The sum of -1 and 0 is -1. Therefore index1 = 1, index2 = 2. We return [1, 2].
