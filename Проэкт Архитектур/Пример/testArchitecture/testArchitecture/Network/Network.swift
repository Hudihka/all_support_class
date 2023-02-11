//
//  Network.swift
//  testArchitecture
//
//  Created by Константин Ирошников on 16.09.2022.
//

import Foundation

final class Network {
    static func getData(compl: @escaping (String) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            compl("\nbla-bla-bla")
        }
    }
}
