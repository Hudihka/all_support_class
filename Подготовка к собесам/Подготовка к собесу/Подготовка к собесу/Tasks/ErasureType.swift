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

struct TestStruct0: TestProtocol {
    typealias T = Int
    
    var value: Int {
        0
    }
    
    func set(value: Int) {
        print(value)
    }
}

struct TestStruct1: TestProtocol {
    typealias T = Int
    
    var value: Int {
        1
    }
    
    func set(value: Int) {
        print(value)
    }
}

class AnyTestProtocol<T>: TestProtocol {
    private var _value: T
    
    var value: T {
        _value
    }
    
    func set(value: T) { }
    
    init<U: TestProtocol>(_ base: U) where U.T == T {
        _value = base.value
    }
}




class ErasureTypeTest {
//    var array: [ErasureTest] = []
//    
//    private func add(value: ErasureType) {
//        array.append(value)
//    }
//    
//    func test() {
//        add(value: ErasureTest)
//        add(value: <#T##ErasureType#>)
//        
//        array.forEach({ print($0.value) })
//    }
}
