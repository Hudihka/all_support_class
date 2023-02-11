//
//  MVPPresenter.swift
//  testArchitecture
//
//  Created by Константин Ирошников on 16.09.2022.
//

import Foundation

final class MVPPresenter: MVPPresenterProtocol {
    
    private weak var VC: MVPViewProtocol?
    
    init(VC: MVPViewProtocol) {
        self.VC = VC
    }
    
    func getText() {
        Network.getData { [weak self] text in
            guard let VC = self?.VC else {
                return
            }
            
            VC.showText(text: text)
        }
    }
}
