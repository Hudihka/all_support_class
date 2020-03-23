//
//  CRApi.swift
//  Ceorooms
//
//  Created by Oleg Matveev on 25/12/2018.
//

import UIKit
import Alamofire

class GGApi: NSObject {
    private static let reqestHelper = ReqestHelper()

    //    static func checkAuthCode(for phoneNumber: String, code: String, completion: @escaping (JSON?, GGError?) -> Void) {
    //        let endpoint: Endpoint = GGEndpoint.AuthCode.enter
    //
    //        var parameters: Parameters = ["phone": phoneNumber]
    //        parameters["code"] = code
    //        parameters["push_token"] = appDelegateShared().token
    //
    //        reqestHelper.request(endpoint.url, method: .post, parameters: parameters, headers: GGHeader.basicHeader()) { (data, error) in
    //            if error == nil, let json = data as? JSON {
    //                completion(json, nil)
    //            } else {
    //                completion(nil, error)
    //            }
    //        }
    //    }


}
