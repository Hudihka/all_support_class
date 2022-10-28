//
//  NotificationService.swift
//  NotificationService
//
//  Created by Hudihka on 20/06/2019.
//  Copyright © 2019 Alexey Efimov. All rights reserved.
//

import UserNotifications

class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent) //по сути это то что получаем с нотификацией(словарик)

        guard let bestAttemptCont = bestAttemptContent,
            let apsData = bestAttemptCont.userInfo["aps"] as? [String: Any],
            let attachmentURLAsString = apsData["attachment-url"] as? String,//вытаскиваем урл
            let attachmentUrl = URL(string: attachmentURLAsString) else {
                return }

        downloadImageFrom(url: attachmentUrl) { (attachment) in     //делаем загрузку через урл
            if attachment != nil {
                bestAttemptCont.attachments = [attachment!]//добавляем получившийся файл в массив контента
                self.contentHandler!(bestAttemptCont)       //воспроизводим
            }
        }
    }
    
    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }

}

extension NotificationService {

    private func downloadImageFrom(url: URL, with completionHandler: @escaping(UNNotificationAttachment?) -> Void) {

        let task = URLSession.shared.downloadTask(with: url) { (downloadUrl, response, error) in

            guard let downloadUrl = downloadUrl else {  //получили что нибудь??
                completionHandler(nil)
                return
            }

            var urlPath = URL(fileURLWithPath: NSTemporaryDirectory()) //создаем временное хранилище в директории

            let uniqueURLEnding = ProcessInfo.processInfo.globallyUniqueString + ".png" // название для файла что будет сохранено во временное хранилище
            //где ProcessInfo.processInfo.globallyUniqueString это название процесса что сейчас происходит
            urlPath = urlPath.appendingPathComponent(uniqueURLEnding)                   //сохранение по этому адресу загруженного изображения
            try? FileManager.default.moveItem(at: downloadUrl, to: urlPath)

            do {
                let attachment = try UNNotificationAttachment(identifier: "favicon", url: urlPath, options: nil) //ну собственно получаем
                //обьектт что хотим использовать
                completionHandler(attachment)
            } catch {
                completionHandler(nil)
            }
        }
        task.resume()
    }
}

