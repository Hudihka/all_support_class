//
//  FriendInvitesRequest.swift
//  ChefMarket_2.0
//
//  Created by Админ on 04.08.2020.
//  Copyright © 2020 itMegaStar. All rights reserved.
//

import Foundation
import Alamofire


class FriendInvitesRequest: BaseRequest {
    
    private var name: String?
    private var email: String?
    private var page: Int = 0
    
    func parametrs(name: String?, email: String?){
        
        self.name = name
        self.email = email
        
        self.load()
    }
    
    func parametrs(page: Int){
        
        self.page = page
        
        self.load()
    }
    
    
    
    private var internalMethod: HTTPMethod = .get
    
    override var method: HTTPMethod {
        if self.name == nil, self.email == nil {
            return .get
        }
        
        return .post
    }
    
    override var parameters: [String : Any] {
        var parametrs: [String : Any] = [:]
        
        if self.name == nil, self.email == nil {
            return ["page" : page, "per_page" : 9]
        }
        
        if let name = self.name {
            parametrs["name"] = name
        }
        
        if let email = self.email {
            parametrs["email"] = email
        }
        
        return parametrs
    }
    
    let kPath = "clients/friend-invites"
    
    override var urlString: String {
        
        return kBasePath + kPath
    }
    
    override func handle(_ json: Dictionary<String,Any>) {  //override
        if let arrayJson = json["data"] as? [JSON]{
            
            let fullArray = arrayJson.map({HistoryFriendsItem(dict: $0)})
            
            let arrayRemember = fullArray.filter({$0.status == 3}).sorted(by: {$1.dateSort < $0.dateSort})
            let arrayNoRemember = fullArray.filter({$0.status != 3}).sorted(by: {$1.dateSort < $0.dateSort})
            
            let array = arrayRemember + arrayNoRemember
            onSuccess(array, nil)
        } else {
            onSuccess([], nil)
        }
    }
}
