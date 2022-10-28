//
//  JSON.swift
//  TC5 ЕР
//
//  Created by Username on 23.01.2020.
//  Copyright © 2020 Hudihka. All rights reserved.
//

import Foundation

typealias JSON = [String: Any?]

class JSONparser: NSObject {

    var json: JSON

    init(json: JSON) {
        self.json = json
    }


    func int32(key: String) -> Int32?{

        if let intValue = self.parserIntParser(key: key){
            return Int32(intValue)
        }

        return nil

    }


    func parserIntParser(key: String) -> Int?{

        guard let value = json[key] else {return nil}

        if let valueInt = value as? Int {
            return valueInt
        } else if let valueString = value as? String {
            return Int(valueString)
        } else if let valueFloat = value as? Float {
            return Int(valueFloat)
        }
        return nil

    }

    func parserStringParser(key: String) -> String?{

        guard let value = json[key] else {return nil}

        if let valueString = value as? String {
            return valueString
        } else if let valueInt = value as? Int {
            return "\(valueInt)"
        } else if let valueFloat = value as? Float {
            return "\(valueFloat)"
        }

        return nil

    }
}
