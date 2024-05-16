//
//  GCD2.swift
//  Подготовка к собесу
//
//  Created by Худышка К on 16.05.2024.
//

import Foundation

class GCD2 {
    
    func test1() {
        print("1")
        
        DispatchQueue.global().async {
            print("2")
            DispatchQueue.main.sync {
                print("3")
            }
            print("4")
        }
        
        print("5")
        
        DispatchQueue.main.async {
            print("6")
            DispatchQueue.global().sync {
                print("7")
            }
            print("8")
        }
        
        print("9")
        
        // 1 5 9 2 3 4 6 7 8
    }
    
    func test2() {
        
        DispatchQueue.global().async {
            print("A")
            DispatchQueue.global().async {
                print("B")
                DispatchQueue.main.sync {
                    print("C")
                }
                print("D")
            }
            print("E")
            DispatchQueue.main.async {
                print("F")
            }
        }
        
        print("G")
        DispatchQueue.main.async {
            print("H")
        }

        // G A H E B F D C
    }
    
    func test3() {
        print("Start")
        DispatchQueue.main.async {
            print("1")
            DispatchQueue.main.sync {
                print("2")
            }
            print("3")
        }
        print("End")
    }
    
    func test4() {
        DispatchQueue.global().async {
            print("X")
            DispatchQueue.global(qos: .userInitiated).sync {
                print("Y")
            }
            DispatchQueue.main.async {
                print("Z")
            }
        }
        
        DispatchQueue.global(qos: .background).async {
            print("W")
        }
        
        print("Done")
        // x z y w
    }
    
    func test5() {
        DispatchQueue.global().async {
            print("First")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                print("Second")
            }
            print("Third")
            DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
                print("Fourth")
            }
        }
        print("Fifth")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            print("Sixth")
        }

    }
    
    func test6() {
        DispatchQueue.main.async {
            print("A1")
            DispatchQueue.global().sync {
                print("A2")
            }
            print("A3")
        }
        DispatchQueue.global().async {
            print("B1")
            DispatchQueue.main.sync {
                print("B2")
            }
            print("B3")
        }
        print("C1")
        DispatchQueue.main.sync {
            print("C2")
        }
        print("C3")

    }
}
