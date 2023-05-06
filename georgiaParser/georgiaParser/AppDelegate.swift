//
//  AppDelegate.swift
//  georgiaParser
//
//  Created by Худышка К on 06.03.2023.
//

import UIKit


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private let content = Content.shared
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //        1782  не верный 2991
        
//        <title>ეკო-მართვა ბილეთი #1782
//        <title>მოძრაობის უსაფრთხოება ბილეთი #839
        
//        print(getTextHTML("https://teoria.on.ge/tickets?ticket=839"))
        
        let georgian = [
            "ველოსიპედი, მოპედი და პირუტყვის გადარეკვა",
            "სამუხრუჭე მანძილი, დისტანცია",
            "მოძრაობის უსაფრთხოება",
            "სამედიცინო დახმარება",
            "გაჩერება დგომა",
            "პრიორიტეტის ნიშნები",
            "მძღოლი, მგზავრი და ქვეითი, ნიშნები, კონვეცია",
            "მაფრთხილებელი ნიშნები",
            "გზაჯვარედინის გავლა",
            "ეკო-მართვა",
            "რკინიგზის გადასასვლელი",
            "დამატებითი ინფორმაციის ნიშნები",
            "საგზაო მონიშვნა",
            "სანათი ხელსაწყოები, ხმოვანი სიგნალი",
            "მოძრაობის სიჩქარე",
            "სასწავლო სვლა",
            "მიმთითებელი ნიშნები",
            "სპეციალური სიგნალის გამოყენება",
            "საავარიო შუქური სიგნალიზაცია",
            "ამკრძალავი ნიშნები",
            "გადაზიდვები, ხალხი, ტვირთი",
            "ბუქსირება",
            "მოძრაობა, მანევრირება, სავალი ნაწილი",
            "გასწრება შემხვედრის გვერდის ავლით",
            "მოძრაობა ავტომაგისტრალზე",
             "მარეგულირებლის სიგნალები",
            "შუქნიშნის სიგნალები",
            "საინფორმაციო-მაჩვენებელი ნიშნები",
            "საცხოვრებელი ზონა, სამარშრუტოს პრიორიტეტი",
             "სერვისის ნიშნები",
            "უწესივრობა და მართვის პირობები",
            "ადმინისტრაციული კანონი"
        ]
        
        let russian = [
            "Велосипед, мопед и вождение скота",
            "тормозной путь, дистанция",
            "Дорожная безопасность",
            "Медицинская помощь",
            "перестань стоять",
            "Знаки приоритета",
            "Водитель, пассажир и пешеход, знаки, условность",
            "предупреждающие знаки",
            "Перекресток",
            "Эко-менеджмент",
            "Железнодорожный переезд",
            "Дополнительные информационные знаки",
            "дорожная разметка",
            "Светотехника, звуковой сигнал",
            "скорость движения",
            "обучающий ход",
            "указательные знаки",
            "По специальному сигналу",
            "Сигнализация аварийного маяка",
            "запрещающие знаки",
            "Доставка, Люди, Груз",
            "буксировка",
            "движение, маневрирование, ходовая часть",
            "обгон путем обхода встречного транспортного средства",
            "Движение по шоссе",
            "Сигналы регулятора",
            "Сигналы светофора",
            "Информационно-указательные знаки",
            "Жилая зона, автобусный приоритет",
            "Знаки обслуживания",
            "Неровности и условия движения",
            "Административное право"
        ]
        
        var setsEpic: [String] = []
        var arrayNumberQwestion: [Int] = []

        // название темы
        //<a  href="/tickets/0/32" title="ეკო-მართვა"><span class="id">
        // [B, B1]
        
        // фаза 1 формирование тем и вопросов
        
        DispatchQueue.global().async {
            for i in 0...3000 {
                print(i)
                let url = "https://teoria.on.ge/tickets?ticket=\(i)"
                if
                    let text = self.getTextHTML(url),
                    text.contains("[B, B1]"),
                    let title = text.between("<title>", " ბილეთი #\(i)"),
                    let geoggianIndex = georgian.firstIndex(where: { $0 == title }),
                    let russianText = russian[safe: geoggianIndex]?.capitalizingFirstLetter()
                {
                    if let indexRussianStruct = self.content.epicks.firstIndex(where: { $0.russName == russianText}) {
                        let old = self.content.epicks[indexRussianStruct]
                        let newArray = old.arrayNumbers + [i]
                        let new = Epic(
                            number: old.number,
                            russName: russianText,
                            arrayNumbers: newArray
                        )
                        self.content.epicks[indexRussianStruct] = new
                    } else {
                        let index = self.content.epicks.count
                        let new = Epic(
                            number: index,
                            russName: russianText,
                            arrayNumbers: [i]
                        )
                        self.content.epicks.append(new)
                    }
                }
            }

            print(self.content.epicks)


        }
        
        
        
        // фаза 2 формирование дикшинари [тема : список вопросов]
        
        return true
    }
}

private extension AppDelegate {
    func getTextHTML(_ url: String) -> String? {
        guard let urlUrl = URL(string: url) else {
            return nil
        }
        
        do {
            let contents = try String(contentsOf: urlUrl)
            return contents
        } catch {
            return nil
        }
    }
    
//    func epicQwestions(georgianEpic: String, number: Int) {
//        guard let keyRussian = content.epicks[georgianEpic] else {
//            return
//        }
//
//        if var arrayRussian = content.epicQwestions[keyRussian], arrayRussian.isEmpty == false {
//                arrayRussian.append(number)
//                content.epicQwestions[keyRussian] = arrayRussian
//
//        } else {
//            content.epicQwestions[keyRussian] = [number]
//        }
//    }
}

extension Array {
    subscript (safe index: Index) -> Element? {
        0 <= index && index < count ? self[index] : nil
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
