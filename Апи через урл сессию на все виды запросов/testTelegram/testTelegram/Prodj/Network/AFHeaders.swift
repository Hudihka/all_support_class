//
//  AFHeaders.swift
//  testTelegram
//
//  Created by Константин Ирошников on 20.11.2022.
//

import Foundation

final class AFHeaders {
    static var heders: [String : String] {
        return [
            "application/json" : "Content-Type",
            "application/json" : "Accept"
        ]
    }
}
