//
//  ProfileRequest.swift
//  ChefMarket_2.0
//
//  Created by Александр Нейфельд on 16.03.2018.
//  Copyright © 2018 itMegaStar. All rights reserved.
//

import UIKit
import Alamofire

class ProfileRequest: BaseRequest {
    let kProfilePath = "clients/me"
    
    override var urlString: String {
        return kBasePath + kProfilePath
    }
    
    override func handle(_ json: Dictionary<String,Any>) {
        let bgContext = CoreDataManager.tempBGContext()
        bgContext.perform {
            let profile = Profile.findCreate(json: json, context: bgContext)
            let uid = profile.objectID
            
            let predicateNot = NSPredicate(format: "identifier != %@", profile.identifier ?? "")
            Profile.deleteAll(context: bgContext, predicate: predicateNot)
            CoreDataManager.save(bgContext: bgContext)

            //            показ алерта

            DispatchQueue.main.async {
                if let VC = UIApplication.shared.keyWindow?.visibleViewController {
                    VC.presentBallAwardedAlert()
                }
            }

            
            CoreDataManager.defaultContext.performAndWait {
                let target = CoreDataManager.defaultContext.object(with: uid)
                DataManager.shared.profile = target as? Profile
                self.onSuccess(target, nil)
            }
        }
        
        if let preferenses = json["preferences"] as? [JSON] { //парсим EatItems
//            bgContext.perform {
            let defCon = CoreDataManager.defaultContext
            var cards: [EatItem] = []
            for i in 0 ..< preferenses.count{
                let item = EatItem.findCreate(json: preferenses[i])
                item.sort = i
                cards.append(item)
            }
            
            let ids = cards.compactMap{ $0.identifier }
            let predicateNot = NSPredicate(format: "NOT (identifier in %@)", ids)
                
            EatItem.deleteAll(context: defCon, predicate: predicateNot)
//                CoreDataManager.save(bgContext: bgContext)
//            }
        }
    }
    
    
    
    
    private var internalMethod: HTTPMethod = .get
    private var profile: Profile?
    
    override var method: HTTPMethod {
        return internalMethod
    }
    
    override var encoding: ParameterEncoding {
        return internalMethod == .put ? JSONEncoding.default : URLEncoding.default
    }
    
    override var parameters: [String : Any] {
        return profile != nil ? profile!.parameters : [:]
    }
    
    func load(profile: Profile) { // загружаем новый адрес
        internalMethod = .put
        self.profile = profile
        
        load()
    }
}

