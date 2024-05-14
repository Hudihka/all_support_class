////
////  AppDelegate.swift
////  test
////
////  Created by Константин Ирошников on 30.07.2022.
////
//



////
//////        print("0".unicode)
////
//////        arc4random_
////        let VC = ViewController()
////        print("1")
////        let _ = VC.view
////        print(4)




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





/// задача 2
//
//func print(addres o: UnsafeRawPointer) {
//    print(String(format: "%p", Int(bitPattern: o)))
//}
//
//var array1 = [0, 1, 2, 3]
//var array2 = array1
//
//print(array1)
//print(array2)




// задача 4
//
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
///


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

let testC1 = Test.a(value: 7)
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
