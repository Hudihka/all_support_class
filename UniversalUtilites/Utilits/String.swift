//
//  String.swift
//  UniversalUtilites
//
//  Created by Худышка К on 26.05.2024.
//

import Foundation

public extension String {
    var makeURL: URL? {
        URL(string: self)
    }
}
