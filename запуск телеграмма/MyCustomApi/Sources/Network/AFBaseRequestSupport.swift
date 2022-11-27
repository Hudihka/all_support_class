//
//  AFBaseRequestSupport.swift
//  testTelegram
//
//  Created by Константин Ирошников on 20.11.2022.
//

import Foundation

final class AFBaseRequestSupport {
    enum MetodsRequest: String {
        case get    = "GET"
        case post   = "POST"
        case patch  = "PATCH"
        case put    = "PUT"
    }

    private let method: MetodsRequest
    private let endpoint: Endpoint
    private let parametrs: JSON?

    init(
        endpoint: Endpoint,
        method: MetodsRequest,
        parametrs: JSON?
    ) {
        self.method = method
        self.endpoint = endpoint
        self.parametrs = parametrs
    }

    var generateURLRequest: URLRequest? {
        guard let url = generateUrl else {
            return nil
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        if let data = generateDataForRequest {
            request.httpBody = data
        }

        return URLRequest(url: url)
    }

    private var generateUrl: URL? {
        if requestIsBodyParametrs {
            guard var components = URLComponents(string: endpoint.path) else {
                return nil
            }

            components.queryItems = generateQueryItemParametrs
            components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")

            return components.url
        } else {
            return URL(string: endpoint.url)
        }
    }

    private var requestIsBodyParametrs: Bool {
        let jsonMethods: [MetodsRequest] = [.post, .patch, .put]

        return jsonMethods.contains(self.method)
    }

    private var generateDataForRequest: Data? {
        guard
            let parametrs = parametrs,
            requestIsBodyParametrs
        else {
            return nil
        }

        do {
            return try JSONSerialization.data(withJSONObject: parametrs, options: .prettyPrinted)
        } catch {
            return nil
        }
    }

    private var generateQueryItemParametrs: [URLQueryItem]? {
        guard
            let parametrs = parametrs,
            !requestIsBodyParametrs
        else {
            return nil
        }

        var newParametrs = [String : String]()

        for item in parametrs {
            if let val = item.value as? String {
                newParametrs[item.key] = val
            } else {
                newParametrs[item.key] = "\(item.value)"
            }
        }

        return newParametrs.map({ URLQueryItem(name: $0.key, value: $0.value) })
    }
}
