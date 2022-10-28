//
//  GGBaseReques.swift
//  CodableCoreData
//
//  Created by Константин Ирошников on 17.10.2021.
//

import Foundation
import Alamofire
import CoreData

typealias JSON = [String: Any]
typealias ArrayJSON = [[String: Any]]

final class GGBaseRequestCD<T: GGDecodable>: NSObject {
	private let method: HTTPMethod
	private let endpoint: Endpoint
	private let parametrs: JSON?
	private let context: NSManagedObjectContext?
	private let support: GGSupportBaseRequest
	
	final var onSuccessOnce:(T?, GGError?)->() = {_,_ in }
	final var onSuccessArray:([T]?, GGError?)->() = {_,_ in }
	
	init(
		endpoint: Endpoint,
		method: HTTPMethod = .get,
		parametrs: JSON? = nil,
		context: NSManagedObjectContext? = nil
	){
		self.method = method
		self.endpoint = endpoint
		self.parametrs = parametrs
		self.context = context
		self.support = GGSupportBaseRequest(method)
	}
	
	private func success(
		once: T? = nil,
		array: [T]? = nil,
		error: GGError? = nil
	) {
		onSuccessOnce(once, error)
		onSuccessArray(array, error)
	}
	
	func load() {
		AF.request(endpoint.url,
				   method: method,
				   parameters: parametrs,
				   encoding: support.encoding,
				   headers: GGHeaders.basicHeader)
			.validate()
			.responseJSON { response in
				
				switch response.result {
				case .success:
					self.handleJson(response: response)
				case .failure:
					guard let data = response.data,
						  let error = self.support.handleError(data: data) else {
						self.success()
						return
					}
					self.success(error: error)
				}
		}
		
	}
	
	private func handleJson(response: AFDataResponse<Any>){
		if let value = response.value {
			if let jsonArray = value as? ArrayJSON {
				let objs = jsonArray.map { T.create($0, context: context) }
				success(array: objs)
			} else if let json = value as? JSON {
				let obj = T.create(json, context: context)
				success(once: obj)
			}
		}
	}
}

final class GGBaseRequestStruct<T: Decodable>: NSObject {
	private let method: HTTPMethod
	private let endpoint: Endpoint
	private let parametrs: JSON?
	private let support: GGSupportBaseRequest
	
	final var onSuccess:(T?, GGError?)->() = {_,_ in }
	
	init(
		endpoint: Endpoint,
		method: HTTPMethod = .get,
		parametrs: JSON? = nil
	){
		self.method = method
		self.endpoint = endpoint
		self.parametrs = parametrs
		self.support = GGSupportBaseRequest(method)
	}
	
	func load() {
		AF.request(endpoint.url,
				   method: method,
				   parameters: parametrs,
				   encoding: support.encoding,
				   headers: GGHeaders.basicHeader)
			.validate()
			.responseJSON { response in
				guard
					let data = response.data
				else {
					self.onSuccess(nil, nil)
					return
				}
				
				switch response.result {
				case .success:
					self.handleData(data: data)
				case .failure:
					if let error = self.support.handleError(data: data) {
						self.onSuccess(nil, error)
					}
				}
		}
		
	}
	
    private func handleData(data: Data){
        do {
			let decode = try JSONDecoder().decode(T.self, from: data)
            onSuccess(decode, nil)
        } catch {
			onSuccess(nil, GGError.codableError)
            print("не получилось декодировать")
        }
    }
}
