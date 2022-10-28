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

    static func check(response: DataResponse<Any>) -> (data: Any?, error: OTError?) {

        switch response.result {
        case .success(let value):

            if response.response?.statusCode == 200 {
                if let json = value as? JSON {
                    return (json, nil)
                } else if let json = value as? [JSON]{
                    return (json, nil)
                } else if let json = value as? Int{
                    return (json, nil)
                }
            } else if let json = value as? JSON {
                let error = OTError(JSON: json)
                return (nil, error)
            }

            return (nil, nil)

        case .failure(let error):

            let code = response.response?.statusCode ?? 666
            _ = "Status: " + (code != 666 ? String(code) : "undefined")
            let message = error.localizedDescription
            let crError = OTError(code: code, message: message, additionalErrors: nil)
            return (nil, crError)
        }
    }
}



