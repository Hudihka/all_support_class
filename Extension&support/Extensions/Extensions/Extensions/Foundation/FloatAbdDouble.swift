//
//  FloatAbdDouble.swift
//  GinzaGO
//
//  Created by Username on 20.08.2019.
//  Copyright © 2019 Hudihka. All rights reserved.
//

import Foundation


// MARK: - Double

extension Double {

    func rounded(toPlaces places: Int) -> Double {//округление
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
