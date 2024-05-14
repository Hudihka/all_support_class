//
//  DidSet.swift
//  Подготовка к собесу
//
//  Created by Худышка К on 14.05.2024.
//

import Foundation

class DidSet {
    struct Cat {
        var name: String?
    }
    
    struct Dog {
        var name: String?
    }
    
    struct Person {
        var cat: Cat? {
            didSet {
                print("didSet cat")
            }
        }
        
        var dogs: [Dog]? {
            didSet {
                print("didSet dogs")
            }
        }
    }
    
    func test() {
        var person = Person()
        let cat1 = Cat(name: "name_cat_0")
        let cat2 = Cat(name: "name_cat_2")
        
        let dog1 = Dog(name: "dog_1")
        let dog2 = Dog(name: "dog_2")
        let dog3 = Dog(name: "dog_3")
        let dog4 = Dog(name: "dog_4")
        
        person.cat = cat1
        person.cat = nil
        person.cat = cat2
        
        
//        person.dogs = []
//        person.dogs = nil
        
        var testArray = [dog1, dog2]
        person.dogs = testArray
        testArray.append(dog3)
        person.dogs = testArray
    }
    
}
