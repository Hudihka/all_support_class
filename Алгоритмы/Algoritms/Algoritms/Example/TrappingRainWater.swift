//
//  TrappingRainWater.swift
//  Algoritms
//
//  Created by Худышка К on 05.05.2024.
//

import Foundation

final class TrappingRainWater: TesterProtocol {
    struct Marker {
        let index: Int
        let height: Int
    }
    
    func trap(_ height: [Int]) -> Int {
        let markers = height.enumerated().map({ Marker(index: $0.offset, height: $0.element) })
        
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
    
        spaces = spaces.sorted(by: { $0.index < $1.index})
        
        print(spaces)
        
        return 0
    }
    
//    private func getValue(array: [Marker], marker: Marker, leftPart: Bool) -> Marker? {
//        
//        
//        guard
//            array.count > 1,
//            
//            let firstIndex = array
//                .filter({ leftPart ? $0.index < marker.index : $0.index > marker.index })
//                .firstIndex(where: { $0.height <= marker.height })
//        else {
//            return nil
//        }
//        
//        let value = array[firstIndex]
//        
//        if abs(value.index - marker.index) == 1 {
//            let second = arrayPart(array, index: firstIndex, leftPart: leftPart)
//            
//            if second.isEmpty {
//                return nil
//            }
//            
//            return getValue(array: second, marker: value, leftPart: leftPart)
//        }
//        
//        
//        return value
//    }
    
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
        
//        print(
//            trap([4,2,0,3,2,5]) == 9
//        )
    }
}
