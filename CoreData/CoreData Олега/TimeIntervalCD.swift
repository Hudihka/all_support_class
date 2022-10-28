//
//  TimeIntervalCD+CoreDataProperties.swift
//
//
//  Created by Username on 13.05.2019.
//
//

import Foundation
import CoreData
import ObjectMapper

@objc(TimeIntervalCD)
class TimeIntervalCD: NSManagedObject, Mappable, NSManagedObjectNoId {
    @NSManaged var timeFrom: String?
    @NSManaged var timeTo: String?
    @NSManaged var timeIntervalSalleCDConnect: SalleCD?

    func mapping(map: Map) {
        timeFrom <- map["time_from"]
        timeTo <- map["time_to"]
    }
}

class TimeIntervalCDTransform: TransformType {
    typealias Object = TimeIntervalCD
    typealias JSON = [String: Any]

    func transformFromJSON(_ value: Any?) -> TimeIntervalCD? {
        if let json = value as? [String: Any] {
            return Object.findCreate(json: json)
        }
        return nil
    }

    func transformToJSON(_ value: Object?) -> [String: Any]? {
        return value?.toJSON()
    }
}
