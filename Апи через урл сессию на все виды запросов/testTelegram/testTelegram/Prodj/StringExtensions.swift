//
//  StringExtensions.swift
//  testTelegram
//
//  Created by Константин Ирошников on 20.11.2022.
//

import Foundation

extension String {
    func getDatwToString(
        _ formater: Date.DateFormaters = .base,
        timeZone: TimeZone = TimeZone.current,
        locale: Locale = Locale.current
    ) -> Date? {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formater.rawValue

        dateFormatter.timeZone = timeZone
        dateFormatter.locale = locale
        return dateFormatter.date(from: self)
    }

    func getNewDate(
        startFormater: Date.DateFormaters = .base,
        endFormater: Date.DateFormaters,
        timeZone: TimeZone = TimeZone.current,
        locale: Locale = Locale.current
    ) -> String? {
        guard let date = self.getDatwToString(startFormater) else {
            return nil
        }

        return date.decodableIn(endFormater, timeZone: timeZone, locale: locale)
    }
}
