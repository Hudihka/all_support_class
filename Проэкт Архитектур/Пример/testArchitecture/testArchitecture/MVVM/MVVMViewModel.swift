//
//  MVVMViewModel.swift
//  testArchitecture
//
//  Created by Константин Ирошников on 16.09.2022.
//

import Foundation

final class MVVMViewModel: MVVMProtocolIn, MVVMProtocolOut {
    
    var showText: (String) -> Void = { _ in }
    
    func getText() {
        Network.getData { [weak self] text in
            self?.showText(text)
        }
    }
}

// этот проэкт
// патерны сайт/ютюб
// чисктая арх
// ютюб с арх
