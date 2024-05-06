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
        let badResult = -1
        
        var casOnBag = 0
        
        for i in 0..<gas.count {
            let newGas = gas.separateOn(index: i)
            let newCost = cost.separateOn(index: i)
            casOnBag = 0
            
            for (offset, value) in newGas.enumerated() {
                if offset == 0, value == 0 {
                    return badResult
                }
                
                if casOnBag < 0 {
                    continue
                }
                
                casOnBag += (value - newCost[offset])
                
                if casOnBag < 0 {
                    continue
                }
            }
            
            if casOnBag >= 0 {
                return i
            }
            
        }
        
        
        return badResult
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

extension Array {
    func separateOn(index: Int) -> Self {
        guard index != 0 else {
            return self
        }
        
        var returnArray: Self = []
        
        for i in index..<self.count {
            returnArray.append(self[i])
        }
        
        for i in 0..<index {
            returnArray.append(self[i])
        }
        
        return returnArray
    }
}
