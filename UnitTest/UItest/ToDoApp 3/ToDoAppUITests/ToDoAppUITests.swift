//
//  ToDoAppUITests.swift
//  ToDoAppUITests
//
//  Created by Ivan Akulov on 07/10/2018.
//  Copyright © 2018 Ivan Akulov. All rights reserved.
//

import XCTest

class ToDoAppUITests: XCTestCase {
    
    var app: XCUIApplication!  //собсвенно само приложение

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        app = XCUIApplication()
        app.launchArguments.append("--UITesting")
        app.launch() //мы говорим что тнаше приложение загрузилось с параметром "--UITesting"


    }

    override func tearDown() {
        // вызывается после завершения ттестирования
    }
    /*здесь мы можем запустить приложение нажав красную кнопку в низу записав действия*/

    func testExample() {
        
        XCTAssertTrue(app.isOnMainView)   //это нужный вью контроллер
        app.navigationBars["ToDoApp.TaskListView"].buttons["Add"].tap() //нажатие на кнопку плюс на бб итем
        app.textFields["Title"].tap()         //нажаие на текс филд
        app.textFields["Title"].typeText("Foo")  // ввод ттекста
        
        app.textFields["Location"].tap()
        app.textFields["Location"].typeText("Bar")
        
        app.textFields["Description"].tap()
        app.textFields["Description"].typeText("Baz")
        
        app.textFields["Date"].tap()
        app.textFields["Date"].typeText("01.01.19")
        
        app.textFields["Address"].tap()
        app.textFields["Address"].typeText("Ufa")
        
        XCTAssertFalse(app.isOnMainView)
        app.buttons["save"].tap()
        
        XCTAssertTrue(app.tables.staticTexts["Foo"].exists)
        XCTAssertTrue(app.tables.staticTexts["Bar"].exists)
        XCTAssertTrue(app.tables.staticTexts["01.01.19"].exists)
    }
    
    func testWhenCellIsSwipedLeftDoneButtonAppeared() {

        XCTAssertTrue(app.isOnMainView)
        app.navigationBars["ToDoApp.TaskListView"].buttons["Add"].tap()
        app.textFields["Title"].tap()
        app.textFields["Title"].typeText("Foo")
        
        app.textFields["Location"].tap()
        app.textFields["Location"].typeText("Bar")
        
        app.textFields["Description"].tap()
        app.textFields["Description"].typeText("Baz")
        
        app.textFields["Date"].tap()
        app.textFields["Date"].typeText("01.01.19")
        
        app.textFields["Address"].tap()
        app.textFields["Address"].typeText("Ufa")
        
        XCTAssertFalse(app.isOnMainView)
        app.buttons["save"].tap()
        
        XCTAssertFalse(app.isOnMainView)
        
        let tablesQuery = app.tables.cells
        tablesQuery.element(boundBy: 0).swipeLeft() //
        tablesQuery.element(boundBy: 0).buttons["Done"].tap()
        
        XCTAssertEqual(app.staticTexts.element(matching: .any, identifier: "date").label, "")
    }
}

extension XCUIApplication {
    var isOnMainView: Bool { //спрашиваем, это вью имее акцес индикатор mainView
        return otherElements["mainView"].exists
    }
}

/*

акцес индикатор можно задать во вью дид лоаде
view.accessibilityIdentifier = "mainView"

 либо щелкнуть на вью и в испекторе атрибутов выбрать 3 с права вкладку
 там в акцес ибилити выбрать идентификатор

 */
