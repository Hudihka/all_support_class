//
//  MVPProtocols.swift
//  testArchitecture
//
//  Created by Константин Ирошников on 16.09.2022.
//

import Foundation

protocol MVPViewProtocol: AnyObject {
    func showText(text: String)
}

protocol MVPPresenterProtocol {
    init(VC: MVPViewProtocol)
    
    func getText()
}
