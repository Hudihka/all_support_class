//
//  TestClass.swift
//  TestObj
//
//  Created by Konstantin I on 22.06.2025.
//

import Foundation

class TestClass {
    var name = "00"
    var block1: (()->Void)?
    var block2: (()->Void)?

    func test() {
        self.block1 = { [weak self] in
        
            self?.block2 = { [weak self] in
                print(self?.name)
            }
            
            
            self?.block2?()
        }
        
        
        self.block1?()
    }

    deinit {
        print("------- deinit")
    }
}
