//
//  3Sum.swift
//  Algoritms
//
//  Created by Худышка К on 17.05.2024.
//

import Foundation

final class Sum3: TesterProtocol {
    func threeSum(_ nums: [Int]) -> [[Int]] {
        var returnDictionary = [Set<Int>: [Int]]()
        
        for i in 0..<nums.count {
            for j in 0..<nums.count {
                for k in 0..<nums.count {
                    if i != j, j != k, k != i {
                        let obj1 = nums[i]
                        let obj2 = nums[j]
                        let obj3 = nums[k]
                        
                        if obj1 + obj2 + obj3 == 0 {
                            returnDictionary[[obj1, obj2, obj3]] = [obj1, obj2, obj3]
                        }
                    }
                }
            }
        }
        
        return returnDictionary.map({ $0.value })
    }
    
    func test() {
        print(threeSum([-1,0,1,2,-1,-4]) == [[-1,-1,2],[-1,0,1]])
    }
}
