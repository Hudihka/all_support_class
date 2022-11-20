//
//  DateExtensions.swift
//  testTelegram
//
//  Created by Константин Ирошников on 20.11.2022.
//

import Foundation

extension Date {
    enum DateFormaters: String {
        case base           = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"

        case MMMdyyyy       = "d MMMM yyyy"
    }

    func decodableIn(
        _ format: DateFormaters,
        timeZone: TimeZone = TimeZone.current,
        locale: Locale = Locale.current
    ) -> String {
        let dateFormatterPrint = DateFormatter()

        dateFormatterPrint.dateFormat = format.rawValue
        dateFormatterPrint.locale = locale
        dateFormatterPrint.timeZone = timeZone

        let convertedDate = dateFormatterPrint.string(from: self)
        return convertedDate
    }
}
