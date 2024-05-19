//
//  JumpGame.swift
//  Algoritms
//
//  Created by Худышка К on 02.05.2024.
//

import Foundation

//https://leetcode.com/problems/jump-game/description/?envType=study-plan-v2&envId=top-interview-150

final class JumpGame: TesterProtocol {
    func canJump(_ nums: [Int]) -> Bool {
        guard nums.count != 1 else {
            return true
        }
        
        guard
            nums.count > 0,
            let first = nums.first,
            first != 0
        else {
            return false
        }
        
        for i in 1...first {
            let secondPath = Array(nums[i...])
            if canJump(secondPath) {
                return true
            }
        }
        
        return false
    }
    
    func test() {
        print(canJump([2,3,1,1,4]))
        print(canJump([3,2,1,0,4]))
    }
}
