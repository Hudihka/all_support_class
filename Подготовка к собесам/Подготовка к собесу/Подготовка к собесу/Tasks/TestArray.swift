//
//  TestArray.swift
//  Подготовка к собесу
//
//  Created by Худышка К on 14.05.2024.
//

import Foundation

class TestArray {
    class OBJ {
        var value: String = "value"
        
        init(value: String) {
            self.value = value
        }
    }
    
    var test1 = [OBJ(value: "value0"), OBJ(value: "value1"), OBJ(value: "value2")]
    var test2 = [OBJ(value: "value0"), OBJ(value: "value1"), OBJ(value: "value2")]
    
    func test() {
        let objTest1 = OBJ(value: "value3")
        let objTest2 = objTest1
        
        test1.append(objTest1)
        test2.append(objTest2)
        
        objTest1.value = "valueChange"
        
        print(objTest1.value)
        print(objTest2.value)
        print("----------------")
        print(test1.last?.value)
        print(test2.last?.value)
    }
}
