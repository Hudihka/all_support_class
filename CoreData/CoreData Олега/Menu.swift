//
//  Menu+CoreDataClass.swift
//
//
//  Created by Username on 28.02.2019.
//
//

import Foundation
import CoreData
import ObjectMapper

typealias TulpPriceInfo = (isSalle: Bool, bigPrice: String, sallePrice: String)

@objc(Menu)
class Menu: NSManagedObject, Mappable, NSManagedObjectNoId {
    @NSManaged var amount: Int16
    @NSManaged var food: Food?
    @NSManaged var priceDiscounted: Float
    @NSManaged var price: Float

    @NSManaged var fridgeFullMenuConnect: FridgeFull?

    func mapping(map: Map) {
        amount <- map["amount"]
        food <- (map["product"], FoodTransform())
        priceDiscounted <- map["price_discounted"]
        price <- map["price"]
    }

    func getCountTextLabel() -> String {
        let countFood = "В наличии %d шт."
        return String(format: countFood, self.amount)
    }

    func thereIsShare() -> Bool { //есть скидка на блюдо
        return priceDiscounted < price
    }

    func getPriceTextLabel() -> String {
        let currency = "%@ ₽"
        return String(format: currency, self.price.separatedFloat())
    }

    func getPriceSalleTextLabel() -> String {
        let currency = "%@ ₽"
        return String(format: currency, self.priceDiscounted.separatedFloat())
    }

    func getTulp() -> TulpPriceInfo {
        let tulp = TulpPriceInfo(isSalle: thereIsShare(), bigPrice: getPriceTextLabel(), sallePrice: getPriceSalleTextLabel())
        return tulp
    }
}

class MenuTransform: TransformType {
    typealias Object = Menu
    typealias JSON = [String: Any]

    func transformFromJSON(_ value: Any?) -> Menu? {
        if let json = value as? [String: Any] {
            return Menu.findCreate(json: json)
        }
        return nil
    }

    func transformToJSON(_ value: Object?) -> [String: Any]? {
        return value?.toJSON()
    }
}
