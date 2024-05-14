//
//  ValueReference.swift
//  Подготовка к собесу
//
//  Created by Худышка К on 14.05.2024.
//

import Foundation

class ValueReference {
    struct A {
        var iVar: Int = 0

        init(iVar: Int) {
            self.iVar = iVar
        }
    }

    class TestA: NSCopying {
        var iVar: Int = 0

        init(iVar: Int) {
            self.iVar = iVar
        }
        
        func copy(with zone: NSZone? = nil) -> Any {
            self
        }
    }
    
    init() {}
    
    func test1() {
        let aTest = A(iVar: 90)
        var bTest = aTest

        print(aTest.iVar)
        print(bTest.iVar)

        bTest.iVar = 40

        print(aTest.iVar)
        print(bTest.iVar)
    }
    
    func test2() {
        let aTest = TestA(iVar: 90)
        let bTest = aTest.copy() as! TestA

        print(aTest.iVar)
        print(bTest.iVar)

        bTest.iVar = 40

        print(aTest.iVar)
        print(bTest.iVar)
    }
    
}


