//
//  DishRequest.swift
//  ChefMarket_2.0
//
//  Created by Александр Нейфельд on 30.08.2018.
//  Copyright © 2018 itMegaStar. All rights reserved.
//

import UIKit
import Alamofire
import CoreData

class DishRequest: BaseRequest {

    let kPath = "dishes"
    var dishId: String?
    var menuID: String?
    var weekNumber: Int?
    var context: NSManagedObjectContext?
        
    override var urlString: String {
        return kBasePath + kPath + "/" + (dishId ?? "")
    }
        
    override func handle(_ json: Dictionary<String, Any>) {
        self.onSuccess(Dish.findCreate(json: json), nil)
        
        let bgContext = CoreDataManager.tempBGContext()
        bgContext.perform {
            let dish =  Dish.findCreate(json: json, context: bgContext)
            let uid = dish.objectID
            
            CoreDataManager.save(bgContext: bgContext)
            
            let ctx = self.context ?? CoreDataManager.defaultContext
            ctx.performAndWait {
                let target = ctx.object(with: uid)
                
                self.onSuccess(target, nil)
            }
        }
    }
    
    override var parameters: [String : Any]{
        guard let mId = menuID, let week = weekNumber else {
            return [:]
        }
        var para: [String: Any] = [:]
        para["menu_type_id"] = mId
        para["week"] = week
        
        return para
    }
        
    func load(_ dishId: String, menuId: String? = nil, week: Int? = nil){
        self.dishId = dishId
        self.weekNumber = week
        self.menuID = menuId
        load()
    }
}
