//
//  Utils.swift
//  Ceorooms
//
//

import UIKit

enum Utils {
    // MARK: - External apps

    static func openUrl(_ url: URL) {
        if UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }

    static func openSystemSettings() {
        if let url = URL(string: "App-Prefs:") {
            openUrl(url)
        }
    }

    static func openAppSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            openUrl(url)
        }
    }

    static func call(phone: String) {
        if let url = URL(string: "tel://\(phone)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.openURL(url)
        }
    }
}

public extension ComparisonResult {
    var ascending: Bool {
        switch self {
        case .orderedAscending:
            return true

        default:
            return false
        }
    }

    var descending: Bool {
        switch self {
        case .orderedDescending:
            return true

        default:
            return false
        }
    }

    var same: Bool {
        switch self {
        case .orderedSame:
            return true

        default:
            return false
        }
    }
}
