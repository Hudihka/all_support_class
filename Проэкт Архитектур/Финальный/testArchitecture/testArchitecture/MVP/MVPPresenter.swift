//
//  MVPPresenter.swift
//  testArchitecture
//
//  Created by Константин Ирошников on 16.09.2022.
//

import Foundation

final class MVPPresenter: MVPPresenterProtocol {

    private weak var view: MVPViewProtocol?

    init(view: MVPViewProtocol) {
        self.view = view
    }

    func getData() {
        Network.getData { [weak self] text in
            self?.view?.setText(text: text)
        }
    }
}
