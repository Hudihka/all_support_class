//
//  TestOveride.swift
//  TestBeforeBank
//
//  Created by Худышка К on 26.03.2023.
//

import Foundation

class TestOverrideA {
    init() {
        print("init TestOverrideA")
    }
    
    func testOverrideFunc1() {
        print("testOverrideFunc1")
    }
    
    func testOverrideFunc2() {
        print("testOverrideFunc2")
    }
    
    func testOverrideFunc3() {
        print("testOverrideFunc3")
    }
}

class TestOverrideB: TestOverrideA {
    override init() {
        print("init TestOverrideB")
    }
    
    override func testOverrideFunc1() {
        print("override func testOverrideFunc1")
    }
}

class Base {
    func greet(_ name: String = "Odin") {
        print(name)
    }
}

class Duble: Base {
    override func greet(_ name: String = "Thor") {
        print(name)
    }
}

