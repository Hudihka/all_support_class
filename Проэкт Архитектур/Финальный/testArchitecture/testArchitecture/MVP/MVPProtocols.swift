//
//  MVPProtocols.swift
//  testArchitecture
//
//  Created by Константин Ирошников on 16.09.2022.
//

import Foundation

protocol MVPViewProtocol: AnyObject {
    func setText(text: String)
}

protocol MVPPresenterProtocol {
    func getData()

    init(view: MVPViewProtocol)
}
