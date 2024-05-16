//
//  Deffer.swift
//  Подготовка к собесу
//
//  Created by Худышка К on 16.05.2024.
//

import Foundation

class Deffer {
    
    func run() -> String {
        var result = ""
        result += "A"
        
        
        defer {
            result += "B"
        }
        
        result += "C"
        
        if true {
            defer {
                result += "D"
            }
            result += "E"
        }
        
        return result
    }
    
    func run2() {
      var result = "A"
        
      let closure = { [result] in
        print(result)
      }
        
      closure()
      result = "B"
      closure()
        
    }
    
    func test() {
//        print(run()) //ACEDBA
        print(run2()) //ACEDBA
    }
}
