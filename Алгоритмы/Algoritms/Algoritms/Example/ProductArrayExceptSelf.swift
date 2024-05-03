//
//  ProductArrayExceptSelf.swift
//  Algoritms
//
//  Created by Худышка К on 03.05.2024.
//

import Foundation

//https://leetcode.com/problems/product-of-array-except-self/description/?envType=study-plan-v2&envId=top-interview-150

final class ProductArrayExceptSelf: TesterProtocol {
    func productExceptSelf(_ nums: [Int]) -> [Int] {
        var product = 1
        var productWithOutZero = 1
        
        var firstIndexZero: Int?
        
        for (index, element) in nums.enumerated() {
            let elementIsZero = element == 0
            
            if elementIsZero {
                if let firstIndexZero {
                    return generateZeroArray(count: nums.count)
                } else {
                    firstIndexZero = index
                }
            }
            
            product = product * element
            if elementIsZero == false {
                productWithOutZero = productWithOutZero * element
            }
        }
        
        var array = [Int]()
        
        for (index, element) in nums.enumerated() {
            if let firstIndexZero, index == firstIndexZero {
                array.append(productWithOutZero)
            } else {
                array.append(product / element)
            }
        }
        
        
        
        return array
    }
    
    private func generateZeroArray(count: Int) -> [Int] {
        Array(repeating: 0, count: count)
    }
    
    func test() {
        print(
            productExceptSelf([1,2,3,4]) == [24,12,8,6]
        )
        print(
            productExceptSelf([-1,1,0,-3,3]) == [0,0,9,0,0]
        )
    }
}

//Input: nums = [1,2,3,4]
//Output: [24,12,8,6]
//
//Input: nums = [-1,1,0,-3,3]
//Output: [0,0,9,0,0]
