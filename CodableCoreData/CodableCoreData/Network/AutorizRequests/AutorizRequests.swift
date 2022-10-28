//
//  AutorizRequests.swift
//  CodableCoreData
//
//  Created by Hudihka on 19/10/2021.
//

import Foundation

protocol AutorizRequests {
	static func smsRequest(phone: String, completion: @escaping(GGAutorizModel.Code?, GGError?) -> Void)
	static func codeEnter(model: GGModelForAutoriz, completion: @escaping(GGAutorizModel.Code?, GGError?) -> Void)
}

final class GetSmsRequest: AutorizRequests {
	static func smsRequest(
		phone: String,
		completion: @escaping (GGAutorizModel.Code?, GGError?) -> Void) {
		
		let req = GGBaseRequestStruct<GGAutorizModel.Code>(
			endpoint: GGEndpoint.AuthCode.request,
			method: .post,
			parametrs: ["phone" : phone]
		)
		
		req.onSuccess = { obj, error in
			completion(obj, error)
		}
	}
	
	static func codeEnter(
		model: GGModelForAutoriz,
		completion: @escaping (GGAutorizModel.Code?, GGError?) -> Void) {
		
	}
	
	
}
