//
//  Clousers.swift
//  TestBeforeBank
//
//  Created by Худышка К on 26.03.2023.
//

import Foundation

// пример из говнобанка

class Awesome {
    var text = "A"
}

class ClouserExample1 {
    func test() {
        var firstObj: Awesome? = Awesome()
        var secondObj: Awesome? = firstObj
        
        firstObj?.text = "R"
        
//        let closure = { [firstObj]
////            firstObj?.text = "C"
//            print(firstObj?.text)
//        }
        
//        closure()
        firstObj = nil
//        closure()
        print(firstObj?.text)
        print(secondObj?.text)
    }
    
    func test2() {
        var firstObj: Awesome? = Awesome()
        var secondObj: Awesome? = firstObj
        
        let closure = {
            print(firstObj?.text)
        }
        
        firstObj?.text = "C"
        closure()
        firstObj = nil
        closure()
//        print(secondObj)
    }
}

class ClouserExampleClass {
    var test = "0"
}

class ClouserExampleStruct {
    var test = "0"
}

class ClouserExample4 {
    
    func test1() {
        var clouser: () -> Void = {  }

        var count = ClouserExampleClass()

        clouser = { [count] in
            print(count.test)
        }
        clouser()
        count.test = "1"
        clouser()
    }
    
    func test2() {
        var clouser: () -> Void = {  }

        var count = ClouserExampleStruct()

        clouser = { [count] in
            print(count.test)
        }
        clouser()
        count.test = "1"
        clouser()
    }
}

class ClouserExample2 {
    
    func texst() {
        var clouser: () -> Void = {  }

        var count = 0

        clouser = { [count] in
            print(count)
        }
        clouser()
        count = 10
        clouser()
    }
}

class ClouserExample3 {
    var score = 11
    
    func addScore(_ point: Int) {
        calculate(value: point)
        calculate(value: score)
        print(score)
////        score = calculate(point
////        score = calculate(point)
//
//        print(score)
//        print(calculate(score))
//        return calculate(score)
    }
    
    func calculate(value: Int) {
        score = score + value
    }
}
