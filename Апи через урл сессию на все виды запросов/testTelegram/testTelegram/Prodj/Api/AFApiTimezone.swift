//
//  AFEndpointTimezone.swift
//  testTelegram
//
//  Created by Константин Ирошников on 20.11.2022.
//

protocol AFApiTimezoneProtocol {
    static func getTimezone(completion: @escaping (AFTimezone?) -> Void)
}

private extension AFEndpoint {
    enum City: String, Endpoint {
        case moscow = "Moscow"

        public var path: String {
            "timezone/Europe/" + self.rawValue
        }
    }
}

final class AFApiTimezone: AFApiTimezoneProtocol {
    static func getTimezone(completion: @escaping (AFTimezone?) -> Void) {
        let request = AFBaseRequest<AFTimezone>(endpoint: AFEndpoint.City.moscow)
        request.request { timeZone, _ in
            completion(timeZone)
        }
    }
}

