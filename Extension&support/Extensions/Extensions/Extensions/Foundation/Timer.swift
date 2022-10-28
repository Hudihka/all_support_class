//
//  Timer.swift
//  GinzaGO
//
//  Created by Username on 20.08.2019.
//  Copyright © 2019 Hudihka. All rights reserved.
//

import Foundation

class BTTimer {
    private static var date: Date = Date()

    private var date: Date
    private var name: String

    static func start() {
        print("TIMER: started")
        date = Date()
    }

    static func log(_ string: String) {
        let time = -date.timeIntervalSinceNow
        print(String(format: "TIMER: %f - %@", time, string))
        date = Date()
    }

    init(_ nm: String) {
        name = nm
        print("TIMER(\(name)): started")
        date = Date()
    }

    func log(_ string: String? = nil) {
        let time = -date.timeIntervalSinceNow
        print(String(format: "TIMER(\(name)): %f - %@", time, string ?? "finished"))
        date = Date()
    }
}
