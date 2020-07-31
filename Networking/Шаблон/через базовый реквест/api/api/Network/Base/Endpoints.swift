//
//  Endpoints.swift
//  api
//
//  Created by Hudihka on 04/05/2020.
//  Copyright © 2020 Tatyana. All rights reserved.
//

import Foundation


enum OTEndpoint {
	
	enum account {
		
		case base
		case tocken
		case wallet
		case gifts(String)
		case tips(String)
		case purchase(String)
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
