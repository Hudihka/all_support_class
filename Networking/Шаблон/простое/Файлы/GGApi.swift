//
//  CRApi.swift
//  Ceorooms
//
//  Created by Oleg Matveev on 25/12/2018.
//

import UIKit
import Alamofire
import AudioToolbox

class GGApi: NSObject {
    private static let reqestHelper = ReqestHelper()

    static func reqestAuthCode(for phoneNumber: String, completion: @escaping (Any?, GGError?) -> Void) {
        let endpoint: Endpoint = GGEndpoint.AuthCode.request

        let parameters: Parameters = ["phone": phoneNumber]

        reqestHelper.request(endpoint.url, method: .post, parameters: parameters, headers: GGHeader.basicHeader()) { (data, error) in
            if let json = data as? JSON {
                completion(json, nil)
            } else {
                completion(nil, error)
            }
        }
    }

    static func checkAuthCode(for phoneNumber: String, code: String, completion: @escaping (JSON?, GGError?) -> Void) {
        let endpoint: Endpoint = GGEndpoint.AuthCode.enter

        var parameters: Parameters = ["phone": phoneNumber]
        parameters["code"] = code
        parameters["push_token"] = appDelegateShared().token

        reqestHelper.request(endpoint.url, method: .post, parameters: parameters, headers: GGHeader.basicHeader()) { (data, error) in
            if error == nil, let json = data as? JSON {
                completion(json, nil)
            } else {
                completion(nil, error)
            }
        }
    }

    static func getAccountInfo(completion: @escaping (Account?, GGError?) -> Void) {
        let endpoint: Endpoint = GGEndpoint.User.me

        reqestHelper.request(endpoint.url, method: .get) { (data, error) in
            if let json = (data as? JSON)?["user"] as? JSON, let account = Account(JSON: json) {
                completion(account, nil)
            } else {
                completion(nil, error)
            }
        }
    }

    static func getAllfridge(completion: @escaping ([Any]?, GGError?) -> Void) {
        let endpoint: Endpoint = GGEndpoint.Fridge.fridgeAll

        let parameters: Parameters = ["brief": true]

        reqestHelper.request(endpoint.url, method: .post, parameters: parameters) { (data, error) in
            if let json = data as? JSON, let array = json["fridges"] as? [Any] {
                completion(array, nil)
            } else {
                completion(nil, error)
            }
        }
    }

    static func getOneFridge(completion: @escaping (FridgeFull?, GGError?) -> Void) {
        let endpoint: Endpoint = GGEndpoint.Fridge.fridgeOne

        let parameters: Parameters = ["id": GoogleCatalogViewController.fridgeID]

        reqestHelper.request(endpoint.url, method: .post, parameters: parameters) { (data, error) in
            if let json = (data as? JSON)?["fridge"] as? JSON, let fridge = FridgeFull.findCreate(json: json) {
                completion(fridge, nil)
            } else {
                completion(nil, error)
            }
        }
    }

    static func openFridge(tocken: String?, completion: @escaping (String?, GGError?) -> Void) {
        let endpoint: Endpoint = GGEndpoint.Fridge.fridgeOpen

        var parameters: Parameters = ["fridge_id": GoogleCatalogViewController.fridgeID]

        if let tock = tocken {
            parameters["apple_pay_token"] = tock
        }

        reqestHelper.request(endpoint.url, method: .post, parameters: parameters) { (data, error) in
            if let json = data as? JSON, let str = json["lock_state"] {
                completion(str as? String, nil)
            } else {
                completion(nil, error)
                AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
            }
        }
    }

    static func addDataAccout(_ data: TupleDataAccount?, _ dataNotif: TupleDataAccountNotific?, completion: @escaping (JSON?, GGError?) -> Void) {
        let endpoint: Endpoint = GGEndpoint.User.addUserData

        var dict: [String: Any?] = [:]
        var dictConfig: [String: Any?] = [:]
        if let data = data {
            dict["first_name"] =    data.name
            dict["last_name"] =     data.lastName
            dict["middle_name"] =   nil
            dict["email"] =         data.email
        }

        if let dataNotif = dataNotif {
            dictConfig["cheque.notification.method"] = dataNotif.chequeNotificationMethod
            dictConfig["notification.disable"] = dataNotif.notificationDisable
            dictConfig["notification.successful_payment"] = dataNotif.notificationSuccessfulPayment
            dictConfig["notification.new_actions"] = dataNotif.notificationNewActions

            dict["config"] = dictConfig
        }

        let parameters: Parameters = ["user": dict]

        reqestHelper.request(endpoint.url, method: .post, parameters: parameters) { (data, error) in
            if error == nil, let json = data as? JSON {
                completion(json, nil)
            } else {
                completion(nil, error)
            }
        }
    }

    static func deleteCreditCard(_ cardId: Int, completion: @escaping (JSON?, GGError?) -> Void) {
        let endpoint: Endpoint = GGEndpoint.Card.deleteCard
        let parameters: Parameters = ["card_id": cardId]

        reqestHelper.request(endpoint.url, method: .post, parameters: parameters) { (data, error) in
            if error == nil, let json = data as? JSON {
                completion(json, nil)
            } else {
                completion(nil, error)
            }
        }
    }

    static func selectCreditCard(_ cardId: Int, tocken: String = "no", completion: @escaping (JSON?, GGError?) -> Void) {
        let endpoint: Endpoint = GGEndpoint.Card.selectCard
        var parameters: Parameters = ["card_id": cardId]

        if tocken != "no"{
            parameters["apple_pay_token"] = tocken
        }

        reqestHelper.request(endpoint.url, method: .post, parameters: parameters) { (data, error) in
            if error == nil, let json = data as? JSON {
                completion(json, nil)
            } else {
                completion(nil, error)
            }
        }
    }

    static func addCreditCard(completion: @escaping (AddCardModel?, GGError?) -> Void) {
        let endpoint: Endpoint = GGEndpoint.Card.addCart

        reqestHelper.request(endpoint.url, method: .post, parameters: nil) { (data, error) in
            if let json = data as? JSON, let account = AddCardModel(JSON: json) {
                completion(account, nil)
            } else {
                completion(nil, error)
            }
        }
    }

    static func checkNewCard(_ transaction: Int, completion: @escaping (JSON?, GGError?) -> Void) {
        let endpoint: Endpoint = GGEndpoint.Card.checkAdded

        let parameters: Parameters = ["transaction_id": transaction]

        reqestHelper.request(endpoint.url, method: .post, parameters: parameters) { (data, error) in
            if let json = data as? JSON {
                completion(json, nil)
            } else {
                completion(nil, error)
            }
        }
    }

    static func getPurchase(_ page: Int, size: Int = 20, completion: @escaping ([Purchase]?, GGError?) -> Void) {
        let endpoint: Endpoint = GGEndpoint.Purchase.getPurchase

        let parameters: Parameters = ["page": page, "size": size]

        reqestHelper.request(endpoint.url, method: .post, parameters: parameters) { (data, error) in
            if error == nil, let json = data as? JSON, let array = json["buys"] as? [JSON] {
                var returnArray: [Purchase]? = []

                for jso in array {
                    if let purch = Purchase.findCreate(json: jso) {
                        returnArray?.append(purch)
                    }
                }
                //                CoreDataManager.shared.save()
                completion(returnArray, nil)
            } else {
                completion(nil, error)
            }
        }
    }

    static func reqvestStatusopenFridge(completion: @escaping (JSON?, GGError?) -> Void) {
        let endpoint: Endpoint = GGEndpoint.Fridge.checkClosed

        let parameters: Parameters = ["fridge_id": GoogleCatalogViewController.fridgeID]

        reqestHelper.request(endpoint.url, method: .post, parameters: parameters) { (data, error) in
            if error == nil, let json = data as? JSON {
                completion(json, nil)
            } else {
                completion(nil, error)
            }
        }
    }

    static func prevPayment(completion: @escaping (JSON?, GGError?) -> Void) {
        let endpoint: Endpoint = GGEndpoint.Purchase.prevPayment

        reqestHelper.request(endpoint.url, method: .post) { (data, error) in
            if error == nil, let json = data as? JSON {
                completion(json, nil)
            } else {
                completion(nil, error)
            }
        }
    }

    static func getPurchaseNumber(_ purchaseId: Int32, completion: @escaping (Purchase?, GGError?) -> Void) {
        let endpoint: Endpoint = GGEndpoint.Purchase.onePurchase

        let parameters: Parameters = ["id": purchaseId]

        reqestHelper.request(endpoint.url, method: .post, parameters: parameters) { (data, error) in
            if error == nil, let json = data as? JSON, let purc = json["buy"] as? JSON {
                print(purc)

                let purch = Purchase.findCreate(json: purc)
                CoreDataManager.shared.save()
                completion(purch, nil)
            } else {
                completion(nil, error)
            }
        }
    }

    static func applePay(_ token: String, completion: @escaping (JSON?, GGError?) -> Void) {
        let endpoint: Endpoint = GGEndpoint.Card.applePay

        let parameters: Parameters = ["token": token]

        reqestHelper.request(endpoint.url, method: .post, parameters: parameters) { (data, error) in
            if error == nil, let data = data as? JSON {
                completion(data, nil)
            } else {
                completion(nil, error)
            }
        }
    }

    static func faq(completion: @escaping ([FAQmodel]?, GGError?) -> Void) {
        let endpoint: Endpoint = GGEndpoint.FAQ.faq

        reqestHelper.request(endpoint.url, method: .get, parameters: nil) { (data, error) in
            if error == nil, let json = data as? [JSON], let arrayModel = json as? [FAQmodel] {
                completion(arrayModel, nil)
            } else {
                completion(nil, error)
            }
        }
    }

    static func supportMail(_ message: String, completion: @escaping (Bool?, GGError?) -> Void) {
        let endpoint: Endpoint = GGEndpoint.FAQ.faqMail

        var parameters: Parameters = ["message": message]
        if let theme = InfoOrderVC.numberFeedBackOrder {
            parameters["subject"] = "Заказ №" + theme
        }

        reqestHelper.request(endpoint.url, method: .post, parameters: parameters) { (data, error) in
            if error == nil, let json = data as? JSON, let bool = json["koko"] as? Bool {
                completion(bool, nil)
            } else {
                completion(nil, error)
            }
        }
    }

    static func actions(completion: @escaping ([Promo]?, GGError?) -> Void) {
        let endpoint: Endpoint = GGEndpoint.Actions.actions

        reqestHelper.request(endpoint.url, method: .post, parameters: nil) { (data, error) in
            if error == nil, let json = data as? JSON, let array = json["promo"] as? [JSON] {
                var returnArray: [Promo]? = []

                for jso in array {
                    print(jso)
                    if let promo = Promo.findCreate(json: jso) {
                        returnArray?.append(promo)
                    }
                }

                returnArray = returnArray?.sorted(by: { $0.sort < $1.sort })
                completion(returnArray, nil)
            } else {
                completion(nil, error)
            }
        }
    }

    static func addFeedback(_ arrayTulps: [TupleReviews], completion: @escaping (Any?, GGError?) -> Void) {
        let endpoint: Endpoint = GGEndpoint.FAQ.feedback

        var valueArray: [[String: Any]] = [[:]]

        for tulp in arrayTulps {
            if tulp.ball != nil || tulp.text != nil {
                var value: [String: Any] = ["product_id": tulp.id]
                if let ball = tulp.ball {
                    value["mark"] = ball
                }
                if let text = tulp.text {
                    value["comment"] = text
                }
                valueArray.append(value)
            }
        }

        let parameters: Parameters = ["ProductFeedback": valueArray]

        reqestHelper.request(endpoint.url, method: .post, parameters: parameters) { (data, error) in
            if error == nil, let data = data {
                completion(data, nil)
            } else {
                completion(nil, error)
            }
        }
    }

    static func getIDFridge(completion: @escaping ([Int32]?, GGError?) -> Void) { //получение id активных холодильников
        let endpoint: Endpoint = GGEndpoint.Actions.actions

        reqestHelper.request(endpoint.url, method: .post, parameters: nil) { (data, error) in
            if error == nil, var array = data as? [Int32] {
                array = array.sorted(by: { $0 < $1 })
                completion(array, nil)
            } else {
                completion(nil, error)
            }
        }
    }

    ////////этого метода нет в документации он сбрасывает состояние двери, исполдьзуестся для теста холодильника в ауре
    static func closeFride(completion: @escaping (JSON?, GGError?) -> Void) {
        let endpoint: Endpoint = GGEndpoint.Fridge.fridgeClose

        let parameters: Parameters = ["fridge_id": 1]

        reqestHelper.request(endpoint.url, method: .post, parameters: parameters) { (data, error) in
            if let json = data as? JSON {
                completion(json, nil)
            } else {
                completion(nil, error)
            }
        }
    }
}
