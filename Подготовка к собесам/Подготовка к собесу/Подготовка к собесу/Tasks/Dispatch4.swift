//
//  Dispatch4.swift
//  Подготовка к собесу
//
//  Created by Худышка К on 16.05.2024.
//

import Foundation

class Dispatch4 {
    
    func test1() {
        class MyClass {
            func method() {
                print("MyClass method")
            }
        }

        class MySubclass: MyClass {
            override func method() {
                print("MySubclass method")
            }
        }

        let obj = MySubclass()
        obj.method()
    }
    
    
    func test2() {
        class MyClass {
            func method() {
                print("MyClass method")
            }
        }

        class MySubclass: MyClass {
            override func method() {
                print("MySubclass method")
            }
        }

        let obj: MyClass = MySubclass()
        obj.method()

    }
    
    func test3() {
//        class MyClass {
//            func method() {
//                print("MyClass method")
//            }
//        }
//
//        class MySubclass: MyClass {
//            override func method() {
//                print("MySubclass method")
//            }
//        }
//
//        let obj: AnyObject = MySubclass()
//        obj.method()
    }
    
    func test4() {
        class MyClass {
            func method() {
                print("MyClass method")
            }
        }

        class MySubclass: MyClass {
            override func method() {
                print("MySubclass method")
            }
        }

        let obj: AnyObject = MySubclass()
        (obj as! MySubclass).method()

    }
    
    func test5() {
        class MyClass {
            func method() {
                print("MyClass method")
            }
        }

        class MySubclass: MyClass {
            override func method() {
                print("MySubclass method")
            }
        }

        let obj: AnyObject = MySubclass()
        (obj as? MySubclass)?.method()

    }
    
    func test6() {
        class MyClass {
            func method() {
                print("MyClass method")
            }
        }

        class MySubclass: MyClass {
            override func method() {
                print("MySubclass method")
            }
        }

        let obj: AnyObject = MyClass()
        (obj as? MySubclass)?.method()
    }
}
