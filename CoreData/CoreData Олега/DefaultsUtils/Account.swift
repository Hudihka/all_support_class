//
//  Account.swift
//  Ceorooms
//
//  Created by Oleg Matveev on 24/12/2018.
//

import Foundation
import ObjectMapper

class Account: Mappable {
    private(set) var id: Int = -1
    var lastName: String?
    var firstName: String?
    var middleName: String?
    var phone: String?
    var email: String?
    var photo: [FileModel]?
    var isIndebted: Bool = false
    var activeCardId: Int?
    var activeCard: CreditsCard?
    var cards: [CreditsCard]?
    var socialNetworks: [SocialNetwork]?
    var activeDiscounts: [Salle]?
    var freeProducts: [FreeFood]?
    var config: [String: Any]?

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        id <- map["id"]
        lastName <- map["last_name"]
        firstName <- map["first_name"]
        middleName <- map["middle_name"]
        phone <- map["phone"]
        email <- map["email"]
        photo <- map["photo"]
        isIndebted <- map["is_indebted"]
        activeCard <- map["active_card"]
        activeCardId <- map["active_card_id"]
        cards <- map["cards"]
        socialNetworks <- map["social_networks"]
        activeDiscounts <- map["active_discounts"]
        freeProducts <- map["free_products"]
        config <- map["config"]
    }
}
