//
//  OTEndpoint.swift
//  TC5 ЕР
//
//  Created by Username on 03.12.2019.
//  Copyright © 2019 Hudihka. All rights reserved.
//

import Foundation

typealias JSON = [String: Any]

protocol Endpoint {
    var path: String { get }
    var url: String { get }
}

extension Endpoint {
    public var url: String {
        return OTApiBase.getURLSerwer() + path
    }
}

class OTApiBase: NSObject {

    static func getURLSerwer() -> String {

        return "добавь урл"
    }
}

enum OTEndpoint {
    enum AuthCode: Endpoint {
        case auth
        case refresh

        public var path: String {
            switch self {
            case .auth: return          "v1/auth"
            case .refresh: return       "v1/auth/refresh-token"
            }
        }
    }


    enum User: Endpoint {
        case user
        case deleteTocken
        case updateTocken

        public var path: String {
            switch self {
            case .user: return                "v1/user"
            case .deleteTocken: return        "v1/user/delete-device-token"
            case .updateTocken: return        "v1/user/update-device-token"
            }
        }
    }


    enum Notifications: Endpoint {
        case notifications
        case notificationsCount

        public var path: String {
            switch self {
            case .notifications: return                "v1/notifications"
            case .notificationsCount: return           "v1/notifications/count"
            }
        }
    }

    enum Task: Endpoint {
        case tasks

        public var path: String {
            switch self {
            case .tasks: return                "v1/tasks"
            }
        }
    }

    enum Filters: Endpoint {
        case filters

        public var path: String {
            switch self {
            case .filters: return                "v1/filters"
            }
        }
    }

}

/*если хотим передавать параметр
enum account: Endpoint {
	
	case base
	case tocken
	case wallet
	case gifts(String)
	case tips(String)
	case purchase(String)
	case addFriends
	case settings
	
	public var path: String {
		
		switch self {
		case .base: return "account"
		case .tocken: return "token"
		case .wallet: return "\(account.base.path)/wallet"
		case .gifts(let ID): return "accounts/\(ID)/gifts"
		case .tips(let ID): return "accounts/\(ID)/tips"
		case .purchase(let languageCode): return "purchase/token/url?lang=\(languageCode)"
		case .settings: return "account/settings"
		}
	}
*/
