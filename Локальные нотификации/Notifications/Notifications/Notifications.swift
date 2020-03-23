//
//  Notifications.swift
//  Notifications
//
//  Created by Alexey Efimov on 28.06.2018.
//  Copyright © 2018 Alexey Efimov. All rights reserved.
//

import UIKit
import UserNotifications

class Notifications: NSObject, UNUserNotificationCenterDelegate {
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    func requestAutorization() {  //сообщаем что наше приложение теперь принимает нотификации
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            print("Permission granted: \(granted)")
            
            guard granted else { return }//если юзер разрешил нотификации
            self.getNotificationSettings()
        }
    }
    
    func getNotificationSettings() {
        notificationCenter.getNotificationSettings { (settings) in
            print("Notification settings: \(settings)")//здесь мы получаем настройки
                                                       //пуш уведомлений в случае если юзер разрешил их
        }
    }
    
    func scheduleNotification(notifaicationType: String) { //собственно запуск пуш уведомления
        
        let content = UNMutableNotificationContent()
        let userAction = "User Action"         //это тип пуш уведомлений, например пуши о необходимости оплатить заказ
        
        content.title = notifaicationType
        content.body = "This is example how to create " + notifaicationType
        content.sound = UNNotificationSound.default
        content.badge = 1
        content.categoryIdentifier = userAction

        //эта часть блока нужна если вы хотите добавить изображение в пуш
        guard let path = Bundle.main.path(forResource: "favicon", ofType: "png") else { return }
        
        let url = URL(fileURLWithPath: path)
        
        do {
            let attachment = try UNNotificationAttachment(
                identifier: "favicon",
                url: url,
                options: nil)
            
            content.attachments = [attachment]
        } catch {
            print("The attachment cold not be loaded")
        }

        ///////////////////////////////////////////////////////////////////

        
        //как быстро показать пуш нотификацию(здесь спустя 5 секунд)


//        let date = Date(timeIntervalSinceNow: 3600)//этот тригер нужен если мы хотим получать уведомления каждый день
//        let trigerDalay = Calendar.current.dateComponents([.hour, .minute, .second], from: date)


        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)//не повторять
        
        let identifire = "Local Notification"
        let request = UNNotificationRequest(identifier: identifire,
                                            content: content,
                                            trigger: trigger)

        /////////////////////////////////////////////////////////////////////\\\\\\
        
        notificationCenter.add(request) { (error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
        }

        //////////блок кода для добавления кнопок по обработке пушей
        //////////если оттянуть вниз пуш
        
        let snoozeAction = UNNotificationAction(identifier: "Snooze", title: "Snooze", options: [])
        let deleteAction = UNNotificationAction(identifier: "Delete", title: "Delete", options: [.destructive])
        let category = UNNotificationCategory(
            identifier: userAction,
            actions: [snoozeAction, deleteAction],
            intentIdentifiers: [],
            options: [])
        
        notificationCenter.setNotificationCategories([category])
        //////////////////////////

    }
    
    func userNotificationCenter(//метод делегата, обработка пушей на переднем плане приложения
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.alert, .sound]) //по сути просто просим показать алерт и звук
    }
    
    func userNotificationCenter(//метод делегата, обработка пушей в бэкграунде приложения
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void) {
        
        if response.notification.request.identifier == "Local Notification" {
            print("Handling notification with the Local Notification Identifire")
        }
        
        switch response.actionIdentifier {
        case UNNotificationDismissActionIdentifier:
            print("Dismiss Action")
        case UNNotificationDefaultActionIdentifier:
            print("Default")
        case "Snooze":
            print("Snooze")
            scheduleNotification(notifaicationType: "Reminder")
        case "Delete":
            print("Delete")
        default:
            print("Unknown action")
        }
        
        completionHandler()//////не забудь вызвать блок потом
    }

}
