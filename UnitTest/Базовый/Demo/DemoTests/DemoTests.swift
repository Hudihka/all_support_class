//
//  DemoTests.swift
//  DemoTests
//
//  Created by Ivan Akulov on 04/10/2018.
//  Copyright © 2018 Ivan Akulov. All rights reserved.
//

import XCTest
@testable import Demo //необходимо для импорта основного проекта в часть тесттов

class DemoTests: XCTestCase {

    var sut: ViewController! //проперти обьек вью контроллера

    //стандартная функция для создания обьектов, что то вроде вью дид лоада

    override func setUp() {
        super.setUp()
        sut = ViewController()
    }

    //стандартная функция для удаления обьектов, что то вроде деинит


    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testLowestVolumeShouldBeZero() {//все функции должны начинаться с тест
        sut.setVolume(value: -100) //вызываем функцию вью контроллера
        
        let volume = sut.volume //берем обьект вью контроллера

        /*если тест выполнися то выведится сообщение об этом, условие для выполнения volume == 0*/
        XCTAssert(volume == 0, "Lowest value should be equal 0.")
    }
    
    func testHighestVolumeShouldBe100() {
        sut.setVolume(value: 200)
        
        let volume = sut.volume
        XCTAssert(volume == 100, "Highest value should be equal 100.")
    }
    
    func testCharsInStringsAreTheSame() {
        // given
        let string1 = "qwerty"
        let string2 = "ytrewq"
        
        // when
        let bool = sut.charactersCompare(stringOne: string1, stringTwo: string2)
        
        // then
        XCTAssert(bool, "Characters should be the same in two strings.")
    }
    
    func testCharsInStringsAreDifferent() {
        // given
        let string1 = "qwerty1"
        let string2 = "ytrewq"
        
        // when
        let bool = sut.charactersCompare(stringOne: string1, stringTwo: string2)
        
        // then
        XCTAssert(!bool, "Characters should be different in two strings.")
    }
}
