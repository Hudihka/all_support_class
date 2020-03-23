//
//  DataProvider.swift
//  Networking
//
//  Created by Alexey Efimov on 13.09.2018.
//  Copyright © 2018 Alexey Efimov. All rights reserved.
//

import UIKit

class DataProvider: NSObject {  //этот класс загрузка большого изображения размером 100 мб
                                //загрузка может происходить в бэкграунде и происходит
                                //локакльное пуш оповещение при окончании загрузки
    
    var downloadTask: URLSessionDownloadTask!   //содаем задачу для загрузки
    var fileLocation: ((URL) -> ())?            //получаем локальную ссылку на файл после загрузки
    var onProgress: ((Double) -> ())?           //для прогресс вью, показыв процесс загрузки
    
    private lazy var bgSession: URLSession = {  //создаем сессию
        let config = URLSessionConfiguration.background(withIdentifier: "ru.swiftbook.Networking") //создаем конфигурацию для сессии
        config.isDiscretionary = true           //сообщаем что загрузка будет оптимальной, в зависимости от соединения интернета
        config.sessionSendsLaunchEvents = true  //после загрузки если приложуха в бэкграунде надо ли возобновить работу что бы показать пуш например
        config.timeoutIntervalForResource = 300 //сколько мы ждем подключения к инттернету если его нет
        return URLSession(configuration: config, delegate: self, delegateQueue: nil)
    }()
    
    func startDownload() {
        if let url = URL(string: "https://speed.hetzner.de/100MB.bin") {
            downloadTask = bgSession.downloadTask(with: url)
            downloadTask.earliestBeginDate = Date().addingTimeInterval(1) //говорим что загрузка начинается через секунду после начала
            downloadTask.countOfBytesClientExpectsToSend = 512 //максимальное кол во байтов которое клиент планирует отправить
            downloadTask.countOfBytesClientExpectsToReceive = 100 * 1024 * 1024 // примерное кол во байтов которое мы ожидаем получить
            downloadTask.resume()                                               //запуск
        }
    }
    
    func stopDownload() {                                       //если хотим остановить загрузку
        downloadTask.cancel()
    }
}

extension DataProvider: URLSessionDelegate {                   //делегат
    
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) { //метод делегата говорит что все в очередь поставленно
        DispatchQueue.main.async {                                                 //все делаем в основном потоке
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
                let completionHandler = appDelegate.bgSessionCompletionHandler
                else { return }
            
            appDelegate.bgSessionCompletionHandler = nil
            completionHandler()
        }
    }
}

// MARK: - URLSessionDownloadDelegate
extension DataProvider: URLSessionDownloadDelegate {
    
    func urlSession(_ session: URLSession,                          //метод делегата который говорит что загрузкак законченна
                    downloadTask: URLSessionDownloadTask,
                    didFinishDownloadingTo location: URL) {
        print("Did finish downloading: \(location.absoluteString)")
        DispatchQueue.main.async {
            self.fileLocation?(location)
        }
    }
    
    func urlSession(_ session: URLSession,                          //процесс загрузки файлов
                    downloadTask: URLSessionDownloadTask,
                    didWriteData bytesWritten: Int64,
                    totalBytesWritten: Int64,
                    totalBytesExpectedToWrite: Int64) {
        
        guard totalBytesExpectedToWrite != NSURLSessionTransferSizeUnknown else { return }//выходим если не нетт опред размера файлов
        
        let progress = Double(Double(totalBytesWritten)/Double(totalBytesExpectedToWrite))
        print("Download progress: \(progress)")
        DispatchQueue.main.async {
            self.onProgress?(progress)                              //обновляем нашу прогресс вью
        }
    }
}

extension DataProvider: URLSessionTaskDelegate {
    //если соединение востановилось
    func urlSession(_ session: URLSession, taskIsWaitingForConnectivity task: URLSessionTask) {
        //
    }
}
