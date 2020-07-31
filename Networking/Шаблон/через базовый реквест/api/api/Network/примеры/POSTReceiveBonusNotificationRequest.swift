//
//  POSTReceiveBonusNotificationRequest.swift
//  ChefMarket_2.0
//
//  Created by Username on 15.08.2019.
//  Copyright © 2019 itMegaStar. All rights reserved.
//

import Foundation
import Alamofire


class POSTReceiveBonusNotificationRequest: BaseRequest {
    let kWPath = "clients/me"
    let kEndPoint = "/receive_bonus_notification"

    private var revision: Int = 0

    override var urlString: String {
        return kBasePath + kWPath + kEndPoint
    }

    override var method: HTTPMethod{
        return .post
    }

    override var encoding: ParameterEncoding {
        return JSONEncoding.default
    }

//
//    func load(revision: Int){
//        self.revision = revision
//        super.load()
//    }
}
