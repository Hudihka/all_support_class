//
//  Content.swift
//  CustomFont WatchKit Extension
//
//  Created by Константин Ирошников on 17.09.2022.
//

import Foundation
import UIKit

protocol Content {
    var font: UIFont? { get }
    var color: UIColor? { get }
    var text: String { get }
}

extension Content {
    static var content: [Content] {
        return [
            Colors.red,
            Colors.green,
            Colors.blue,
            Fonts.light,
            Fonts.medium,
            Fonts.bold
        ]
    }
}

enum Colors: String, Content {
    case red
    case green
    case blue

    var color: UIColor? {
        switch self {
        case .red:
            return .red
        case .green:
            return .green
        case .blue:
            return .blue
        }
    }

    var font: UIFont? {
        nil
    }

    var text: String {
        rawValue
    }
}

enum Fonts: String, Content {
    case light
    case medium
    case bold

    var font: UIFont? {
        switch self {
        case .light:
            return UIFont.systemFont(ofSize: 20, weight: .light)
        case .medium:
            return UIFont.systemFont(ofSize: 20, weight: .medium)
        case .bold:
            return UIFont.systemFont(ofSize: 20, weight: .bold)
        }
    }

    var color: UIColor? {
        nil
    }

    var text: String {
        rawValue
    }
}

struct Default: Content {
    var font: UIFont? {
        UIFont.systemFont(ofSize: 20, weight: .regular)
    }

    var color: UIColor? {
        .white
    }

    var text: String {
        "deafault"
    }
}
