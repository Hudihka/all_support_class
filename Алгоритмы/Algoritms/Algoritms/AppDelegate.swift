//
//  AppDelegate.swift
//  Algoritms
//
//  Created by Худышка К on 02.05.2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        print("-------------------------")
        ProductArrayExceptSelf().test()
        print("-------------------------")
        
        return true
    }
}

