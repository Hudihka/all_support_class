////
////  AppDelegate.swift
////  test
////
////  Created by Константин Ирошников on 30.07.2022.
////
//
//enum Custom {
//    case success(Int)
//    case failure
//}
//
var b = 10
let result = Custom.success(b)
b = 5


switch result {
case .success(b):
    print("success")
case .failure:
    print("failure")
default:
    print("Default")
}
//
////
////import UIKit
////
struct A {
    var iVar: Int = 0

    init(iVar: Int) {
        self.iVar = iVar
    }
}

        let aTest = A(iVar: 90)
        let bTest = aTest

        print(aTest.iVar)
        print(bTest.iVar)

        bTest.iVar = 40

        print(aTest.iVar)
        print(bTest.iVar)

//class TestA: Equatable {
//    var iVar: Int = 0
//
//    init(iVar: Int) {
//        self.iVar = iVar
//    }
//}

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


//protocol SomeProtocol {
//    var someProperty: Int { get set }
//}
//
//class SomeClass: SomeProtocol {
//    var someProperty: Int = 0
//}
//
//struct SomeStruct: SomeProtocol {
//    var someProperty: Int = 0
//}
//
//func foo(someArgument: SomeProtocol) {
//    someArgument.someProperty = 10
//}

protocol Drawing: class {
    func render()
}

extension Drawing {
    func circle() { print("protocol") }
    func render() { circle() }
}

class SWG: Drawing {
    func circle() { print("class") }
}

class TestArray {
    var name: String

    init(name: String) {
        self.name = name
    }
}

//protocol ATestProtocol {
//    var id: String { get }
//}
//
//struct Test: ATestProtocol {
//    var id: String
//}
//
//
//
//@main
//class AppDelegate: UIResponder, UIApplicationDelegate {
//    func generateBonusesMask(count: Int) -> String {
//        let str = String(repeating: "9", count: count)
//        guard let formated = Int(str)?.formatWithSpace else {
//            return "0"
//        }
//
//        return formated.replacingOccurrences(of: "9", with: "0")
//    }
//
//
//
//
//    func equalGeneric<T: ATestProtocol>(lhs: T, rhs: T) -> Bool {
//        lhs.id == rhs.id
//    }
//
//    func equal(lhs: ATestProtocol, rhs: ATestProtocol) -> Bool {
//        lhs.id == rhs.id
//    }
//
//    func application(
//        _ application: UIApplication,
//        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
//    ) -> Bool {
//
//        for i in 0...20 {
//            print(generateBonusesMask(count: i))
//        }
//
//        print("------------------------------------------------------")
//        print(AnalyticsEvent.generateTextOfEvent(postfix: AnalyticsEvent.New.dynamicqrPaymentHistory))
//        let test1 = Test(id: "1")
//        let test2 = Test(id: "1")
//
//        print(equal(lhs: test1, rhs: test2))
//        print(equalGeneric(lhs: test1, rhs: test2))
//
//
        var clouser: () -> Void = {  }

        var count = 0

        clouser = {
            print(count)
        }
        clouser()
        count = 10
        clouser()
//
//
//        let vc = ViewController()
//        print("1")
//        let b = vc.view
//        print("7")
////
////        print("----------------------")
//
////        let obj1 = TestArray(name: "pupa")
////        let obj2 = TestArray(name: "lupa")
////
////        var array1 = [obj1, obj2]
////        var array2 = array1
////
////        array2[0].name = "0000"
////
////        print("-----------------")
////        print(array1[0].name)
////        print(array2[0].name)
////
////        array1.append(TestArray(name: "pppppp"))
////
////        print(array1)
////        print(array2)
//
//
////        SWG().render()
////
////
//////        print(2)
//////
//////        DispatchQueue.global().sync {
//////                    print(3)
//////
//////                    DispatchQueue.main.async {
//////                        print(4)
//////                    }
//////
//////                    print(5)
//////                }
//////
//////        print(6)
//////        print(6)
//////        print(6)
//////        print(6)
//////        print(6)
//////        print(6)
////
////
//////        print("0".unicode)
////
//////        arc4random_
////        let VC = ViewController()
////        print("1")
////        let _ = VC.view
////        print(4)
//////////
////
//////
//////
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
////
////        return true
////    }
////
////    // MARK: UISceneSession Lifecycle
////
////    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
////        // Called when a new scene session is being created.
////        // Use this method to select a configuration to create the new scene with.
////        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
////    }
////
////    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
////        // Called when the user discards a scene session.
////        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
////        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
////    }
////
////    func arraySorted(array1: [Int], array2: [Int]) -> [Int] {
////        var result = [Int]()
////        var i = 0
////        var j = 0
////        var k = 0
////
////        while(i < array1.count && j < array2.count) {
////            if array1[i] < array2[j] {
////                result.append(array1[i])
////                i += 1
////            } else {
////                result.append(array2[j])
////                j += 1
////            }
////
////            k += 0
////        }
////
////        while(i < array1.count) {
////            print(array1[i])
////            result.append(array1[i])
////            i += 1
////        }
////
////        while(j < array2.count) {
////            result.append(array2[j])
////            j += 1
////        }
////
////        return result
////    }
////
////
////}
////
/////*
////
////         static int[] Merge(int[] first, int[] second) {
////             if(first == null || second == null) throw new ArgumentException();
////             int i = 0, j = i, k = i;
////             var result = new int[first.Length + second.Length];
////
////             while(i< first.Length && j<second.Length) {
////                 result[k++] = first[i] < second[j] ? first[i++] : second[j++];
////             }
////             while(i < first.Length) {
////                 result[k++] = first[i++];
////             }
////             while(j < second.Length) {
////                 result[k++] = second[j++];
////             }
////             return result;
////         }
////
////
////         static void Main(string[] args) {
////             int[] A = { 1, 4, 6, 7 }, B = { 2, 3, 5 };
////             var result = Merge(A, B);
////             Console.WriteLine(string.Join(" ",result));
////         }
//// */
////
////
////
////
var array = [Int]()

for i in 0...500 {
    let time = Double(arc4random_uniform(500))

    DispatchQueue.main.asyncAfter(deadline: .now() + time) {
        array.append(i)
    }

}
////
////
/////// задача 1
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
///////// задача 2
//////
//////func print(addres o: UnsafeRawPointer) {
//////    print(String(format: "%p", Int(bitPattern: o)))
//////}
//////
//////var array1 = [0, 1, 2, 3]
//////var array2 = array1
//////
//////print(array1)
//////print(array2)
////
////
/////// задача 3
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
////
/////// задача 4
///////
protocol Playable {
    func play()
}

extension Playable {
    func play() {
        print("play in protocol")
    }

    func stop() {
        print("stop in protocol")
    }
}

struct Player: Playable {
    func play() {
        print("play in struct")
    }
}

extension Player {
    func stop() {
        print("stop in struct")
    }
}

let str = Player()
str.play()
str.stop()
////
/////// задача 5
////
////
////
/////// задача 6
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
//////var queue = Queue()
//////queue.push(Object(identifier: "1"))
//////queue.push(Object(identifier: "2"))
//////queue.push(Object(identifier: "3"))
//// /*
////  [
////  [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
////  [1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1],
////  [1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1],
////  [1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1],
////  [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0],
////  [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0],
////  [1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1],
////  [1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1],
////  [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
////  ]
////
////
////  0, 4,5,6
////  1,2, 100, 101
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
////
////
private func test1(){
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


    private func test2(){
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



    private func test3(){
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

    private func test4(){
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

    private func test5(){
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
////
////
struct Person {
    var age: Int
}
////
var testArray = [
    Person(age: 40),
    Person(age: 21),
    Person(age: 20),
    Person(age: 22),
    Person(age: 10),
    Person(age: 17),
    Person(age: 80),
    Person(age: 40)
]
//////
//////
enum Test {
    case a(value: Int)
    case b(value: Int)
    case c
}

let testC1 = Test.c
let testC2 = Test.c

if testC1 == testC2 {
    print("11")
} else {
    print("22")
}

//var array = [Int]()
//for i in 0...500 {
//    DispatchQueue.global().async {
//        self.array.append(i)
//    }
//}



////
////func randomTime() -> Double {
////    Double(arc4random_uniform(1000))
////}
//
////extension String {
////    var replaceBadSymbolsE: String {
////        self.replace(string: "Ё", replacement: "Е").replace(string: "ё", replacement: "е")
////    }
////
////    func replace(string:String, replacement:String) -> String {
////        return self.replacingOccurrences(of: string, with: replacement, options: NSString.CompareOptions.literal, range: nil)
////    }
////}
//
//extension Int {
//    var formatWithSpace: String? {
//        // 2358000 -> "2 358 000"
//
//        let formatter = NumberFormatter()
//        formatter.numberStyle = .decimal
//        formatter.locale = Locale(identifier: "fr_FR")
//
//        let formattedString = formatter.string(for: self)
//        return formattedString
//    }
//}
//
///*
// // упростить функцию
 func bestAnimals(from animalsInfo: [String: [String]]) -> [String] {
     var animals = [String]()

     for (key, _) in animalsInfo {
         guard let info = animalsInfo[key] else {
                 continue
         }

         animals.append(contensOf: info.sorted(by: {(lhs: String, rhs: String) -> Bool in
             return lhs > rhs
         }))
     }

     animals = animals.compactMap { animal in
         return animal.count > 3 ? animal : nil
     }.sorted(by: <)


     return animals
 }
//
// /////
//
// Проверить что строка является полиндромом. При условии что символы " ,.?/" итд мы пропускаем.
// Если используется заглавная и маленькая буква, то это эквивалентно. Числа такт же считаются.
// НЕ ИСПОЛЬЗОВАТЬ функцию .filter
//
// к примеру строка "10Lo><IuytTyuio l.01" является полиндромом
//
// */
//
//
//let TV = UITableView()
