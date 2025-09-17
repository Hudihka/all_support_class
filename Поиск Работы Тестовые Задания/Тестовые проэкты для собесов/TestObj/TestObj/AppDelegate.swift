//
//  AppDelegate.swift
//  TestObj
//
//  Created by Konstantin I on 03.06.2025.
//

import UIKit

struct Calculator {
    var a: Int
    var b: Int
    
    
    init(a: Int, b: Int) {
        self.a = a
        self.b = b
    }
    
    var calculate: Int {
        a + b
    }
}

//class App {
//    var calc = Calculator(a: 3, b: 4)
//    
//    func run() {
//        // Сохраняем результат заранее, а не обращаемся к calc в момент вызова
//        let result = calc.calculate
//        
//        let clouser = {
//            print("calc \(result)")
//        }
//        
//        calc.b = 10
//        clouser() // Выведет: calc 7
//    }
//}


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }



}



////
////  AppDelegate.swift
////  test
////
////  Created by Константин Ирошников on 30.07.2022.
////
//

// ------------ задача

//enum Custom {
//    case success(Int)
//    case failure
//}
//
//var b = 10
//let result = Custom.success(b)
//b = 5
//
//
//switch result {
//case .success(b):
//    print("success")
//case .failure:
//    print("failure")
//default:
//    print("Default")
//}


// ------------ задача
//struct A {
//    var iVar: Int = 0
//
//    init(iVar: Int) {
//        self.iVar = iVar
//    }
//}
//
//let aTest = A(iVar: 90)
//let bTest = aTest
//
//print(aTest.iVar)
//print(bTest.iVar)
//
//bTest.iVar = 40
//
//print(aTest.iVar)
//print(bTest.iVar)

// ------------ задача

//class TestA: Equatable {
//    var iVar: Int = 0
//
//    init(iVar: Int) {
//        self.iVar = iVar
//    }
//}


// ------------ задача - запустится ли

//struct C {
//    var c: [C]?
//}
//
//class B {
//    var b: B?
//}
//
//struct A {
//    var a: A?
//}

// ------------ задача
//class A {
//    var b: B

//    init(b: B) {
//        self.b = b
//    }
//    deinit {
//        print("A")
//    }
//}
//
//class B {
//    weak var a: A?
//    deinit {
//        print("B")
//    }
//}
//
//var b: B? = B()
//var a: A? = A(b: b!)
//b?.a = a
//b = nil



// ------------ задача

//protocol Drawing: class {
//    func render()
//}
//
//extension Drawing {
//    func circle() { print("protocol") }
//    func render() { circle() }
//}
//
//class SWG: Drawing {
//    func circle() { print("class") }
//}


// ------------ задача

//
//        var clouser: () -> Void = {  }
//
//        var count = 0
//
//        clouser = {
//            print(count)
//        }
//        clouser()
//        count = 10
//        clouser()


// ------------ задача
//class TestA {
//    var iVar: Int
//    
//    init(iVar: Int) {
//        self.iVar = iVar
//    }
//}
//
//////        let test1 = TestA(iVar: 0)
//////        let test2 = TestA(iVar: 1)
//////
//////        let array1 = [test1, test2]
//////        let array2 = array1
//////
//////        array1[0].iVar = 10
//////        print("------------")
//////        print(array2[0].iVar)
//////        print("------------")
///
///
///


// ------------ задача
//var array = [Int]()
//
//for i in 0...500 {
//    let time = Double(arc4random_uniform(50))
//
//    DispatchQueue.main.asyncAfter(deadline: .now() + time) {
//        array.append(i)
//    }
//
//}



// ------------ задача
////
//////class A {
//////    weak var delegate: B?
//////}
//////
//////class B {
//////    weak var delegate: A?
//////}
//////
//////var a: A?
//////var b: B?
//////
//////a = A()
//////b = B()
//////
//////a?.delegate = b
//////b?.delegate = a
//////
//////print(a)
//////print(b)
//////print(a?.delegate)
//////print(b?.delegate)
//////
//////
//////
///




// ------------ задача
///////
//////struct Cat {
//////    var name: String?
//////}
//////
//////struct Dog {
//////    var name: String?
//////}
//////
//////struct Person {
//////    var cat: Cat? {
//////        didSet {
//////            print("didSet cat")
//////        }
//////    }
//////
//////    var dogs: [Dog]? {
//////        didSet {
//////            print("didSet dogs")
//////        }
//////    }
//////}
////



// ------------ задача
//protocol Playable {
//    func play()
//}
//
//extension Playable {
//    func play() {
//        print("play in protocol")
//    }
//
//    func stop() {
//        print("stop in protocol")
//    }
//}
//
//struct Player: Playable {
//    func play() {
//        print("play in struct")
//    }
//}
//
//extension Player {
//    func stop() {
//        print("stop in struct")
//    }
//}
//
//let str = Player()
//str.play()
//str.stop()
////
///
///
///

// ------------ задача

////
////class Object {
////    let identifier: String
////    init(identifier: String) {
////        self.identifier = identifier
////    }
////}
////
////protocol MutableCollectionProtocol {
////    var isEmpty: Bool { get }
////    func push(_ some: Object)
////    func pop() -> Object?
////}
////
////class Stack: MutableCollectionProtocol {
////    private var array = [Object]()
////
////    var isEmpty: Bool { return array.isEmpty }
////
////    func push(_ some: Object) {
////        array.append(some)
////    }
////
////    func pop() -> Object? {
////        return array.popLast()
////    }
////}
////
////class Queue: MutableCollectionProtocol {
////    private var s1 = Stack()
////    private var s2 = Stack()
////
////    var isEmpty: Bool { fatalError() }
////
////    func push(_ some: Object) {
////        fatalError()
////    }
////
////    func pop() -> Object? {
////        fatalError()
////    }
////}
////

// ------------ задача
////
////  DispatchQueue.main.async {
////      DispatchQueue.global.sync {
////          print(222)
////      }
////  }
////*/
////  class SomeClass {
////      var name: String
////      var count: Int
////
////      init(name: String, count: Int) {
////          self.name = name
////          self.count = count
////      }
////  }
////
////  struct SomeStruct {
////      var name: String
////      var count: Int
////
////      init(name: String, count: Int) {
////          self.name = name
////          self.count = count
////      }
////  }
////
//////  var arr1 = [SomeClass(name: "name1", count: 1),
//////              SomeClass(name: "name2", count: 2),
//////              SomeClass(name: "name3", count: 3)
//////  ]
//////
//////  var arr2 = [SomeStruct(name: "name1", count: 1),
//////              SomeStruct(name: "name2", count: 2),
//////              SomeStruct(name: "name3", count: 3)
//////  ]
////
//////  let arr3 = arr1
//////  let arr4 = arr2
////
////  //arr1.last?.name = "newname"
//////  arr1.popLast()
//////  arr3.forEach {
//////      print($0.name)
//////  }

// ------------ задача


//class Abc {
//    private func test1(){
//        print(2)
//
//        DispatchQueue.global().async {
//            print(3)
//
//            DispatchQueue.main.async {
//                print(4)
//            }
//
//            print(5)
//        }
//
//        print(6)
//    }
//
//
//    private func test2(){
//        print(2)
//
//        DispatchQueue.main.async {
//            print(3)
//
//            DispatchQueue.main.async {
//                print(4)
//            }
//
//            print(5)
//        }
//
//        print(6)
//    }
//
//
//
//    private func test3(){
//        print(2)
//
//        DispatchQueue.main.async {
//            print(3)
//
//            DispatchQueue.main.sync {
//                print(4)
//            }
//
//            print(5)
//        }
//
//        print(6)
//    }
//
//    private func test4(){
//        print(2)
//
//        DispatchQueue.global().async {
//            print(3)
//
//            DispatchQueue.global().async {
//                print(4)
//            }
//
//            print(5)
//        }
//
//        print(6)
//    }
//
//    private func test5(){
//        print(2)
//
//        DispatchQueue.global().async {
//            print(3)
//
//            DispatchQueue.global().sync {
//                print(4)
//            }
//
//            print(5)
//        }
//
//        print(6)
//    }
//
//
//    DispatchQueue.global().async {
//        print(3)
//
//        DispatchQueue.main.async {
//            print(4)
//        }
//
//        print(5)
//    }
//}


// ------------ задача
////}
////
////
////struct Test {
////    var testValue = 0
////}
////
////let test1 = Test()
////let test2 = test1
////
////print(test1.testValue)
////print(test2.testValue)
////
////test2.testValue = 1
////
////print(test1.testValue)
////print(test2.testValue)



// ------------ задача
//struct Person {
//    var age: Int
//}
//////
//var testArray = [
//    Person(age: 40),
//    Person(age: 21),
//    Person(age: 20),
//    Person(age: 22),
//    Person(age: 10),
//    Person(age: 17),
//    Person(age: 80),
//    Person(age: 40)
//]
//////
//////
//enum Test {
//    case a(value: Int)
//    case b(value: Int)
//    case c
//}
//
//let testC1 = Test.a(value: 7)
//let testC2 = Test.c
//
//if testC1 == testC2 {
//    print("11")
//} else {
//    print("22")
//}

//var array = [Int]()
//for i in 0...500 {
//    DispatchQueue.global().async {
//        self.array.append(i)
//    }
//}


// ------------ задача
///*
// // упростить функцию
// func bestAnimals(from animalsInfo: [String: [String]]) -> [String] {
//     var animals = [String]()
//
//     for (key, _) in animalsInfo {
//         guard let info = animalsInfo[key] else {
//                 continue
//         }
//
//         animals.append(contensOf: info.sorted(by: {(lhs: String, rhs: String) -> Bool in
//             return lhs > rhs
//         }))
//     }
//
//     animals = animals.compactMap { animal in
//         return animal.count > 3 ? animal : nil
//     }.sorted(by: <)
//
//
//     return animals
// }
//


// ------------ задача

/*
white
______________________________________________________
|                                                        |
|     systemBlue                                         |
|                                                        |
|                                                        |
|        ________________________                    |
|        |XXXXXXXXXXXXXXXXXXXXXXXXXX|                    |
|        |XXXXXXXXXXXXXXXXXXXXXXXXXX|                    |
|        |XXXX  systemRed  XXXXXXXXX|                    |
|        |XXXXXXXXXXXXXXXXXXXXXXXXXX|                    |
|        |XXXXXXXXXXXXXXXXXXXXXXXXXX|                    |
|        |XXXXXXXXXXXXXXXXXXXXXXXXXX|                    |
|________|XXXXXXXXXXXXXXXXXXXXXXXXXX|____________________|
         |XXXXXXXXXXXXXXXXXXXXXXXXXX|
         |XXXXXXXXXXXXXXXXXXXXXXXXXX|
         |XXXXXXXXXXXXXXXXXXXXXXXXXX|
         |XXXX|                 |XXX|
         |XXXX|  systemYellow   |XXX|
         |XXXX|                 |XXX|
         |XXXX|                 |XXX|
         |XXXX|                 |XXX|
         |XXXX|_________________|XXX|
         |XXXXXXXXXXXXXXXXXXXXXXXXXX|
         |XXXXXXXXXXXXXXXXXXXXXXXXXX|


view.backgroundColor = .white

blueView = UIView(frame: CGRect(x: 50, y: 250, width: 300, height: 200))
blueView.backgroundColor = .systemBlue
view.addSubview(blueView)

redView = UIView(frame: CGRect(x: 50, y: 50, width: 150, height: 350))
redView.backgroundColor = .systemRed
blueView.addSubview(redView)

yellowView = UIView(frame: CGRect(x: 50, y: 200, width: 50, height: 50))
yellowView.backgroundColor = .systemYellow
redView.addSubview(yellowView)

override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let touch = touches.first else { return }

    if touch.view === blueView { print("Blue view") }
    if touch.view === redView { print("Red view") }
    if touch.view === yellowView { print("Yellow view") }

    if ![redView, redView, yellowView].contains(touch.view) {
        print("Background view")
    }
}
 */


/*
 
 var count = 0
 let group = DispatchGroup()
 let semaphore = Semaphore(value: 1)

 group.enter()
 let thread1 = Thread {
     for _ in 0...999 {
         semaphore.wait()
         count += 1
         semaphore.signal()
     }
     group.leave()
 }


 group.enter()
 let thread2 = Thread {
     for _ in 0...999 {
         semaphore.wait()
         count += 1
         semaphore.signal()
     }
     group.leave()
 }


 thread1.start()
 thread2.start()

 group.notify(queue: .global()) {
     print(count)
 }
 
 */

//-------------------- задача

/*
 
 let main = DispatchQueue.main
 let serial = DispatchQueue(label: "serial")
 let concurrent = DispatchQueue(label: "concurrent", attributes: .concurrent)

 main.async {
     print(1)
 }

 main.async {
     print(2)
     
     serial.async {
         print(3)
     }
     
     serial.sync {
         print(4)
         
         concurrent.sync {
             print(5)
             
             concurrent.sync {
                 print(6)
             }
             
             serial.sync {
                 print(7)
             }
         }
         
     }
     
 }
 
 serial.sync {
     print(8)
 }
 
 */

//----------- задача


/*
 
 enum Optional<T> {
     case some(_ value: T)
     case none
     
     init(_ value: T) {
         self = .some(value)
     }
 }

 extension Optional: ExpresibleByNilLiteral {
     init(nilLiteral: ()) {
         self = .none
     }
 }

 extension Optional: Equatable where T: Equatable {
     public static ==(lhs: Self, rhs: Self) -> Bool {
         switch (lhs, rhs) {
             case (.none, .none):
                 return true
             case (.some(let value1), .some(let value2)):
                 return value1 == value2
             default:
                return false
         }
     }
 }

 //----------- задача

 let a: Optional<Int> = nil
 let b: Optional<Int> = Optional(5)

 if a == b {
     print("they're equal")
 }

 final class B {}

 let b1: Optional<B>
 let b2: Optional<B>


 //----------- задача


 protocol Weapon {
     associatedtype Kind: Equatable
     func getKind() -> Kind
 }
  
 func compareContainerValue<C1: Weapon, C2: Weapon>(container1: C1, container2: C2) -> Bool {
     container1.getKind() == container2.getKind()
 }

 final class A: Weapon {
     typealias Kind = Int
     func getKind() -> Int { 1 }
 }

 compareContainerValue(A(), A())
 

 //----------- задача

 protocol Fooable {
     func foo()
 }

 func func1<T: Fooable>(_ arg: T) {
     arg.foo()
 }

 func func2(_ arg: Fooable) {
     arg.foo()
 }

 final class A: Fooable {
     func foo() {}
 }

 let a: Fooable = A()

 func1(a)
 func2(a)


 //----------- задача

 // 80 GB

 //var array = Array((0...10_000_000_000))
 var array: [Int] = [0, 1, 2]  // 3

 for i in 3...10_000_000_000 { // Условно много раз добавляем в конце элементы
     array.append(i)  // +1
 }



 let dict = ["one": 1, "two": 2, "three": 3]
 let dictArbitraryPair = dict["one"]  // O(1) -> O(n)


 struct A: Hashable {
     let a1: Int
     let a2: Int
 }

 protocol Hashable: Equatable {}

 //----------- задача

 /// -------


 var elements = [1,2,3]

 for e in elements {
     print(e)
     elements = [4,5,6]
 }



 // 1 2 3


 var numbers = [1, 2, 3, ]
 for num in numbers {
     print(num)
     numbers.append(num * 2)
 }

 // 1 2 3


 struct A {
     let b: B
 }

 final class B {}

 /// ---------- задача



 class TestClass {
     var name = ""
     var block1: (()->Void)?
     var block2: (()->Void)?

     func test() {
         self.block1 = { [weak self] in
             guard let self else {
                 return
             }
         
             block2 = { [weak self] in
                 print(self)
             }
             
             
             block2?()
         }
         self.block1?()
     }

     deinit {
         print("deinit")
     }
 }
 
 
 */
