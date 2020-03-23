//
//  JSON.swift
//  GinzaGO
//
//  Created by Username on 19.08.2019.
//  Copyright © 2019 ITMegastar. All rights reserved.
//

import Foundation

typealias JSON = [String: Any]

class ExtensionJson: NSObject {
    static func anyToInt(_ json: JSON, _ key: String) -> Int? {
        if let intValue = json[key] as? Int {
            return intValue
        } else if let strValue = json[key] as? String {
            let nubberStr = strValue.deleteSumbol("0123456789")
            return Int(nubberStr)
        }

        return nil
    }

    static func anyToString(_ json: JSON, _ key: String) -> String? {
        if let strValue = json[key] as? String {
            return strValue
        } else if let intValue = json[key] as? Int {
            return "\(intValue)"
        }

        return nil
    }

    static func anyToIntAnyHashableJSON(_ json: [AnyHashable: Any], _ key: String) -> Int? {
        if let intValue = json[key] as? Int {
            return intValue
        } else if let strValue = json[key] as? String {
            let nubberStr = strValue.deleteSumbol("0123456789")
            return Int(nubberStr)
        }

        return nil
    }

    static func anyToStringAnyHashableJSON(_ json: [AnyHashable: Any], _ key: String) -> String? {
        if let strValue = json[key] as? String {
            return strValue
        } else if let intValue = json[key] as? Int {
            return "\(intValue)"
        }

        return nil
    }
}
