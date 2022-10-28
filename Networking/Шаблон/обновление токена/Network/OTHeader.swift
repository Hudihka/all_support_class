//
//  CRHeaders.swift
//  Ceorooms
//
//  Created by Oleg Matveev on 25/12/2018.
//

import Foundation
import Alamofire

enum OTHeader {

    static var headerTocken: HTTPHeaders? {

        var parameters: HTTPHeaders = ["Content-Type" : "application/json", "Accept" : "application/json"]

        if let tocken = DefaultsUtils.tokensAccount()?.accessToken {
            parameters["Authorization"] = "Bearer \(tocken)"
        }

        return parameters
    }


}
