//
//  Date.swift
//  GinzaGO
//
//  Created by Username on 19.08.2019.
//  Copyright © 2019 ITMegastar. All rights reserved.
//

import Foundation

extension Date {
    func secondsHavePassed(_ seconds: Int) -> Bool { //проверяем, прошло ли данное количество секунд
        let delta = -1 * seconds
        let frieDaysHave = Date(timeIntervalSinceNow: TimeInterval(delta))
        let deltaTime = Calendar.current.compare(frieDaysHave, to: self, toGranularity: .second)

        if deltaTime.rawValue == -1 {
            return false // не прошло 3е суток
        } else {
            return true
        }
    }

    func printDate(format: String = "d MMMM yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "ru_RU")
        return dateFormatter.string(from: self)
    }
}
