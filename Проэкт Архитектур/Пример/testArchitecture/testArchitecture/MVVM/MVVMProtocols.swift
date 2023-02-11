//
//  MVVMProtocols.swift
//  testArchitecture
//
//  Created by Константин Ирошников on 16.09.2022.
//

import Foundation

protocol MVVMProtocolIn {
    func getText()
}

protocol MVVMProtocolOut {
    var showText: (String) -> Void { get set }
}
