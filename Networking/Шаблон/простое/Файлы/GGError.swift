//
//  CRError.swift
//  Ceorooms
//
//  Created by Oleg Matveev on 26/12/2018.
//
//swiftlint:disable force_unwrapping

import UIKit
import ObjectMapper

class GGError: Mappable {
    var type: String?
    var message: String?
    var info: JSON?
    var isServerError: Bool = false

    required init?(map: Map) {
    }

    convenience init(type: String?, message: String?, info: JSON?) {
        self.init(JSON: [:])!

        self.type = type
        self.message = message
        self.info = info
    }

    func mapping(map: Map) {
        type <- map["type"]
        message <- map["message"]
        info <- map["info"]
    }
}
