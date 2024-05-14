//
//  PresenterUnitTest.swift
//  test
//
//  Created by Худышка К on 13.12.2022.
//

import Foundation

final class PresenterUnitTest: ProtocolUnitTestPresenter {
    private var allText = ""
    
    var startText: String = "start"
    
    func setTextFirst(text: String) {
        allText = "\(startText) \(text) first"
        print(allText)
    }
    
    func setTextSecond(text: String) {
        allText = "\(startText) \(text) second"
        print(allText)
    }
}
