//
//  TestGCD.swift
//  TestBeforeBank
//
//  Created by Худышка К on 26.03.2023.
//

import Foundation

class TestGCD {
    
    func test1() {
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
        
        DispatchQueue.main.async(flags: .noQoS) {
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
    
    func testExtra1() {
        print(2)
        
        DispatchQueue.global().sync {
            print(3)
            
            DispatchQueue.main.async {
                print(4)
            }
            
            print(5)
        }
        
        print(6)
    }
    
    let semafore = DispatchSemaphore(value: 1)
    
    func testSprtiol() {
//        semafore.
//        let backgroundQueue = DispatchQueue.global().async {
//
//        }
//
//        backgroundQueue.suspend()
//
//        backgroundQueue.resume()
    }
}

var array = [Int]()

DispatchQueue.global().async {
    for i in 0...1000{
        array.append(i)
    }
}

DispatchQueue.global().async {
    for i in 0...1000{
        array.append(i)
    }
}
