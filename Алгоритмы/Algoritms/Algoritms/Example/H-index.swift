//
//  H-index.swift
//  Algoritms
//
//  Created by Худышка К on 03.05.2024.
//

import Foundation

// https://leetcode.com/problems/h-index/?envType=study-plan-v2&envId=top-interview-150

final class Hindex: TesterProtocol {
    func hIndex(_ citations: [Int]) -> Int {
//        let max = citations.max() ?? 0
//        let minElement = min(max, citations.count)
//        
//        let filtered = citations.filter({ $0 <= minElement })
//        
        var counter = 0
        
        for i in citations {
            let values = citations.filter({ $0 >= i })
            
            if values.count >= i, i > counter {
                counter = i
            }
            
        }
        
        
        
        
        return counter
    }
    
    func test() {
        let nums1 = [3,0,6,1,5]
        let nums2 = [1,3,1]

        print(hIndex(nums1)) // Output: 2
        print(hIndex(nums2)) // Output: 2
    }
}
