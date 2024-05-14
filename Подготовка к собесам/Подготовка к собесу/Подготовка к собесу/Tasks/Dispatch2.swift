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
    func circle() { print("protocol") }
    func render() { circle() }
}

class SWG: Drawing {
    func circle() { print("class") }
}

