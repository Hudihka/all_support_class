//
//  Inheritance.swift
//  TestBeforeBank
//
//  Created by Худышка К on 26.03.2023.
//

import Foundation

final class Inheritance1 {
    var test1: Int = {
        print("запустили test1")
        return 5
    }()
    
    var test2: Int = {
        print("запустили test2")
        return 5
    }()
    
    lazy var test3: Int = {
        print("запустили test3")
        return 5
    }()
    
    var test4: () -> Void = {
        print("запустили test4")
    }
    
    weak var test5: EmptyClass1?
    var test6: EmptyClass2 = EmptyClass2()
    
    var test7: EmptyClass2 = {
        print("запустили test7")
        return EmptyClass2()
    }()
    
    var test8: EmptyClass2 = {
        print("запустили test8")
        return EmptyClass2()
    }()
    
    init() {
        print("инициализотор Inheritance1")
    }
}


final class EmptyClass1 {
    init() {
        print("init EmptyClass1")
    }
}

final class EmptyClass2 {
    init() {
        print("init EmptyClass2")
    }
}


class TestA {
    var test1: Int = {
        print("запустили test1")
        return 5
    }()
    
    init() {
        print("запустили init TestA")
    }
    
    deinit {
        print("грохнули deinit TestA")
    }
}

class TestB: TestA {
    var test2: Int = {
        print("запустили test2")
        return 5
    }()
    
    let testC = TestC()
    
    override init() {
        print("запустили init TestB")
    }
    
    deinit {
        print("грохнули deinit TestB")
    }
}

class TestC {
    var test3: Int = {
        print("запустили test3")
        return 5
    }()

    init() {
        print("запустили init TestC")
    }

    deinit {
        print("грохнули deinit TestC")
    }
}
