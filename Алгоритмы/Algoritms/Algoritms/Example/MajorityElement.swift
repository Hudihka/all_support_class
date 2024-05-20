//
//  MajorityElement.swift
//  Algoritms
//
//  Created by Худышка К on 20.05.2024.
//

import Foundation

final class MajorityElement: TesterProtocol {
    var dict = [Int: Int]()
    
    func majorityElement(_ nums: [Int]) -> Int {
        nums.forEach({
            if let obj = dict[$0] {
                dict[$0] = obj + 1
            } else {
                dict[$0] = 1
            }
        })
        
        let max = dict.map({ $0.value }).max()
        
        
        return dict.first(where: { $0.value == max })?.key ?? 0
    }
    
    func test() {
        print(majorityElement([3,2,3]) == 3)
        print(majorityElement([2,2,1,1,1,2,2]) == 2)
    }
}
