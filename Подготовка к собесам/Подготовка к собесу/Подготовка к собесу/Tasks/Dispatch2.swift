//
//  Dispatch2.swift
//  Подготовка к собесу
//
//  Created by Худышка К on 14.05.2024.
//

import Foundation

protocol Drawing: AnyObject {
    func render()
}

extension Drawing {
    func circle() {
        print("protocol")
    }
    
    func render() {
        circle()
    }
}

class SWG: Drawing {
    func circle() { print("class") }
}

class Dispatch2 {
    func test() {
        let SWG = SWG()
        print(SWG.circle())
        print(SWG.render())
        //
        
//        let SWG2: Drawing = SWG()
//        
//        print(SWG2.circle())
//        print(SWG2.render())
    }
}
