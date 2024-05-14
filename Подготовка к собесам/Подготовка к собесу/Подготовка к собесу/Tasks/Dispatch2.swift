//
//  Dispatch2.swift
//  Подготовка к собесу
//
//  Created by Худышка К on 14.05.2024.
//

import Foundation

protocol SomeProtocol {
    var someProperty: Int { get set }
}

class SomeClass: SomeProtocol {
    var someProperty: Int = 0
}

struct SomeStruct: SomeProtocol {
    var someProperty: Int = 0
}

class Dispatch2 {
    func foo(someArgument: inout SomeProtocol) {
        someArgument.someProperty = 10
    }
}
