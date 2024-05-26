//
//  TypeErasure.swift
//  TestBeforeBank
//
//  Created by Худышка К on 26.03.2023.
//

import UIKit

protocol TypeErasureProtocol1 {
    associatedtype T: UIView
    
    func generateView(frame: CGRect) -> T
}

struct Test<D: TypeErasureProtocol1> {
    var array = [D]()
}

final class TestErasure1: TypeErasureProtocol1 {
    typealias T = UIButton
    
    func generateView(frame: CGRect) -> UIButton {
        UIButton()
    }
}

class TestErasure1point0 {
    var value: TestErasure1
    
    init(value: TestErasure1) {
        self.value = value
    }
}

private class TestErasure2 {
    init() {}
    
    func testParametr(value: TestErasure1point0) {
    }
    
    func testSelf() {
        let str = Test<<#D: TypeErasureProtocol1#>>()
    }
}
