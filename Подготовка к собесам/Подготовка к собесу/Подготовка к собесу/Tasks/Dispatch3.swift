//
//  Dispatch3.swift
//  Подготовка к собесу
//
//  Created by Худышка К on 14.05.2024.
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

struct PlayableStruct: Playable {
    func play() {
        print("play in struct")
    }
    
    func stop() {
        print("stop in struct")
    }
}

extension PlayableStruct {

}

class Dispatch3 {
    func test() {
//        let str = PlayableClass()
//        str.play()
//        str.stop()
        
        let str1 = PlayableStruct()
        str1.play()
        str1.stop()
        
        testFunction(obj: str1)
    }
    
    func testFunction(obj: Playable) {
        obj.play()
        obj.stop()
    }
}


