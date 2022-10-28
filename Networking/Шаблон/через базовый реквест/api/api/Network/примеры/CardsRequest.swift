//
//  CardsRequest.swift
//  ChefMarket_2.0
//
//  Created by Nikita Gorobets on 28.04.2018.
//  Copyright © 2018 itMegaStar. All rights reserved.
//

import UIKit
import Alamofire

class CardsRequest: BaseRequest {
    
    let kPath = "bank-cards"
    private var internalMethod: HTTPMethod = .get
    private var card: Card?
    private var cardIdToRemove: String?
    
    override var method: HTTPMethod {
        return internalMethod
    }
    
    override var encoding: ParameterEncoding {
        return internalMethod == .post ? JSONEncoding.default : URLEncoding.default
    }
    
    override var urlString: String {
        
        let appendix = cardIdToRemove.map{"/\($0)"}
        return kBasePath + kPath + (appendix ?? "")
    }
    
    override var parameters: [String : Any] {
        return card != nil ? card!.parameters : [:]
    }
    
    override func handle(_ array: Array<Dictionary<String,Any>>) {
        
        let bgContext = CoreDataManager.tempBGContext()
        bgContext.perform {
            let cards = array.map { Card.findCreate(json: $0, context: bgContext) }
            let ids = cards.compactMap{ $0.identifier }
            let cordIds = cards.compactMap{ $0.objectID }
            let predicateNot = NSPredicate(format: "NOT (identifier in %@)", ids)
            
            Card.deleteAll(context: bgContext, predicate: predicateNot)
            CoreDataManager.save(bgContext: bgContext)
            
            CoreDataManager.defaultContext.performAndWait {
                let target = cordIds.map{
                    CoreDataManager.defaultContext.object(with: $0)
                }
                self.onSuccess(target, nil)
            }
        }
    }
    
    func remove(cardId: String) { // удаляем карту
        internalMethod = .delete
        cardIdToRemove = cardId
        
        load()
    }
    
    func load(card: Card) { // загружаем новую карту
        internalMethod = .post
        self.card = card
        
        load()
    }

}



