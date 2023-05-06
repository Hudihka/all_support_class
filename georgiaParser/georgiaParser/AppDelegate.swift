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
        
//        let myURLString = "https://teoria.on.ge/tickets?ticket=839"

//        print(getTextHTML(myURLString))
        
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
