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
import WatchConnectivity

let NotificationPurchasedMovieOnWatch = "PurchasedMovieOnWatch"

class ExtensionDelegate: NSObject, WKExtensionDelegate {
  
  lazy var documentsDirectory: String = {
      return NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first!
    }()
  
  lazy var notificationCenter: NotificationCenter = {
    return NotificationCenter.default
    }()
  
  func applicationDidFinishLaunching() {
    setupWatchConnectivity()
    setupNotificationCenter()
  }
  
  // MARK: - Notification Center
  
  private func setupNotificationCenter() {
    notificationCenter.addObserver(forName: NSNotification.Name(rawValue: NotificationPurchasedMovieOnWatch), object: nil, queue: nil) { (notification:Notification) -> Void in
      self.sendPurchasedMoviesToPhone(notification)
    }
  }
}

// MARK: - Watch Connectivity
extension ExtensionDelegate {
  
  func setupWatchConnectivity() {
    if WCSession.isSupported() {
      let session  = WCSession.default
      session.delegate = self
      session.activate()
    }
  }
  
  func sendPurchasedMoviesToPhone(_ notification:Notification) {
    // 1
    if WCSession.isSupported() {
      // 2
      if let movies = TicketOffice.sharedInstance.purchasedMovieTicketIDs() {
        // 3
        do {
          let dictionary = ["movies": movies]
          try WCSession.default.updateApplicationContext(dictionary)
        } catch {
          print("ERROR: \(error)")
        }
      }
    }
  }
}

extension ExtensionDelegate: WCSessionDelegate {
  func session(
    _ session: WCSession,
    activationDidCompleteWith activationState: WCSessionActivationState,
    error: Error?
  ) {
    if let error = error {
      print("WC Session activation failed with error: " + "\(error.localizedDescription)")
      return
    }
    print("WC Session activated with state: " + "\(activationState.rawValue)")
  }

  func session(
      _ session: WCSession,
      didReceiveApplicationContext applicationContext: [String : Any]
  ) {
    /*
     В вашем коде реализован необязательный WCSessionDelegat eметод протокола
     сеанс(_:didReceiveApplicationContext:). Активный сеанс связи вызывает
     этот метод, когда он получает контекстные данные
     из приложения-аналога для iPhone
     */

    if let movies = applicationContext["movies"] as? [String] {
      // 3
      TicketOffice.sharedInstance.purchaseTicketsForMovies(movies)
      /*
       вы перезагружаете контроллер корневого интерфейса в основную очередь,
       чтобы отобразить купленные билеты в кино. Обратный вызов делегата происходит
       в фоновой очереди, поэтому перезагрузка должна происходить в основной
       очереди, чтобы инициировать обновления пользовательского интерфейса.
       */
      DispatchQueue.main.async {
        WKInterfaceController.reloadRootPageControllers(
          withNames: ["PurchasedMovieTickets"],
          contexts: nil,
          orientation: WKPageOrientation.vertical,
          pageIndex: 0
        )
      }
    }
  }
}
