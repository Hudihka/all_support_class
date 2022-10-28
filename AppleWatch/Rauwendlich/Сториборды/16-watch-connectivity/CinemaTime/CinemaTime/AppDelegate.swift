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

import UIKit
// библиотека для обмена инфой
import WatchConnectivity

let NotificationPurchasedMovieOnPhone = "PurchasedMovieOnPhone"
let NotificationPurchasedMovieOnWatch = "PurchasedMovieOnWatch"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  lazy var notificationCenter: NotificationCenter = {
    return NotificationCenter.default
    }()
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
    setupTheme(application: application)
    setupWatchConnectivity()
    setupNotificationCenter()
    return true
  }
  
  // MARK: - Theme
  
  private func setupTheme(application: UIApplication) {
    // UINavigationBar
    UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor(red:1, green:1, blue:1, alpha:1)]
    UINavigationBar.appearance().barTintColor = UIColor(red: 157.0/255.0, green: 42.0/255.0, blue: 42.0/255.0, alpha: 1.0)
    
    // UIScrollView and UITableView
    UITableView.appearance().backgroundColor = UIColor(red: 43/255.0, green: 43/255.0, blue: 43/255.0, alpha: 1)
    
    // Application
    application.statusBarStyle = UIStatusBarStyle.lightContent
  }
  
  // MARK: - Notification Center
  
  private func setupNotificationCenter() {
    notificationCenter.addObserver(forName: NSNotification.Name(rawValue: NotificationPurchasedMovieOnPhone), object: nil, queue: nil) { (notification:Notification) -> Void in
      self.sendPurchasedMoviesToWatch(notification)
    }
  }
}

// MARK: - Watch Connectivity
extension AppDelegate {
  
  func setupWatchConnectivity() {
    // Вы проверяете, поддерживает ли текущее устройство Watch Connectivity
    if WCSession.isSupported() {
      // Далее вы устанавливаетесеанск объекту одноэлементного сеансадефолтдля текущего устройства.
      let session = WCSession.default
      session.delegate = self
      session.activate()
    }
  }
  
  func sendPurchasedMoviesToWatch(_ notification: Notification) {
    // Сначала вы проверяете, поддерживает ли текущее устройство Watch Connectivity.
    if WCSession.isSupported() {
      // 2
      if let movies = TicketOffice.sharedInstance.purchasedMovieTicketIDs() {
        // Вы устанавливаете константусеанск сеансу подключения по
        // умолчанию и проверьте установку соответствующего приложения Watch.
        // Если пользователь не установил приложение Watch, нет смысла пытаться с ним общаться.
        let session = WCSession.default
        if session.isWatchAppInstalled {
          // Наконец, вы звонитеupdateApplicationContext(_:) на активном
          // сеансе передать в Watch словарь сфильмыключ установлен
          // на уже созданныйфильмымножество
          do {
            let dictionary = ["movies": movies]
            try session.updateApplicationContext(dictionary)
          } catch {
            print("ERROR: \(error)")
          }
        }
      }
    }
  }
}

extension AppDelegate: WCSessionDelegate {
  // 1
  func sessionDidBecomeInactive(_ session: WCSession) {
    /*
     Сеанс вызывает этот метод, когда обнаруживает, что пользователь переключился
     на другие Apple Watch, а предыдущий сеанс теперь неактивен. Сеанс находится в
     этом состоянии в течение небольшого промежутка времени, поэтому он может обрабатывать
     любые данные, которые уже были переданы, но не обработаны. CinemaTime не нужно
     ничего делать, когда это вызывается, но другие приложения могут использовать
     этот обратный вызов для очистки локальных хранилищ данных.
     */
  }
  // 2
  func sessionDidDeactivate(_ session: WCSession) {
    /*
     Сеанс вызывает этот метод, когда больше нет данных, ожидающих
     доставки в приложение, и предыдущий сеанс может быть официально закрыт.
     Приложение для iPhone должно вызывать активироватьдля
     подключения к новому Watch к новому сеансу.
     */
    print("WCSession.default.activate()")
    WCSession.default.activate()
  }
  // 3
  func session(
    _ session: WCSession, activationDidCompleteWith
    activationState: WCSessionActivationState,
    error: Error?
  ) {
    /*
     вызывается при активации сеанс заканчивается. Этот обратный
     вызов дает приложению возможность узнать, была ли активация
     сеанса успешной. CinemaTime не нужно ничего делать, когда это вызывается.
     */
    if let error = error {
      print("WC Session activation failed with error: " + "\(error.localizedDescription)")
      return
    }
    print("WC Session activated with state: " + "\(activationState.rawValue)")
  }

  func session(
    _ session: WCSession, didReceiveApplicationContext
    applicationContext:[String:Any]
  ) {
    // 2
    if let movies = applicationContext["movies"] as? [String] {
      // 3
      TicketOffice.sharedInstance.purchaseTicketsForMovies(movies)
      //4
      DispatchQueue.main.async {
        let notificationCenter = NotificationCenter.default
        notificationCenter.post(
          name: NSNotification.Name(rawValue: NotificationPurchasedMovieOnWatch),
          object: nil
        )
      }
    }

  }
}
