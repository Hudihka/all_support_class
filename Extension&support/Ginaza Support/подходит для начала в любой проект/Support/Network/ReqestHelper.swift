//
//  ReqestHelper.swift
//  Ceorooms
//
//  Created by Oleg Matveev on 28/12/2018.
//

import UIKit
import Alamofire

typealias CRReqestCompletion = ((Any?, GGError?) -> Void)

class CRReqest: NSObject {
    var dataReqest: DataRequest
    var completion: CRReqestCompletion
    var inProgress = false

    init(reqest: DataRequest, completion compl: @escaping CRReqestCompletion) {
        dataReqest = reqest
        completion = compl
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
                if let error = check.error, let type = error.type {
                    if type == "EUnauthorized", ReqestHelper.counter == 0 {
                        //TODO
                        //замении на logauth
                        return
                    }
                }

                request.inProgress = false
                if let index = self.requests.firstIndex(of: request) {
                    self.requests.remove(at: index)
                }
            }
        }
    }

    func zeroCounter() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            ReqestHelper.counter = 0
        }
    }

    func request(
        _ url: URLConvertible,
        method: HTTPMethod,
        parameters: Parameters? = nil,
        headers: HTTPHeaders? = nil,
        encoding: ParameterEncoding? = nil,
        completion: @escaping CRReqestCompletion
        ) {
        let jsonMethods: [HTTPMethod] = [.post, .patch, .put]
        let encoding = encoding ?? (jsonMethods.contains(method) ? JSONEncoding.default : URLEncoding.default)
        let headers = headers ?? GGHeader.authHeader()

        let reqest = Alamofire.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)

        let crReaest = CRReqest(reqest: reqest, completion: completion)

        requests.append(crReaest)

        performReqest()
    }
}
