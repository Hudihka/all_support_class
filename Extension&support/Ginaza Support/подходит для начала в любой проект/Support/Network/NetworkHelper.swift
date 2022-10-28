//
//  NetworkHelper.swift
//  Ceorooms
//
//  Created by Oleg Matveev on 25/12/2018.
//

import Foundation
import Alamofire

enum NetworkHelper {
    static func printResponse(_ response: DataResponse<Any>) {
        let statusCode = response.response?.statusCode ?? 0
        let url = response.request?.url?.absoluteString ?? "url unknown"

        switch response.result {
        case .success(let value):

            print("Request: \(url)\n  Status: \(statusCode)\n  Response: \(value)")

        case .failure(let error):

            print("Request: \(url)\n  Status: \(statusCode)\n  Error details: \(error.localizedDescription)")
        }
    }

    static func check(response: DataResponse<Any>) -> (data: Any?, error: GGError?) {
        switch response.result {
        case .success(let value):

            if let json = value as? JSON {
                if let error = json["error"] as? JSON {
                    let error = GGError(JSON: error)
                    error?.isServerError = true
                    return (nil, error)
                }

                if let data = json["data"] as? JSON {
                    return (data, nil)
                }
            }

            return (nil, nil)

        case .failure(let error):

            let code = response.response?.statusCode ?? 666
            let status = "Status: " + (code != 666 ? String(code) : "undefined")
            let message = error.localizedDescription
            let crError = GGError(type: status, message: message, info: nil)
            return (nil, crError)
        }
    }
}
