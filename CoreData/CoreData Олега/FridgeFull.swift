//
//  FridgeFull+CoreDataClass.swift
//
//
//  Created by Username on 28.02.2019.
//
//

import Foundation
import CoreData
import ObjectMapper

@objc(FridgeFull)
class FridgeFull: NSManagedObject, Mappable, NSManagedObjectWithID {
    @NSManaged var id: Int32
    @NSManaged var isActive: Bool
    @NSManaged var serialNumber: String?
    @NSManaged var location: Location?
    @NSManaged var menu: Set<Menu>?

    func mapping(map: Map) {
        id <- map["id"]
        serialNumber <- map["serial_number"]
        isActive <- map["is_active"]
        location <- (map["location"], LocationTransform())
        menu <- (map["menu"], MenuTransform())
    }
}

extension FridgeFull {
    @objc(addMenuObject:)
    @NSManaged func addToMenu(_ value: Menu)

    @objc(removeMenuObject:)
    @NSManaged func removeFromMenu(_ value: Menu)

    @objc(addMenu:)
    @NSManaged func addToMenu(_ values: NSSet)

    @objc(removeMenu:)
    @NSManaged func removeFromMenu(_ values: NSSet)
}
