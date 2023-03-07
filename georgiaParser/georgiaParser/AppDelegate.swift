//
//  AppDelegate.swift
//  georgiaParser
//
//  Created by Худышка К on 06.03.2023.
//

import UIKit

struct Epic {
    let title: String
    let urls: [URL]
    var idTask: [Int] = []
    
    init(title: String, urls: [URL]) {
        self.title = title.capitalized
        self.urls = urls
    }
    
//    mutating func updateNumbers() {
//        urls.forEach({ self.updateNumbersArray(url: $0) })
//    }
//
//    private mutating func updateNumbersArray(url: URL) {
//        do {
//            let contents = try String(contentsOf: url)
//            let arrayHTML = contents.components(separatedBy: "big-answers\">")
//            let arrayNumbers = arrayHTML
//                .compactMap({ $0.between("<div class=\"t-num\">#", "</div>") })
//                .compactMap({ Int($0) })
//
//            self.idTask = arrayNumbers
//            //
//            print(arrayNumbers)
//        } catch {
//            // contents could not be loaded
//        }
//    }
    
    
}


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //        t-num
        let epicks = [
            "Водитель, пассажир и пешеход, знаки, условность",
            "Непристойность и условия вождения",
            "Предупреждающие знаки",
            "Знаки приоритета",
            "Запрещающие знаки",
            "указательные знаки",
            "Информационно-указательные знаки",
            "знаки обслуживания",
            "Дополнительные информационные знаки",
            "сигналы светофора",
            "Сигналы регулятора",
            "Использование специального сигнала",
            "сигнализация аварийным маяком",
            "Световые инструменты, звуковой сигнал",
            "Движение, маневрирование, ходовая часть",
            "Обгон путем обхода встречного транспортного средства",
            "скорость движения",
            "Тормозной путь, расстояние",
            "перестань стоять",
            "Проезжая перекресток",
            "Железнодорожный переезд",
            "Трафик на шоссе",
            "Жилая зона, приоритет для автобуса",
            "Буксировка",
            "Учебный ход",
            "Доставка, люди, груз",
            "Велосипеды, мопеды и погони для скота",
            "Дорожная разметка",
            "Медицинская помощь",
            "дорожная безопасность",
            "Административное право",
            "Эко-менеджмент[новый]",
        ]
        
        var epicsArray = [Epic]()
        
        for (num, obj) in epicks.enumerated() {
            let numbPage = num + 1
            var strUrls: [URL] = []
            
            for pag in Array(1...20) {
                let str = "https://teoria.on.ge/tickets/2/\(numbPage)?page=\(pag)"
                if let url = URL(string: str) {
                    strUrls.append(url)
                }
            }
            
            epicsArray.append(Epic(title: obj, urls: strUrls))
        }
        
        var newEpics = [EpicAndNumbers]()
    
        
        for obj in epicsArray {
            
            var idTask: [Int] = []
            
            for objUrl in obj.urls {
                do {
                    let contents = try String(contentsOf: objUrl)
                    let arrayHTML = contents.components(separatedBy: "big-answers\">")
                    let arrayNumbers = arrayHTML
                        .compactMap({ $0.between("<div class=\"t-num\">#", "</div>") })
                        .compactMap({ Int($0) })
                    
                    idTask += arrayNumbers
                    //
                    print(arrayNumbers)
                } catch {
                    // contents could not be loaded
                }
            }
            
            newEpics.append(EpicAndNumbers(title: obj.title, idTask: idTask))
            
        }
        
        print(newEpics)
        
        
        // http://teoria.on.ge/tickets/2/1
        
        
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

