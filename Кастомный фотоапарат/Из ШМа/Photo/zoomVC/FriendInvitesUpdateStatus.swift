//
//  FriendInvitesUpdateStatus.swift
//  ChefMarket_2.0
//
//  Created by Hudihka on 03/08/2020.
//  Copyright © 2020 itMegaStar. All rights reserved.
//

import Foundation
import Alamofire


class FriendInvitesUpdateStatus: BaseRequest {
    
    private var id: String = ""
    
    override var method: HTTPMethod {
        return .post
    }
    
    
    func load(id: String) {
        self.id = id
        self.load()
    }
    
    let kPath = "clients/friend-invites/"
    
    override var urlString: String {
        
        return kBasePath + kPath + id
    }
    
    
    override func handle(_ json: Dictionary<String,Any>) {  //override
        onSuccess(nil, nil)
    }
}
