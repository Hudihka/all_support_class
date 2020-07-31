//
//  CRError.swift
//  Ceorooms
//
//  Created by Oleg Matveev on 26/12/2018.
//
//swiftlint:disable force_unwrapping

import UIKit
import ObjectMapper

class OTError: Mappable {
    var code: Int?
    var error: String?
    var message: String?
    var additionalErrors: JSON?
    var errorDisplayTime: Int?

    required init?(map: Map) {
    }

    convenience init(code: Int?, message: String?, additionalErrors: JSON?) {
        self.init(JSON: [:])!

        self.code = code
        self.message = message
        self.additionalErrors = additionalErrors
    }

    func mapping(map: Map) {
        code <- map["code"]
        error <- map["error"]
        message <- map["message"]
        additionalErrors <- map["additional_errors"]
        errorDisplayTime <- map["error_display_time"]
    }
}

extension OTError {

    func code(equal: Int) -> Bool{
        if let code = self.code {
            return code == equal
        }

        return false
    }


    var updateToken: Bool{

        return code(equal: 401)
    }

    var textMessageErrorAutorization: String?{

        guard let err = self.error, err == "CLIENT_USER_NOT_FOUND" || err == "CLIENT_UNAUTHENTICATED", let message = self.message else {
            return nil
        }

        return message
    }

}



