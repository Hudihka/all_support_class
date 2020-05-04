//
//  OTApiDowload.swift
//  TC5 ЕР
//
//  Created by Username on 21.01.2020.
//  Copyright © 2020 Hudihka. All rights reserved.
//

import Foundation
import Alamofire

class OTApiDowload {

    static let shared = OTApiDowload()

    let fileManager = SaveImageDirectory.shared
                                                                       //все хорошо
                                                                              //прогресс
    func startDownload(_ url: URL, key: String, completion: @escaping (Bool?, Double?) -> Void) {

        Alamofire.request(url,
                          headers: OTHeader.headerTocken).downloadProgress { (progress) in
                            print(progress.fractionCompleted)
                            completion(nil, progress.fractionCompleted)
            }.responseData { [weak self] (data) in
                print(data)

                let reloadTocken = (data.response?.statusCode ?? 0) == 401

                if reloadTocken {
                    self?.refreshTocken(url, key: key, completion: { (bValue, dValue) in
                        completion(bValue, dValue)
                    })
                }

                if !reloadTocken, let data = data.result.value {
                    let value = self?.saveData(data: data, key: key)
                    completion(value, nil)
                    return
                }
                //говорим что ошибка скачивания
        }
    }


    private func saveData(data: Data, key: String) -> Bool {

        let documentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as NSString
        let destinationPath = documentDirectoryPath.appendingPathComponent(key)

        let fileURL = URL(fileURLWithPath: destinationPath)
        FileManager.default.createFile(atPath: fileURL.path,
                                       contents: data,
                                       attributes: nil)

        if FileManager.default.fileExists(atPath: fileURL.path) {
            return true
        }

        return false
    }


    private func refreshTocken(_ url: URL, key: String, completion: @escaping (Bool?, Double?) -> Void) {
        RefreshTocken.refresh { (value) in
            if value {
                self.startDownload(url, key: key, completion: { (bValue, dValue) in
                    completion(bValue, dValue)
                })
            }
        }
    }


}

