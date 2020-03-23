//
//  NSObject.swift
//  GinzaGO
//
//  Created by Username on 19.08.2019.
//  Copyright © 2019 Hudihka. All rights reserved.
//

import Foundation

// MARK: - NSObject

extension NSObject {
    static func performOnce(selector: Selector, afterDelay delay: TimeInterval, with object: Any? = nil) {
        cancelPreviousPerformRequests(withTarget: self, selector: selector, object: nil)
        self.perform(selector, with: object, afterDelay: delay)
    }

    func performOnce(selector: Selector, afterDelay delay: TimeInterval, with object: Any? = nil) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: selector, object: nil)
        self.perform(selector, with: object, afterDelay: delay)
    }

    class var className: String {
        return String(describing: self)
    }
}
