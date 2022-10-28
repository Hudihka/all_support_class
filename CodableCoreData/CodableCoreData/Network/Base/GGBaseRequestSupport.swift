//
//  GGBaseRequestSupport.swift
//  CodableCoreData
//
//  Created by Hudihka on 19/10/2021.
//

import Foundation
import Alamofire

final class GGSupportBaseRequest {
	private let method: HTTPMethod
	
	init(_ method: HTTPMethod) {
		self.method = method
	}
	
	var encoding: ParameterEncoding {
		let jsonMethods: [HTTPMethod] = [.post, .patch, .put]
		return jsonMethods.contains(method) ? JSONEncoding.default : URLEncoding.default
	}
	
	func handleError(data: Data) -> GGError?{
		do {
			let error = try JSONDecoder().decode(GGError.self, from: data)
			switch error.type {
			case .EFridgeAlreadyClosed:
				print("делаем логаут")
				return nil
			default:
				break
			}
			return error
		} catch {
			return GGError.codableError
		}
		return nil
	}
}
