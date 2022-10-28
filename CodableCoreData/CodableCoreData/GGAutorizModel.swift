//
//  GGAutorizModel.swift
//  CodableCoreData
//
//  Created by Hudihka on 19/10/2021.
//

import Foundation

struct GGAutorizModel: Decodable {
	
	struct Code: Decodable {
		let code: String
	}
}

struct GGModelForAutoriz {
	var phone: String
	var code: String
	
	init(phone: String, codeModel: GGAutorizModel.Code) {
		self.phone = phone
		self.code = codeModel.code
	}
	
	var json: JSON {
		var json: JSON = [:]
		json["phone"] = phone
		json["code"] = code
		
		return json
	}
}
