//
//  CRHeaders.swift
//  Ceorooms
//
//  Created by Oleg Matveev on 25/12/2018.
//

import Foundation
import Alamofire
//TODO

enum GGHeader {
    static func authHeader() -> HTTPHeaders {
        var header = deviceParameters
//        if let id = DefaultsUtils.sessionID() {
//            header["X-Session-Id"] = id
//        }
        return header
    }

    static func basicHeader() -> HTTPHeaders {
        return deviceParameters
    }

    private static var deviceParameters: HTTPHeaders = {
        var parameters: HTTPHeaders = [:]

        let deviceId = UIDevice.current.identifierForVendor?.uuidString ?? randomString(WithLength: 30)

        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let deviceType = UIDevice.modelName
        parameters["X-Device-type"] = deviceType
        parameters["X-Device-Id"] = deviceId
        parameters["X-Device-Hash"] = GGHeader.getHash(str: (deviceId + ":" + deviceType))
        parameters["X-Device-Platform"] = "ios"
        parameters["X-Version"] = ApplicationOpportunities.versionAplication()

        return parameters
    }()

    static func getHash (str: String) -> String {
        return str.hmac(algorithm: .SHA1, key: "~?yTrhSxmCnmg}b7tv+`f]")
    }

    static func getIPAddresses() -> [String] {
        var addresses = ["http://ginzago.itmegastar.com/api/command/open-door"]

        var ifaddr: UnsafeMutablePointer<ifaddrs>?
        guard getifaddrs(&ifaddr) == 0 else {
            return []
        }
        guard let firstAddr = ifaddr else {
            return []
        }

        // For each interface ...
        for ptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let flags = Int32(ptr.pointee.ifa_flags)
            let addr = ptr.pointee.ifa_addr.pointee

            // Check for running IPv4, IPv6 interfaces. Skip the loopback interface.
            if (flags & (IFF_UP | IFF_RUNNING | IFF_LOOPBACK)) == (IFF_UP | IFF_RUNNING) {
                if addr.sa_family == UInt8(AF_INET) || addr.sa_family == UInt8(AF_INET6) {
                    // Convert interface address to a human readable string:
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    if getnameinfo(ptr.pointee.ifa_addr, socklen_t(addr.sa_len),
                                   &hostname, socklen_t(hostname.count),
                                   nil, socklen_t(0), NI_NUMERICHOST) == 0 {
                        let address = String(cString: hostname)
                        addresses.append(address)
                    }
                }
            }
        }

        freeifaddrs(ifaddr)
        return addresses
    }
}
