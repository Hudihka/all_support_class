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
        //        1782
        
        var setsEpic: Set<String> = []
        var arrayNumberQwestion: [Int] = []

        // название темы
        //<a  href="/tickets/0/32" title="ეკო-მართვა"><span class="id">
        // [B, B1]
        
        // фаза 1 формирование тем и вопросов
        
//        DispatchQueue.global().async {
//            for i in 0...3000 {
//                let url = "https://teoria.on.ge/tickets?ticket=\(i)"
//                print(i)
//                if
//                    let text = self.getTextHTML(url),
//                    text.contains("[B, B1]"),
//                    let title = text.between("<a  href=\"/tickets/0/32\" title=\"", "\"><span class=\"id\">")
//                {
//                    arrayNumberQwestion.append(i)
//                    setsEpic.insert(title)
//                }
//            }
//            
//            print(arrayNumberQwestion.count)
//            print(setsEpic.count)
//            print(setsEpic)
//        
//            
//        }
        
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
    
    func epicQwestions(georgianEpic: String, number: Int) {
        guard let keyRussian = content.epicks[georgianEpic] else {
            return
        }
        
        if var arrayRussian = content.epicQwestions[keyRussian], arrayRussian.isEmpty == false {
                arrayRussian.append(number)
                content.epicQwestions[keyRussian] = arrayRussian
            
        } else {
            content.epicQwestions[keyRussian] = [number]
        }
    }
}
