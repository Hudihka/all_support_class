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

class PlayableStruct: Playable {
    func play() {
        print("play in struct")
    }
    
    func stop() {
        print("stop in struct")
    }
}

class PlayableStruct2: PlayableStruct {
    override func play() {
        print("play in struct")
    }
    
    override func stop() {
        print("stop in struct")
    }
}

class PlayableStruct3: PlayableStruct {
}

extension PlayableStruct {

}

//////////////////////////////////////////
///
protocol Playable2 {
    func play()
}

extension Playable2 {
    func play() {
        print("play in protocol")
    }

    func stop() {
        print("stop in protocol")
    }
}

class PlayableClass {
}

extension PlayableClass: Playable2 {
    func stop() {
        print("stop in struct")
    }
}


class Dispatch3 {
    func test() {
        
        print("просто класс")
        let str1 = PlayableStruct()
        str1.play()
        str1.stop()
        // s p
        
        print("просто класс но обьявлен как класс")
        let str2: PlayableStruct = PlayableStruct()
        str2.play()
        str2.stop()
        // s p
        
        print("просто класс но обьявлен как протокол")
        let str3: Playable = PlayableStruct()
        str3.play()
        str3.stop()
        // p p
        
        print("просто класс2")
        let str4 = PlayableStruct2()
        str4.play()
        str4.stop()
        // s p
        
        print("просто класс2 но обьявлен как класс2")
        let str5: PlayableStruct2 = PlayableStruct2()
        str5.play()
        str5.stop()
        // s p
        
        print("просто класс2 но обьявлен как протокол")
        let str6: Playable = PlayableStruct2()
        str6.play()
        str6.stop()
        // p p
    }
    
    func test2() {
        print("------ситуация когда плей метод не имплементим в классе имплементит в экстеншене")
        
        print("просто класс")
        let str1 = PlayableClass()
        str1.play()
        str1.stop()
        // p s
        
        print("просто класс но обьявлен как класс")
        let str2: PlayableClass = PlayableClass()
        str2.play()
        str2.stop()
        // p s
        
        print("просто класс но обьявлен как протокол")
        let str3: Playable2 = PlayableClass()
        str3.play()
        str3.stop()
        // p p
    }
    
    func testFunction(obj: Playable) {
        obj.play()
        obj.stop()
    }
}


