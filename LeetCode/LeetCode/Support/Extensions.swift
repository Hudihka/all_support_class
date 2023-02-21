//
//  Extensions.swift
//  LeetCode
//
//  Created by Худышка К on 21.02.2023.
//

import Foundation

extension Collection {
    subscript (safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
