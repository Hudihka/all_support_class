//
//  MVVMViewModel.swift
//  testArchitecture
//
//  Created by Константин Ирошников on 16.09.2022.
//

import Foundation

final class MVVMViewModel: MVVMProtocolIn, MVVMProtocolOut {
    var setText: (String) -> Void = { _ in }


    func getData() {
        Network.getData { [weak self] text in
            self?.setText(text)
        }
    }
}
