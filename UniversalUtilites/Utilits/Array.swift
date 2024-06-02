//
//  Array.swift
//  UniversalUtilites
//
//  Created by Худышка К on 02.06.2024.
//

import Foundation

public extension Array {
    var isNotEmpty: Bool {
        !isEmpty
    }
    
    subscript(safe index: Int) -> Element? {
       guard index >= 0, index < endIndex else {
           return nil
       }

       return self[index]
   }
}
