//
//  AppDelegate.swift
//  MathMonsters
//
//  Created by Админ on 18.01.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        guard let splitViewController = window?.rootViewController as? UISplitViewController,
              let leftNavController = splitViewController.viewControllers.first as? UINavigationController,
              let masterViewController = leftNavController.viewControllers.first as? MasterViewController,
              
              let detailViewController = splitViewController.viewControllers.last as? DetailViewController
          else {
            return true
        }

        let firstMonster = masterViewController.monsters.first
        detailViewController.monster = firstMonster
        
        
        
        return true
    }



}

