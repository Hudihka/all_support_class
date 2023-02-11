//
//  TestDiagonaleArray.swift
//  test
//
//  Created by Константин Ирошников on 23.10.2022.
//

import Foundation

final class TestDiagonaleArray {
    private var array = [
        [1,  2,  3,  4],
        [5,  6,  7,  8],
        [9,  10, 11, 12],
        [13, 14, 15, 16]
    ]

    func testPrint() {
        for i in 0...array.count - 1 {
            print(createArrayBefore(i))
        }

        for i in 0...array.count - 2 {
            print(createArrayAfter(i))
        }
    }

    func createArrayBefore(_ forIndex: Int) -> [Int] {

        var returnArray = [Int]()
        for i in 0...forIndex {
            let element = array[forIndex - i][i]
            returnArray.append(element)
        }

        return returnArray
    }


    func createArrayAfter(_ forIndex: Int) -> [Int] {
        let count = array.count - 1 - forIndex
        var returnArray = [Int]()

        for i in 1...count {
            let firstIndex = array.count - i
            let lastIndex = i + forIndex
            let element = array[firstIndex][lastIndex]
            returnArray.append(element)
        }

        return returnArray
    }

}
