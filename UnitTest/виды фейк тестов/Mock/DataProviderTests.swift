//
//  DataProviderTests.swift
//  ToDoAppTests
//
//  Created by Ivan Akulov on 17/10/2018.
//  Copyright © 2018 Ivan Akulov. All rights reserved.
//

import XCTest
@testable import ToDoApp

class DataProviderTests: XCTestCase {

    var sut: DataProvider!
    var tableView: UITableView!
    
    var controller: TaskListViewController!
    
    override func setUp() {
        sut = DataProvider()
        sut.taskManager = TaskManager()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        controller = storyboard.instantiateViewController(withIdentifier: String(describing: TaskListViewController.self)) as? TaskListViewController
        
        controller.loadViewIfNeeded()
        
        tableView = controller.tableView
        tableView.dataSource = sut
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testNumberOfSectionsIsTwo() {
        let numberOfSections = tableView.numberOfSections
        
        XCTAssertEqual(numberOfSections, 2)
    }
    
    func testNumberOfRowsInSectionZeroIsTasksCount() {
        sut.taskManager?.add(task: Task(title: "Foo"))
        
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 1)
        
        sut.taskManager?.add(task: Task(title: "Bar"))
        
        tableView.reloadData()
        
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 2)
    }
    
    func testNumberOfRowsInSectionOneIsDoneTasksCount() {
        sut.taskManager?.add(task: Task(title: "Foo"))
        sut.taskManager?.checkTask(at: 0)
        
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 1)
        
        sut.taskManager?.add(task: Task(title: "Bar"))
        sut.taskManager?.checkTask(at: 0)
        
        tableView.reloadData()
        
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 2)
    }
    
    func testCellForRowAtIndexPathReturnsTaskCell() {
        sut.taskManager?.add(task: Task(title: "Foo"))
        tableView.reloadData()
        
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(cell is TaskCell)
    }
    
    func testCellForRowAtIndexPathDequeuesCellFromTableView() {
        //sut - это обьект класса который мы добавляем на сториборд, ттам мв задаем параметры таблицы
        let mockTableView = MockTableView() //регисттрируем датта сорс и ячейки
        mockTableView.dataSource = sut
        mockTableView.register(TaskCell.self, forCellReuseIdentifier: String(describing: TaskCell.self))
        
        sut.taskManager?.add(task: Task(title: "Foo"))  //добавляем в taskManager suta задачу
        mockTableView.reloadData()                      //перезагружаем ячейку
        
        _ = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0))//dequeueReusableCell вызываем метод котторый собсттвенно и переопределит ячейку
        
        XCTAssertTrue(mockTableView.cellIsDequeued) //проверяем выполнился ли меттод
    }
    
    func testCellForRowInSectionZeroCallsConfigure() {
        tableView.register(MockTaskCell.self, forCellReuseIdentifier: String(describing: TaskCell.self))//регистрируем в ттаблице ячейку
        
        let task = Task(title: "Foo") //создаем задачу
        sut.taskManager?.add(task: task)//добавляем ее в менеджер задач
        tableView.reloadData()          //перезагружаем ячейку
        
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! MockTaskCell //берем ячейку ттаблицы
        
        XCTAssertEqual(cell.task, task)                                 //ну и проверяем тта это задача или нет
    }
}

extension DataProviderTests { //классы добавляем в расширение для ттого что бы скрыть их
    class MockTableView: UITableView {    //здесь мы переопределяем что ячейка меняется
        var cellIsDequeued = false
        
        override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
            cellIsDequeued = true
            
            return super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        }
    }
    
    class MockTaskCell: TaskCell { //здесь определяем чтто нужной ячейке присвоилась нужная задача
        var task: Task?
        
        override func configure(withTask task: Task) {
            self.task = task
        }
    }
}
