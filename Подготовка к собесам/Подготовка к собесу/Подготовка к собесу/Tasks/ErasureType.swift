//
//  ErasureType.swift
//  Подготовка к собесу
//
//  Created by Худышка К on 14.05.2024.
//

import Foundation

protocol TestProtocol {
    associatedtype T
    
    var value: T { get }
    func set(value: T)
}

struct TestStruct: TestProtocol {
    typealias T = Int
    
    var value: Int {
        0
    }
    
    func set(value: Int) {
        print(value)
    }
}

class ErasureType {}

class ErasureTypeTest {
    var array: [any TestProtocol] = []
    
    private func add(value: any TestProtocol) {
        array.append(value)
    }
    
    func test() {
        add(value: TestStruct())
    }
}
