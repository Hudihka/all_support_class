//
//  ValueType.swift
//  TestBeforeBank
//
//  Created by Худышка К on 26.03.2023.
//

import Foundation

class ValueType {

    
    func test() {
        var arraysClass1 = [CarClass(speed: 0), CarClass(speed: 1), CarClass(speed: 2)]
        var arraysClass2 = arraysClass1
        
        arraysClass1[0].speed = 10
        
        print(arraysClass1[0].speed)
        print(arraysClass2[0].speed)
        
        let cl = CarClass(speed: 20)
        arraysClass1[0] = cl
        
        print(arraysClass1[0].speed)
        print(arraysClass2[0].speed)
    }
    
    func test2() {
        let str: CarStruct? = nil

    }
}

struct CarStruct {
    var speed: Int
    var car: CarStruct?
    
    init(speed: Int) {
        self.speed = speed
    }
}

class CarClass {
    var speed: Int
    
    init(speed: Int) {
        self.speed = speed
    }
}
