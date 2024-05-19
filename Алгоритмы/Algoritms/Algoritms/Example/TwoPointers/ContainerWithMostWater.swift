//
//  ContainerWithMostWater.swift
//  Algoritms
//
//  Created by Худышка К on 17.05.2024.
//

import Foundation

final class ContainerWithMostWater: TesterProtocol {
    struct Area {
        let firstIndex: Int
        let endIndex: Int
        let minHeight: Int
        
        var volume: Int {
            minHeight * (endIndex - firstIndex)
        }
    }
    
    func maxArea(_ height: [Int]) -> Int {
        var array = [Area]()
        
        for i in 0..<height.count {
            for j in i+1..<height.count {
                array.append(
                    Area(
                        firstIndex: i,
                        endIndex: j,
                        minHeight: min(height[i], height[j])
                    )
                )
            }
        }
        
        return array.sorted(by: { $0.volume < $1.volume }).last?.volume ?? 0
    }
    
    func test() {
        print(maxArea([1, 1]) == 1)
    }
}
