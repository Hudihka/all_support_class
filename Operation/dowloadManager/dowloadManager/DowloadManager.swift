//
//  Do.swift
//  dowloadManager
//
//  Created by Hudihka on 04/06/2021.
//  Copyright © 2021 OOO MegaStar. All rights reserved.
//

import Foundation
import UIKit


class DowloadManager{
    
    static var shared = DowloadManager()
    
    private var fileManager = FileManager.default
    
    //удаление файлов countSeconds назад

    func removeObject(countSeconds: Int) {
        guard let dirPath = self.getPaths else {
            return
        }
        
        let arrayKeys = arrayFiles.filter({ self.deleteObj(countSeconds: countSeconds, dirPath: dirPath, key: $0) })
        
        arrayKeys.forEach { (key) in
            removeObj(key: key)
        }
        
    }
    
    private func removeObj(key: String){
        if let fileURL = self.getFileUrl(name: key) {
            do {
                try fileManager.removeItem(atPath: fileURL.path)
                print("удалили старый файл \(key)")
            } catch let removeError {
                print("ошибка удаления", removeError)
            }
        }
    }
    
    
    func saveData(data: Data, key: String) -> Bool {

        let documentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as NSString
        let destinationPath = documentDirectoryPath.appendingPathComponent(key)

        let fileURL = URL(fileURLWithPath: destinationPath)
        fileManager.createFile(atPath: fileURL.path,
                                       contents: data,
                                       attributes: nil)

        if fileManager.fileExists(atPath: fileURL.path) {
            return true
        }

        return false
    }
	
	func copyObject(localUrl: URL, key: String){
		
		
	}
	
	//есть ли файл по ключу
    
    func urlFile(key: String) -> URL? {

        if arrayFiles.contains(key), let pats = getPaths {
            return URL(fileURLWithPath: pats).appendingPathComponent(key)
        }

        return nil
    }

    private var arrayFiles: [String] {

         var arrayKeys: [String] = []

        guard let dirPath = self.getPaths else {
            return arrayKeys
        }

        do {
            arrayKeys = try fileManager.contentsOfDirectory(atPath: dirPath)
        } catch let removeError {
            print(removeError)
        }

        return arrayKeys
    }
    
    //получени ссылки на файл в директории
    
    private func getFileUrl(name: String) -> URL? {
        guard let documentsDirectory = fileManager.urls(for: .documentDirectory,
                                                                in: .userDomainMask).first else {
                                                                    return nil
        }

        return documentsDirectory.appendingPathComponent(name)
    }
    
    private var getPaths: String? {
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory

        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        return NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true).first
    }
    
    private func deleteObj(countSeconds: Int, dirPath: String, key: String) -> Bool {
        
        if let date = URL(fileURLWithPath: dirPath).appendingPathComponent(key).creationDate,
           date.secondsHavePassed(countSeconds),
           !key.contains("CoreData") {
            
            return true
        }
           
        return false
    }
}


fileprivate extension URL{

    var attributes: [FileAttributeKey: Any]? {
        do {
            return try FileManager.default.attributesOfItem(atPath: path)
        } catch let error as NSError {
            print("FileAttribute error: \(error)")
        }
        return nil
    }

    var fileSize: UInt64 {
        return attributes?[.size] as? UInt64 ?? UInt64(0)
    }

    var fileSizeString: String {
        return ByteCountFormatter.string(fromByteCount: Int64(fileSize), countStyle: .file)
    }

    var creationDate: Date? {
        return attributes?[.creationDate] as? Date
    }
}
