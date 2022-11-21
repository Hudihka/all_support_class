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

        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard
                let self = self,
                let data = data
            else {
                self?.completionError(error: error, type: .other, completion: completion)
                return
            }

            do {
                let tracks = try JSONDecoder().decode(T.self, from: data)
                self.completion(tracks: tracks, completion: completion)
            } catch {
                self.completionError(error: error, type: .decodable, completion: completion)
            }
        }
        task.resume()
    }

    private func completion(
        tracks: T,
        completion: @escaping (T?, AFError?) -> Void
    ) {
        DispatchQueue.main.async {
            completion(tracks, nil)
        }
    }

    private func completionError(
        error: Error?,
        type: AFError.ErrorType,
        completion: @escaping (T?, AFError?) -> Void
    ) {
        DispatchQueue.main.async {
            let afError = AFError(error: error, type: type)
            completion(nil, afError)
        }
    }
}
