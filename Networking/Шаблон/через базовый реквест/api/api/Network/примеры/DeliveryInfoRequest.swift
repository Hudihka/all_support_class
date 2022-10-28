//
//  DeliveryInfoRequest.swift
//  ChefMarket_2.0
//
//  Created by Nikita Gorobets on 26.06.2018.
//  Copyright © 2018 itMegaStar. All rights reserved.
//

import Foundation
import Alamofire

class DeliveryInfoRequest: BaseRequest {
    
    let kPath = "settings/delivery-conditions"
    
    private var dadata: [String: Any]?
    
    override var urlString: String {
        
        return kBasePath + kPath
    }
    
    override var parameters: [String : Any] {
        var param: [String : Any] = [:]
        dadata.map { param["dadata"] = ($0["data"] ?? $0) }
        
        return param
    }
    
    override  var encoding: ParameterEncoding {       //override
        return JSONEncoding.default
    }
    
    override var method: HTTPMethod{
        return .post
    }
    
    override func handle(_ dict: Dictionary<String,Any>) {
        onSuccess(DeliveryInfo(dict: dict), nil)
    }
    
    func load(dadata: [String: Any]) {
        self.dadata = dadata
        load()
    }
}
