/**
 * Copyright (c) 2017 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import WatchKit

class ExtensionDelegate: NSObject, WKExtensionDelegate {

    func applicationDidFinishLaunching() {
        // Perform any final initialization of your application.
    }

    func applicationDidBecomeActive() {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillResignActive() {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, etc.
    }

    func handle(_ backgroundTasks: Set<WKRefreshBackgroundTask>) {
        print("\n handling snapshot task \n")

        // 1
        let nextMatchDate = season.upcomingMatches.first?.date
        let lastMatchExpiresTimeInterval = season.playedMatches.last?.date.timeIntervalSince(Date().yesterday)

        // возвращаемся к корневому
        let wkExtension = WKExtension.shared()
        wkExtension.rootInterfaceController?.popToRootController()

        // Отправляется, когда системе нужно запустить приложение
        // в фоновом режиме для обработки задач. Задачи поступают набором, поэтому
        // прокручивайте и обрабатывайте каждую из них.
        for task in backgroundTasks {
            // Use a switch statement to check the task type
            switch task {
            case let backgroundTask as WKApplicationRefreshBackgroundTask:
                // Обязательно завершите фоновую задачу, // когда закончите.
                backgroundTask.setTaskCompletedWithSnapshot(false)
            case let snapshotTask as WKSnapshotRefreshBackgroundTask:
                //          Проверяем, был ли последний матч недавно сыгран

                if let lastMatchExpiresTimeInterval = lastMatchExpiresTimeInterval, lastMatchExpiresTimeInterval > 0 {
                    let expiration = Date().addingTimeInterval(lastMatchExpiresTimeInterval)
                    // Move to record controller
                    wkExtension.rootInterfaceController?.pushController(withName: "RecordInterfaceControllerType", context: nil)
                    //              Вы устанавливаете срок действия моментального снимка через 24 часа после того, как игра произошла
                    snapshotTask.setTaskCompleted(restoredDefaultState: false, estimatedSnapshotExpiration: expiration, userInfo: nil)
                    break
                }

                // 5
                // Check if the next match will happen soon
                if let nextMatchDate = nextMatchDate, nextMatchDate.timeIntervalSinceNow < Date().tomorrow.timeIntervalSinceNow {
                    // 6
                    // Move to schedule controller
                    wkExtension.rootInterfaceController?.pushController(
                        withName: "ScheduleInterfaceControllerType",
                        context: nil
                    )
                    // 7
                    // Move to schedule detail controller
                    // for `context` use the index of upcoming matches, first is 0
                    wkExtension.rootInterfaceController?.pushController(withName: "ScheduleDetailInterfaceControllerType", context: 0)
                    // 8
                    snapshotTask.setTaskCompleted(
                        restoredDefaultState: false,
                        estimatedSnapshotExpiration: nextMatchDate,
                        userInfo: nil
                    )
                    break
                }

                if let nextMatchDate = nextMatchDate {
                  // Move to schedule controller
                  wkExtension.rootInterfaceController?.pushController(withName: "ScheduleInterfaceControllerType", context: nil)
                  // Check back 24 hours before next match
                  let expiration = nextMatchDate.yesterday
                  snapshotTask.setTaskCompleted(restoredDefaultState: false, estimatedSnapshotExpiration: expiration, userInfo: nil)
                  break
                }

                // Задачи моментальных снимков имеют уникальный вызов завершения,
                // убедитесь, что вы установили дату истечения срока действия
                snapshotTask.setTaskCompleted(restoredDefaultState: true, estimatedSnapshotExpiration: Date.distantFuture, userInfo: nil)
            case let connectivityTask as WKWatchConnectivityRefreshBackgroundTask:
                // Be sure to complete the connectivity task once you’re done.
                connectivityTask.setTaskCompletedWithSnapshot(false)
            case let urlSessionTask as WKURLSessionRefreshBackgroundTask:
                // Be sure to complete the URL session task once you’re done.
                urlSessionTask.setTaskCompletedWithSnapshot(false)
            default:
                // make sure to complete unhandled task types
                task.setTaskCompletedWithSnapshot(false)
            }
        }
    }

}
