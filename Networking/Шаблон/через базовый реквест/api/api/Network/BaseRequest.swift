//
//  BaseRequest.swift
//  ChefMarket_2.0
//
//  Created by Александр Нейфельд on 16.03.2018.
//  Copyright © 2018 itMegaStar. All rights reserved.
//

import UIKit
import Alamofire

class MyError: Error{
    var message: String?
    var errorKeys: [String]?
}

extension MyError: LocalizedError {
    public var errorDescription: String? {
        return NSLocalizedString(message ?? "", comment: "My error")
    }
}

class BaseRequest: NSObject {
	
	private let baseURL = "базовый урл"
    
    var urlString: String {         // must override
        return "menus"
    }
    
    var method: HTTPMethod {        //override
        return .get
    }
    
    var parameters: [String: Any] { //override
        return [:]
    }
    
    var arrayParameter: Any {       //override
        return []
    }
    
    var onSuccess:(Any?, Error?)->() = {_,_ in
        
    }
	
	private var encodingMetod: ParameterEncoding {
        let jsonMethods: [HTTPMethod] = [.post, .patch, .put]
        return jsonMethods.contains(method) ? JSONEncoding.default : URLEncoding.default
    }
    
    
    private func handleAuthError(){
        //ошибка разлогна
    }
    
    private func internalHandle(_ _error: Error, data: Data){
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
            print(json ?? "error data is empty")
            if let temp = json!["message"] as? String {
                let errorTemp = MyError()
                errorTemp.message = temp
                if let errors = json!["errors"] as? Array<Dictionary<String, Any>>{
                    errorTemp.errorKeys = errors.compactMap{ $0["error_key"] as? String }
                }
                self.handle(error: errorTemp)
            } else {
                self.handle(error: _error)
            }
        } catch { self.handle(error: _error) }
    }
    
    func handle(error: Error){      //override
        onSuccess(nil, error)
    }
    
    func handle(_ array: Array<Dictionary<String,Any>>) {  //override
        onSuccess(array, nil)
    }
    
    func handle(_ json: Dictionary<String,Any>) {  //override
        onSuccess(json, nil)
    }
	

    func load(){
        request(baseURL + urlString,
				method: method,
				parameters: parameters,
				encoding: encodingMetod,
				headers: OTHeader.headerTocken)
            .downloadProgress { progress in
                
            }
            .validate()
            .responseJSON { [weak self] response in
                if let error = response.error {
                    print(response.error?.localizedDescription ?? "error was here")
                    
                    do {
                        let json = try JSONSerialization.jsonObject(with: response.data!, options: []) as? [String : Any]
                        print(json ?? "error data is empty")
                    } catch {}
                    
                    if response.response?.statusCode == 401 {
                        self?.handleAuthError()
                    } else {
                        self?.internalHandle(error, data: response.data ?? Data())
                    }
                    
                    return
                } else if let json = response.result.value as? Array<Dictionary<String,Any>> {
                    self?.handle(json)
                    return
                }
                
                if let json = response.result.value as? Dictionary<String,Any> {
                    self?.handle(json)
                    return
                }
                
                self?.onSuccess(nil, nil)
            }
    }
    
    
}
