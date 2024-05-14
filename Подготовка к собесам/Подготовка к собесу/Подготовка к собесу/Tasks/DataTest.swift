//
//  DataTest.swift
//  Подготовка к собесу
//
//  Created by Худышка К on 14.05.2024.
//

import Foundation

//struct ATest {
//    var a: [ATest]?
//}
//
//    class B {
//        var b: B?
//    }

class DataTest {
    
    class A {
        var b: B
        
        init(b: B) {
            self.b = b
        }
        
        deinit {
            print("A")
        }
    }
    
    class B {
        weak var a: A?
        
        deinit {
            print("B")
        }
    }
    
    func test1() {
        var b: B? = B()
        var a: A? = A(b: b!)
        
        b?.a = a
        b = nil
    }
    
}
