//
//  TrappingRainWater.swift
//  Algoritms
//
//  Created by Худышка К on 05.05.2024.
//

import Foundation

// https://leetcode.com/problems/trapping-rain-water/?envType=study-plan-v2&envId=top-interview-150

final class TrappingRainWater: TesterProtocol {
    struct Marker {
        let index: Int
        let height: Int
    }
    
    private var markers = [Marker]()
    
    func trap(_ height: [Int]) -> Int {
        markers = height.enumerated().map({ Marker(index: $0.offset, height: $0.element) })
        
        guard 
            let maxHeight = markers.map({ $0.height }).max(),
            maxHeight != 0,
            let firstIndex = markers.firstIndex(where: { $0.height == maxHeight })
        else {
            return 0
        }
        
        let arrayHeights = Array(stride(from: maxHeight, through: 1, by: -1))
        
        var localMaxMarket = markers[firstIndex]
        var spaces = [localMaxMarket]
        
        var arraySide = arrayPart(markers, index: firstIndex, leftPart: true)
        
        for i in arrayHeights {
            if
                localMaxMarket.index != 0,
                let first = arraySide.filter({ $0.height == i }).first,
                first.index < localMaxMarket.index
            {
                localMaxMarket = first
                spaces.append(first)
            }
        }
        
        localMaxMarket = markers[firstIndex]
        arraySide = arrayPart(markers, index: firstIndex, leftPart: false)
        
        for i in arrayHeights {
            if
                localMaxMarket.index != markers.count - 1,
                let last = arraySide.filter({ $0.height == i }).last,
                last.index > localMaxMarket.index
            {
                localMaxMarket = last
                spaces.append(last)
            }
        }
    
        let indexses = spaces.sorted(by: { $0.index < $1.index})
            .map({ $0.index })
        
        if indexses.count < 2 {
            return 0
        }
        
        var volume = 0
        
        for i in 0...indexses.count - 2 {
            let from = indexses[i]
            let to = indexses[i+1]
            
            volume += volumeBetwin(from: from, to: to)
        }
        
        return volume
    }
    
    private func volumeBetwin(from: Int, to: Int) -> Int {
        if to - from < 2 {
            return 0
        }
        
        let fromMarker = markers[from]
        let toMarker = markers[to]
        
        let width = to - from
        let height = min(fromMarker.height, toMarker.height)
        
        var volume = width * height
    
        for i in from..<to {
            let newHeight = min(markers[i].height, height)
            volume -= newHeight
        }
        
        return volume
    }
    
    private func arrayPart(_ array: [Marker], index: Int, leftPart: Bool) -> [Marker] {
        if index == 0 || index >= array.count {
            return []
        }
        
        if leftPart {
            return (0..<index).map({ array[$0] })
        } else {
            return (index+1..<array.count).map({ array[$0] })
        }
    }
    
    func test() {
        print(
            trap([0,1,0,2,1,0,1,3,2,1,2,1]) == 6
        )
    }
}
