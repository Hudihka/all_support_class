//
//  RefreshTocken.swift
//  TC5 ЕР
//
//  Created by Username on 19.02.2020.
//  Copyright © 2020 itMegastar. All rights reserved.
//

import Foundation
import Alamofire

class RefreshTocken {

    static func refresh(completion: @escaping (Bool) -> Void) {

        let url = OTEndpoint.AuthCode.refresh.url

        var parameters: Parameters = [:]

        if let tupl = DefaultsUtils.getLoginAndPassvord {
            parameters = ["username": tupl.login,
                          "password": tupl.password]
        }


        Alamofire.request(url,
                          method: .post,
                          parameters: parameters,
                          encoding: JSONEncoding.default,
                          headers: OTHeader.headerTocken).responseJSON {(json) in

            guard let stаtus = json.response?.statusCode else {
                AccountConection.shared.logAuht()
                completion(false)
                return
            }

            if stаtus == 200, let data = json.result.value as? JSON, let tocken = Tokens(JSON: data) {
                DefaultsUtils.save(tokens: tocken)
                completion(true)
            } else {
                AccountConection.shared.logAuht()
                completion(false)
            }
        }
    }
}


//class DebugPush {
//
//    static func refresh() {
//
//        let url = "https://opentext-py.itmegastar.com/api/v1/debug/create-notification/"
//
//        let parameters:  Parameters = ["user_id": 219129,
//                                           "task_id": 4953001,
//                                           "title": "Test",
//                                           "description": "TEST test TEST"]
//
//
//
//        Alamofire.request(url,
//                          method: .post,
//                          parameters: parameters,
//                          encoding: JSONEncoding.default,
//                          headers: OTHeader.headerTocken).responseJSON {(json) in
//
//                            print("------------------------НОТИФИКАЦИЯ----------------------------")
//
//                            //                            guard let stаtus = json.response?.statusCode else {
//                            //                                AccountConection.shared.logAuht()
//                            //                                completion(false)
//                            //                                return
//                            //                            }
//                            //
//                            //                            if stаtus == 200, let data = json.result.value as? JSON, let tocken = Tokens(JSON: data) {
//                            //                                DefaultsUtils.save(tokens: tocken)
//                            //                                completion(true)
//                            //                            } else {
//                            //                                AccountConection.shared.logAuht()
//                            //                                completion(false)
//                            //                            }
//        }
//    }
//}
