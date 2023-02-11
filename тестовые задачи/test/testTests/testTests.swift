//
//  testTests.swift
//  testTests
//
//  Created by Худышка К on 13.12.2022.
//

import XCTest
@testable import test

final class testTests: XCTestCase {
    private enum Constants {
        static let first   = "FIRST_TEST"
        static let second  = "SECOND_TEST"
    }
    private var VC: (ViewControllerUnitTest & ProtocolUnitTestVC)!
    private var spy: ProtocolUnitTestPresenter!

    
    override func setUpWithError() throws {
        self.VC = ViewControllerUnitTest()
        self.spy = PresenterUnitTestSpy()
        
        VC.presenter = spy
    }

    override func tearDownWithError() throws {
        self.spy = nil
        self.spy = nil
    }
    
    private final class PresenterUnitTestSpy: ProtocolUnitTestPresenter {
        var startText: String = ""
        
        func setTextFirst(text: String) {
            startText = text
        }
        
        func setTextSecond(text: String) {
            startText = text
        }
    }
    
    func testFirstVC() {
        let str = Constants.first
        
        let _ = VC.firstVC(text: str)
        
        XCTAssertEqual(str + "000", spy.startText)
        
    }
    
    func testSecondVC() {
        let str = Constants.second
        
        VC.secondVC(text: str)
        
        XCTAssertEqual(str, spy.startText)
    }
}

/*
 
 class ViewControllerUnitTest: UIViewController {
     
     var presenter: ProtocolUnitTestPresenter?

     override func viewDidLoad() {
         super.viewDidLoad()

         presenter = PresenterUnitTest()
     }
     
     @IBAction func firstButton(_ sender: Any) {
         firstVC(text: "PUPA")
     }
     

     @IBAction func secondButton(_ sender: Any) {
         secondVC(text: "LUPA")
     }
 }

 extension ViewControllerUnitTest: ProtocolUnitTestVC {
     func firstVC(text: String) {
         let str = text + "00"
         presenter?.setTextFirst(text: str)
     }
     
     func secondVC(text: String) {
         presenter?.setTextSecond(text: text)
     }
 }

 */
