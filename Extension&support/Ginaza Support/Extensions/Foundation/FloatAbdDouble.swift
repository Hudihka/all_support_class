//
//  FloatAbdDouble.swift
//  GinzaGO
//
//  Created by Username on 20.08.2019.
//  Copyright © 2019 ITMegastar. All rights reserved.
//

import Foundation

// MARK: - Float
extension Float {
    func separatedFloat() -> String { //перевод числа в строку нормального вида
        let str = String(self)
        let array = str.split(separator: ".")

        if array.isEmpty {
            return str
        } else {
            if array.last == "00" || array.last == "0" {
                return String(array.first ?? "0")
            } else {
                return str
            }
        }
    }
}

// MARK: - Double

extension Double {
    func formaterDistance() -> String { //переводит расстояние в м/км
        let km = "%@ км"
        let meter = "%@ м"

        if self < 1_000 {
            return String(format: meter, String(Int(floor(self))))
        } else {
            let distance = String((self / 1_000).rounded(toPlaces: 1))
            return String(format: km, distance)
        }
    }

    func rounded(toPlaces places: Int) -> Double {//округление
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
