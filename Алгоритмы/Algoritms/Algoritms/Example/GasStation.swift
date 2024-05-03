//
//  GasStation.swift
//  Algoritms
//
//  Created by Худышка К on 03.05.2024.
//

import Foundation

// https://leetcode.com/problems/gas-station/?envType=study-plan-v2&envId=top-interview-150

final class GasStation: TesterProtocol {
    func canCompleteCircuit(_ gas: [Int], _ cost: [Int]) -> Int {
        0
    }
    
    func test() {
        print(
            canCompleteCircuit([1,2,3,4,5], [3,4,5,1,2]) == 3
        )
        
        print(
            canCompleteCircuit([2,3,4], [3,4,3]) == -1
        )
    }
}
