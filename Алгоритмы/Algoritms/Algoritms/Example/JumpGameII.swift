//
//  JumpGameII.swift
//  Algoritms
//
//  Created by Худышка К on 02.05.2024.
//

import Foundation

// https://leetcode.com/problems/jump-game-ii/description/?envType=study-plan-v2&envId=top-interview-150

final class JumpGameII: TesterProtocol {
    
    func minJumps(_ nums: [Int]) -> Int {
        if nums.count <= 1 {
            return 0
        }
        
        var maxReachable = nums[0] // Максимальный индекс, который можно достичь
        var steps = nums[0] // Количество доступных шагов на текущей позиции
        
        var jumps = 1 // Минимальное количество прыжков, необходимых
        
        let count = nums.count - 1
        
        for i in 1...count {
            
            if i == count {
                return jumps // Если достигли последнего индекса, возвращаем количество прыжков
            }
            
            maxReachable = max(maxReachable, i + nums[i])
            steps -= 1 // Использовали один шаг
            
            if steps == 0 { // Нужно совершить прыжок
                jumps += 1
                steps = maxReachable - i // Новое количество доступных шагов
            }
        }
        
        return jumps
    }
    
    func test() {
        // Test cases
        let nums1 = [2, 3, 1, 1, 4]
        let nums2 = [2, 3, 0, 1, 4]

        print(minJumps(nums1)) // Output: 2
        print(minJumps(nums2)) // Output: 2
    }
}
