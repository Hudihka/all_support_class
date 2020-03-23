//
//  Endpoint.swift
//  Ceorooms
//
//  Created by Oleg Matveev on 25/12/2018.
//

import Foundation

protocol Endpoint {
    var path: String { get }
    var url: String { get }
}

extension Endpoint {
    public var url: String {
        return GGApiBase.url + path
    }
}

enum GGApiBase {
    static let url = "http://ginzago.itmegastar.com/api/"
}

enum GGEndpoint {
    enum AuthCode: Endpoint {
        case request
        case enter

        public var path: String {
            switch self {
            case .request: return       "auth-code/request"
            case .enter: return         "auth-code/enter"
            }
        }
    }

    enum Fridge: Endpoint {
        case fridgeAll
        case fridgeOne
        case fridgeOpen
        case fridgeClose
        case checkClosed

        public var path: String {
            switch self {
            case .fridgeAll: return     "fridge/list"
            case .fridgeOne: return     "fridge/one"
            case .fridgeOpen: return    "fridge/open"
            case .fridgeClose: return   "fridge/reset-door"
            case .checkClosed: return   "fridge/check-closed"
            }
        }
    }

    enum Card: Endpoint {
        case deleteCard
        case selectCard
        case addCart
        case checkAdded
        case applePay

        public var path: String {
            switch self {
            case .deleteCard: return    "card/remove"
            case .selectCard: return    "card/select"
            case .addCart: return       "card/add"
            case .checkAdded: return    "card/check-added"
            case .applePay: return      "card/add-applepay"
            }
        }
    }

    enum User: Endpoint {
        case me
        case addUserData

        public var path: String {
            switch self {
            case .me:          return   "user/me"
            case .addUserData: return   "user/update-me"
            }
        }
    }

    enum Purchase: Endpoint {
        case getPurchase
        case prevPayment
        case onePurchase

        public var path: String {
            switch self {
            case .getPurchase: return   "buy/list"
            case .prevPayment: return   "buy/prev-payment"
            case .onePurchase: return   "buy/one"
            }
        }
    }

    enum FAQ: Endpoint {
        case faq
        case faqMail
        case feedback

        public var path: String {
            switch self {
            case .faq:          return "faq"
            case .faqMail:      return "faq/request"
            case .feedback:     return "faq/add-feedback"
            }
        }
    }

    enum Actions: Endpoint {
        case actions

        public var path: String {
            switch self {
            case .actions: return "promo/list"
            }
        }
    }
}
