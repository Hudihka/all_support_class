//
//  GCD.swift
//  Подготовка к собесу
//
//  Created by Худышка К on 14.05.2024.
//

import Foundation

class GCD {
    
    func test1(){
        print(2)
        
        DispatchQueue.global().async {
            print(3)
            
            DispatchQueue.main.async {
                print(4)
            }
            
            print(5)
        }
        
        print(6)
    }
    
    
    func test2(){
        print(2)
        
        DispatchQueue.main.async {
            print(3)
            
            DispatchQueue.main.async {
                print(4)
            }
            
            print(5)
        }
        
        print(6)
    }
    
    func test3(){
        print(2)
        
        DispatchQueue.main.async {
            print(3)
            
            DispatchQueue.main.sync {
                print(4)
            }
            
            print(5)
        }
        
        print(6)
    }
    
    func test4(){
        print(2)
        
        DispatchQueue.global().async {
            print(3)
            
            DispatchQueue.global().async {
                print(4)
            }
            
            print(5)
        }
        
        print(6)
    }
    
    func test5(){
        print(2)
        
        DispatchQueue.global().async {
            print(3)
            
            DispatchQueue.global().sync {
                print(4)
            }
            
            print(5)
        }
        
        print(6)
    }
    
    func test6() {
        print(2)
        
        DispatchQueue.global().async {
            print(3)
            
            DispatchQueue.main.async {
                print(4)
            }
            
            print(5)
        }
        
        print(7)
    }
    
    func test7() {
        
//        let queue = DispatchQueue.global()
        let queue = DispatchQueue(label: "test.gcd.label.test7", attributes: [.concurrent])
        
        queue.async(flags: [.barrier]) {
            self.testPrint(symbol: "0")
        }
        
        queue.async {
            self.testPrint(symbol: "1")
        }
        
        queue.async {
            self.testPrint(symbol: "2")
        }
        
        
//        for i in 0...500 {
//            queue.async {
//                print(i)
//            }
            
//            let time = Double(arc4random_uniform(100)) / 100
//            DispatchQueue.main.asyncAfter(deadline: .now() + time, flags: [.barrier]) {
//                print(i)
//            }
//        }
    }
    
    func testSemafore() {
        let queue = DispatchQueue.global()
        
        let semafore = DispatchSemaphore(value: 1)
        
        semafore.wait()
        queue.async {
            self.testPrint(symbol: "0")
            semafore.signal()
        }
        
        semafore.wait()
        queue.async {
            self.testPrint(symbol: "1")
            semafore.signal()
        }
        
        semafore.wait()
        queue.async {
            self.testPrint(symbol: "2")
            semafore.signal()
        }
    }
    
    func test8() {
        // A E B F H C D G I
        // A E B C D F H G I
        
        print("A")
        DispatchQueue.main.async {
            print("B")
            DispatchQueue.global().sync {
                print("C")
            }
            
            DispatchQueue.main.async {
                print("D")
            }
        }
        
        print("E")
        
        DispatchQueue.main.async {
            print("F")
            
            DispatchQueue.main.async {
                print("G")
            }
            
            print("H")
            
            DispatchQueue.main.async {
                print("I")
            }
        }
        
    }
    
    func test() {}
}

private extension GCD {
    func testPrint(symbol: String) {
        for i in 0...10 {
            print("\(symbol)-\(i)")
        }
    }
}
