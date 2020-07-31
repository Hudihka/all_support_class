//
//  PushStruct.swift
//  testLocalePush
//
//  Created by Админ on 21.05.2020.
//  Copyright © 2020 Админ. All rights reserved.
//

import Foundation


struct PushStruct {
    var finishDate: Date = Date()
    var textPush: String = "Текст описания"
    var id: String = "idPush"
    
    
    init(countSeconds: Double) {
        
        let finish = Date() + countSeconds
        
        self.finishDate = finish
        self.id = "\(String(describing: finishDate))"
        self.textPush = "Сработает в \(finish.printDate)"
    }
}


extension Date {
    
    var printDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        return dateFormatter.string(from: self)
    }
    
}
