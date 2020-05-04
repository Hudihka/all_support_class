//
//  ReqestHelper.swift
//  Ceorooms
//
//  Created by Oleg Matveev on 28/12/2018.
//


import UIKit
import Alamofire

typealias CRReqestCompletion = ((Any?, OTError?) -> Void)

class CRReqest: NSObject {
    var dataReqest: DataRequest
    var completion: CRReqestCompletion

    var url: URLConvertible?
    var method: HTTPMethod?
    var parameters: Parameters?


    var inProgress = false

    init(reqest: DataRequest,
         url: URLConvertible?,
         method: HTTPMethod?,
         parameters: Parameters?,
         completion compl: @escaping CRReqestCompletion) {

        dataReqest = reqest
        completion = compl

        self.url = url
        self.method = method
        self.parameters = parameters

        super.init()
    }
}

class ReqestHelper: NSObject {
    private static let instance = ReqestHelper()
    private static var counter = 0

    private var requests: [CRReqest] = []

    private var networkStatus: NetworkReachabilityManager.NetworkReachabilityStatus = .unknown {
        didSet {
            if networkStatus == .reachable(.ethernetOrWiFi) || networkStatus == .reachable(.wwan) {
                performReqest()
            }
        }
    }

    override init() {
        super.init()

        NetworkReachabilityManager.shared?.listener = { [weak self] status in
            self?.networkStatus = status
        }
    }

    private func performReqest() {
        if NetworkReachabilityManager.shared?.isReachable ?? false == false {
            return
        }
        let rqests = requests

        for request in rqests {
            if request.inProgress {
                continue
            }

            request.inProgress = true

            request.dataReqest.responseJSON { (responce) in
                NetworkHelper.printResponse(responce)

                let check = NetworkHelper.check(response: responce)

                request.completion(check.data, check.error)

                if let error = check.error, error.updateToken, DefaultsUtils.currentAccount().isNormAccount {
                    self.completionRequest(request: request)
                    return
                } else {
                    self.finishRequestUpdate(request: request)
                }
            }
        }
    }

    private func completionRequest(request: CRReqest){
        RefreshTocken.refresh { (answer) in
            if answer{
//                self.finishRequestUpdate(request: request)
                self.reloadHeaders()
                self.performReqest()
            } else {
                request.inProgress = false
                self.requests = []
            }
        }
    }

    private func finishRequestUpdate(request: CRReqest){
        request.inProgress = false
        if let index = self.requests.firstIndex(of: request) {
            self.requests.remove(at: index)
        }
    }


    private func reloadHeaders(){

        if requests.isEmpty {
            return
        }


        var newRequsts: [CRReqest] = []

        for req in requests {
            if let url = req.url, let method = req.method {

                let compl = req.completion
                let parameters  = req.parameters

                let reqest = Alamofire.request(url,
                                               method: method,
                                               parameters: parameters,
                                               encoding: encodingMetod(method),
                                               headers: OTHeader.headerTocken)

                let crReaest = CRReqest(reqest: reqest,
                                        url: nil,
                                        method: nil,
                                        parameters: nil,
                                        completion: compl)

                newRequsts.append(crReaest)
            }
        }

        requests = newRequsts
    }

    func request(
        _ url: URLConvertible,
        method: HTTPMethod,
        parameters: Parameters? = nil,
        completion: @escaping CRReqestCompletion
        ) {

        let reqest = Alamofire.request(url,
                                       method: method,
                                       parameters: parameters,
                                       encoding: encodingMetod(method),
                                       headers: OTHeader.headerTocken)

        let crReaest = CRReqest(reqest: reqest, url: url, method: method, parameters: parameters, completion: completion)

        requests.append(crReaest)

        performReqest()
    }

    private func encodingMetod(_ method: HTTPMethod) -> ParameterEncoding{
        let jsonMethods: [HTTPMethod] = [.post, .patch, .put]
        return jsonMethods.contains(method) ? JSONEncoding.default : URLEncoding.default
    }

}

