//
//  AFTimezone.swift
//  testTelegram
//
//  Created by Константин Ирошников on 20.11.2022.
//

import Foundation

struct AFTimezone: Decodable {
    let abbreviation: String
    let datetime: String
    let timezone: String
}

extension AFTimezone {
    func pintDate(
        formater: Date.DateFormaters
    ) -> String? {
        datetime.getNewDate(endFormater: formater)
    }
}
