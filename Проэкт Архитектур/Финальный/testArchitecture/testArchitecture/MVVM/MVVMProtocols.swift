//
//  MVVMProtocols.swift
//  testArchitecture
//
//  Created by Константин Ирошников on 16.09.2022.
//

import Foundation

protocol MVVMProtocolIn {
    func getData()
}

protocol MVVMProtocolOut {
    var setText: (String) -> Void  { get set }
}
