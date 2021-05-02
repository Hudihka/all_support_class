//
//  SceneDelegate.swift
//  MVVM
//
//  Created by Hudihka on 02/05/2021.
//  Copyright © 2021 OOO MegaStar. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?


	func scene(_ scene: UIScene,
			   willConnectTo session: UISceneSession,
			   options connectionOptions: UIScene.ConnectionOptions) {
		/*
		Используйте этот метод для дополнительной настройки и присоединения UIWindow `window` к предоставленной UIWindowScene` scene`.
		// При использовании раскадровки свойство `window` будет автоматически инициализировано и прикреплено к сцене.
		// Этот делегат не подразумевает, что соединяющаяся сцена или сеанс являются новыми (см. Вместо этого `application: configurationForConnectingSceneSession`).
		
		*/
		guard let _ = (scene as? UIWindowScene) else { return }
	}

	func sceneDidDisconnect(_ scene: UIScene) {
		print("00000")
	}

	func sceneDidBecomeActive(_ scene: UIScene) {
		print("начинаем РАЗвернули")
	}

	func sceneWillResignActive(_ scene: UIScene) {
		print("начинаем сворачив")
	}

	func sceneWillEnterForeground(_ scene: UIScene) {
		print("начинаем РАЗ сворачив")
	}

	func sceneDidEnterBackground(_ scene: UIScene) {
		print("свернули")
	}


}

