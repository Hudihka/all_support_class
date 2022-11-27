//
//  AFError.swift
//  testTelegram
//
//  Created by Константин Ирошников on 20.11.2022.
//

import Foundation

struct AFError {
    let type: ErrorType
    let message: String?

    enum ErrorType: String {

        case decodable

        case other
    }

    init(error: Error?, type: ErrorType) {
        self.type = type
        self.message = error?.localizedDescription
    }
}
