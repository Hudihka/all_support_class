//
//  AFEndpoints.swift
//  testTelegram
//
//  Created by Константин Ирошников on 20.11.2022.
//

import Foundation

protocol Endpoint {
    var path: String { get }
    var url: String { get }
}

extension Endpoint {
    public var url: String {
        AFEndpoint.getURLSerwer + path
    }
}

final class AFEndpoint {
    private enum URLs: String {
        case dev      = "worldtimeapi.org"

    }

    private static var key: URLs {
        URLs.dev
    }

    static var getURLSerwer: String {
        let urlWORC = "https://\(key.rawValue)/api/"
        return urlWORC
    }
}
