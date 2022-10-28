//
//  SaveImageDirectory.swift
//  NUKEandDirectory
//
//  Created by Hudihka on 06/01/2020.
//  Copyright © 2020 Username. All rights reserved.
//

import Foundation
import UIKit

class SaveImageDirectory{
    
    static var shared = SaveImageDirectory()
    
    //удаление файлов записанных 3 дня назад

    func removeFrieDayObject(countSeconds: Int) {
        var arrayKeys: [String] = []

        guard let dirPath = self.getPaths() else {
            return
        }

        do {
            arrayKeys = try FileManager.default.contentsOfDirectory(atPath: dirPath)
        } catch let removeError {
            print(removeError)
            return
        }

        for key in arrayKeys {
            if let fileURL = self.getFileUrl(name: key) {
                if let date = URL(fileURLWithPath: dirPath).appendingPathComponent(key).creationDate {
                    if date.secondsHavePassed(countSeconds) && !key.contains("CoreData") { //проверка нужна для того что бы не удалить кор дату
                        do {
                            try FileManager.default.removeItem(atPath: fileURL.path)
                            print("удалили старый файл \(key)")
                        } catch let removeError {
                            print("ошибка удаления", removeError)
                        }
                    }
                }
            }
        }
    }
    
    func saveImage(image: UIImage, key: String) {
        
        guard let fileURL = self.getFileUrl(name: key) else {
            return
        }
        
        guard let data = image.pngData() else {
            return
        }
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
                print("Removed old image")
            } catch let removeError {
                print("couldn't remove file at path", removeError)
            }
        }
        do {
            try data.write(to: fileURL)
        } catch let error {
            print("error saving file with error", error)
        }
    }
    
    //получени ссылки на изображение в директории
    
    private func getFileUrl(name: String) -> URL? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory,
                                                                in: .userDomainMask).first else {
                                                                    return nil
        }
        
        return documentsDirectory.appendingPathComponent(name)
    }
    
    //получение самого изображения
    
    func loadImageFromDiskWith(name: String) -> UIImage? {
        if let dirPath = self.getPaths() {
            let imageUrl = URL(fileURLWithPath: dirPath).appendingPathComponent(name)
            let image = UIImage(contentsOfFile: imageUrl.path)
            return image
        }
        
        return nil
    }
    
    private func getPaths() -> String? {
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        return NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true).first
    }
    
}
