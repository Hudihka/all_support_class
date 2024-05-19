//
//  InsertDeleteGetRandom.swift
//  Algoritms
//
//  Created by Худышка К on 03.05.2024.
//

import Foundation

final class InsertDeleteGetRandom: TesterProtocol {
    
    private var set: Set<Int>
    
    init() {
        let arrayTest: [Int] = (0..<10).map({ _ in Int(arc4random() % 30) })
        self.set = Set(arrayTest)
    }
    
    func insert(_ val: Int) -> Bool {
        let value = set.contains(val)
        set.insert(val)
        
        return value
    }
    
    func remove(_ val: Int) -> Bool {
        let value = set.contains(val)
        set.remove(val)
        
        return value
    }
    
    func getRandom() -> Int {
        set.first ?? 0
    }
    
    func test() {
        
    }
}
