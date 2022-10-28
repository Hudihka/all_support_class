//
//  Endpoint.swift
//  Ceorooms
//
//  Created by Oleg Matveev on 25/12/2018.
//

import Foundation

typealias JSON = [String: Any?]

protocol Endpoint {
    var path: String { get }
    var url: String { get }
}

extension Endpoint {
    public var url: String {
        return GGApiBase.getURLSerwer() + path
    }
}

class GGApiBase: NSObject {

    static func getURLSerwer() -> String {

        return "http://api.ginzago.ru/api/"
    }
}

enum GGEndpoint {
    enum AuthCode: Endpoint {
        case request
        case enter

        public var path: String {
            switch self {
            case .request: return       "auth-code/request"
            case .enter: return         "auth-code/enter"
            }
        }
    }

}
