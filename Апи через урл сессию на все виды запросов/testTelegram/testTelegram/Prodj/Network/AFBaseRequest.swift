//
//  AFBaseRequest.swift
//  testTelegram
//
//  Created by Константин Ирошников on 20.11.2022.
//

import Foundation

typealias JSON = [String: Any]

final class AFBaseRequest<T: Decodable> {
    private let session = URLSession.shared
    private let baseSupport: AFBaseRequestSupport

    init(
        endpoint: Endpoint,
        method: AFBaseRequestSupport.MetodsRequest = .get,
        parametrs: JSON? = nil
    ) {
        self.baseSupport = AFBaseRequestSupport(
            endpoint: endpoint,
            method: method,
            parametrs: parametrs
        )
    }

    func request(completion: @escaping (T?, AFError?) -> Void) {

        guard let request = baseSupport.generateURLRequest else {
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard
                let data = data
            else {
                let afError = AFError(error: error, type: .other)
                completion(nil, afError)
                return
            }

            do {
                let tracks = try JSONDecoder().decode(T.self, from: data)
                completion(tracks, nil)
            } catch {
                let afError = AFError(error: error, type: .decodable)
                completion(nil, afError)
            }
        }
        task.resume()
    }
}
