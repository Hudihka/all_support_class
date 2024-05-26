//
//  ProtocolsUnitTest.swift
//  test
//
//  Created by Худышка К on 13.12.2022.
//

import Foundation

protocol ProtocolUnitTestPresenter {
    var startText: String { get set }
    
    func setTextFirst(text: String)
    func setTextSecond(text: String)
}

protocol ProtocolUnitTestVC {
    func firstVC(text: String)
    func secondVC(text: String)
}
