//
//  Lock.swift
//  Подготовка к собесу
//
//  Created by Худышка К on 14.05.2024.
//

import Foundation

struct LockStruct {
    let lock = NSLock()
    
    func make() {
        lock.lock()
        
        for i in 0...20 {
            print(i)
        }
        
        lock.unlock()
    }
}

class Lock {
    let str = LockStruct()
    
    func test() {
        let queue = DispatchQueue.global()
        
        print("------")
        queue.sync {
            str.make()
        }
        print("------1")
        queue.async {
            self.str.make()
        }
        print("------2")
    }
}
