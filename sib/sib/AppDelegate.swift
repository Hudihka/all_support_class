//
//  AppDelegate.swift
//  sib
//
//  Created by Константин Ирошников on 11.07.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

//        let types: [String.Encoding] = [
//            .ascii, .nextstep, .japaneseEUC, .utf8, .isoLatin1, .symbol,
//            .nonLossyASCII, .shiftJIS, .isoLatin2, .unicode, .windowsCP1251,
//            .windowsCP1252, .windowsCP1253, .windowsCP1254, .windowsCP1250,
//            .iso2022JP, .macOSRoman, .utf16, .utf16BigEndian, .utf16LittleEndian,
//            .utf32, .utf32BigEndian, .utf32LittleEndian
//        ]

        let types: [String.Encoding] = [
                .windowsCP1251
//                        .windowsCP1252, .windowsCP1253, .windowsCP1254, .windowsCP1250
        ]

        types.forEach { typ in
            self.openURL(typ)
        }

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

    /*

     public static let nextstep: String.Encoding

     public static let japaneseEUC: String.Encoding

     public static let utf8: String.Encoding

     public static let isoLatin1: String.Encoding

     public static let symbol: String.Encoding

     public static let nonLossyASCII: String.Encoding

     public static let shiftJIS: String.Encoding

     public static let isoLatin2: String.Encoding

     public static let unicode: String.Encoding

     public static let windowsCP1251: String.Encoding

     public static let windowsCP1252: String.Encoding

     public static let windowsCP1253: String.Encoding

     public static let windowsCP1254: String.Encoding

     public static let windowsCP1250: String.Encoding

     public static let iso2022JP: String.Encoding

     public static let macOSRoman: String.Encoding

     public static let utf16: String.Encoding

     public static let utf16BigEndian: String.Encoding

     public static let utf16LittleEndian: String.Encoding

     public static let utf32: String.Encoding

     public static let utf32BigEndian: String.Encoding

     public static let utf32LittleEndian: String.Encoding
     */

    func openURL(_ type : String.Encoding) {
        let url = "https:id_3411.html"
        if let myURL = URL(string: url) {
            do {
                let myHTMLString = try String(contentsOf: myURL, encoding: type)
                print("-------------- HTML : \(myHTMLString)")
//                <a rel="nofollow" href="tel
                let separator1 = "image\" content=\""
                let separator2 = "\" />"
                let telephone = "<a rel=\"nofollow\" href=\"tel"

                let hoursSeparator1 = "öåíà â ÷àñ: "
                let hoursSeparator2 = " - Sibirki </title>"

                guard
                    let last = myHTMLString.components(separatedBy: separator1).last,
                    let first = last.components(separatedBy: separator2).first
                else {
                    return
                }
                print(first)
            } catch {
                print("Error : \(error)")
            }
        } else {
            print("Error: \(url) doesn't  URL")
        }

//        do {
//            let myHTMLString = try String(contentsOf: myURL, encoding: .ascii)
////                print("type \(type)-------------- HTML : \(myHTMLString)")
//
//            let separator1 = "image\" content=\""
//            let separator2 = "\" />"
//
//            guard
//                let last = myHTMLString.components(separatedBy: separator1).last,
//                let first = last.components(separatedBy: separator2).first
//            else {
//                return
//            }
//            print(first)
//        } catch {
//            print("Error : \(error)")
//        }
    }

}

