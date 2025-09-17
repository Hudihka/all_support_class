//
//  Dispatcherization.swift
//  TestBeforeBank
//
//  Created by Худышка К on 26.03.2023.
//

import Foundation

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

extension AppDelegate {
    func testDispatcherization1() {
        print("запустили \(#function)")
        let str = Player()
        str.play()
        str.stop()
    }
    
    func testDispatcherization2() {
        print("запустили \(#function)")
        let str: Playable = Player()
        str.play()
        str.stop()
    }
    
    func testDispatcherization3() {
        print("запустили \(#function)")
        let str: Playable = Player()
        if let strTest = str as? Player {
            strTest.play()
            strTest.stop()
        }
    }
}
