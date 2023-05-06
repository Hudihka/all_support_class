//
//  Content.swift
//  georgiaParser
//
//  Created by Худышка К on 07.03.2023.
//

import Foundation

struct EpicAndNumbers {
    let title: String
    let idTask: [Int]
//    let urlsTiket: [URL]
    
    init(title: String, idTask: [Int]) {
        self.title = title
        self.idTask = idTask
//        self.urlsTiket = idTask.compactMap({ URL(string: "https://teoria.on.ge/tickets?ticket=\($0)") })
    }
}

struct Qwestion {
    let title: String
    let answers: [Answer]
}

struct Answer {
    let title: String
    let itsTrue: Bool
}

final class Content {
    
    static let shared = Content()
    
    let epicks = [
        "" : "Водитель, пассажир и пешеход, знаки, условность",
//        "" : "Непристойность и условия вождения",
//        "" : "Предупреждающие знаки",
//        "" : "Знаки приоритета",
//        "" : "Запрещающие знаки",
//        "" : "указательные знаки",
//        "" : "Информационно-указательные знаки",
//        "" : "знаки обслуживания",
//        "" : "Дополнительные информационные знаки",
//        "" : "сигналы светофора",
//        "" : "Сигналы регулятора",
//        "" : "Использование специального сигнала",
//        "" : "Сигнализация аварийным маяком",
//        "" : "Световые инструменты, звуковой сигнал",
//        "" : "Движение, маневрирование, ходовая часть",
//        "" : "Обгон путем обхода встречного транспортного средства",
//        "" : "скорость движения",
//        "" : "Тормозной путь, расстояние",
//        "" : "перестань стоять",
//        "" : "Проезжая перекресток",
//        "" : "Железнодорожный переезд",
//        "" : "Трафик на шоссе",
//        "" : "Жилая зона, приоритет для автобуса",
//        "" : "Буксировка",
//        "" : "Учебный ход",
//        "" : "Доставка, люди, груз",
//        "" : "Велосипеды, мопеды и погони для скота",
//        "" : "Дорожная разметка",
//        "" : "Медицинская помощь",
//        "" : "Дорожная безопасность",
//        "" : "Административное право",
        "ეკო-მართვა" : "Эко-менеджмент[новый]"
    ]
    
    var epicQwestions: [String: [Int]] = [:]
}

extension String {

    //right is the first encountered string after left
    func between(_ left: String, _ right: String) -> String? {
        guard let leftRange = range(of: left), let rightRange = range(of: right, options: .backwards)
            ,leftRange.upperBound <= rightRange.lowerBound else { return nil }

        let sub = self[leftRange.upperBound...]
        let closestToLeftRange = sub.range(of: right)!
        return String(sub[..<closestToLeftRange.lowerBound])
    }

}

extension Array where Element: Equatable {
    var onlyUniqValues: [Element] {
        var returnArray = [Element]()
        
        for obj in self {
            if returnArray.contains(where: { $0 == obj }) == false{
                returnArray.append(obj)
            }
        }
        
        return returnArray
    }
}
