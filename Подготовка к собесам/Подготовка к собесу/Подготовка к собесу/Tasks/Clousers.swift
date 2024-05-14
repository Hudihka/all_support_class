//
//  Clousers.swift
//  Подготовка к собесу
//
//  Created by Худышка К on 14.05.2024.
//

import Foundation

class Clousers {
    class Test {
        var count = 0
    }
    
    
    var clouser: () -> Void = {  }
    
    var count = Test()
    
    func test() {
        clouser = {
            print(self.count.count)
        }
        clouser()
        count.count = 10
        clouser()
    }
}
