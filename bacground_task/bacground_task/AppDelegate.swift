//
//  AppDelegate.swift
//  bacground_task
//
//  Created by Константин Ирошников on 15.06.2022.
//

import UIKit
import BackgroundTasks

// ссылка на статью
// https://www.andyibanez.com/posts/modern-background-tasks-ios13/
// не забудь добавить ключи в таргете и инфо плисте

// BGProcessingTask постоянно обновляют
// BGAppRefreshTask единоразово но долго
// BGTaskSchedulerPermittedIdentifiers массив стрингов в инфоплист

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // регистрируем задачу
        // using это queue на которой будет выполняться
        // если nil то создасться какая то другая
        BGTaskScheduler.shared.register(
            forTaskWithIdentifier: "com.andyibanez.fetchPokemon", using: nil
        ) { (task) in
            self.handleAppRefreshTask(task: task as! BGAppRefreshTask)
        }

        return true
    }

    func handleAppRefreshTask(task: BGAppRefreshTask) {
      task.expirationHandler = {
        task.setTaskCompleted(success: false)
        PokeManager.urlSession.invalidateAndCancel()
      }

      let randomPoke = (1...151).randomElement() ?? 1
      PokeManager.pokemon(id: randomPoke) { (pokemon) in
//      таким образом можно обновить юАй
//        NotificationCenter.default.post(name: .newPokemonFetched,
//                                        object: self,
//                                        userInfo: ["pokemon": pokemon])
        task.setTaskCompleted(success: true)
      }


      scheduleBackgroundPokemonFetch()
    }

    func scheduleBackgroundPokemonFetch() {
        // создаем задачу
        let pokemonFetchTask = BGAppRefreshTaskRequest(identifier: "com.andyibanez.fetchPokemon")
        // когда будет выполнена
        pokemonFetchTask.earliestBeginDate = Date(timeIntervalSinceNow: 60)
        do {
          try BGTaskScheduler.shared.submit(pokemonFetchTask)
        } catch {
          print("Unable to submit task: \(error.localizedDescription)")
        }
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

