//
//  URL.swift
//  GinzaGO
//
//  Created by Username on 19.08.2019.
//  Copyright © 2019 ITMegastar. All rights reserved.
//

import Foundation

extension URL {
    //получаем ключ из урла

    var getKey: String {
        if let str = self.absoluteString.components(separatedBy: "/").last?.components(separatedBy: ".").first {
            return str
        }

        return "key"
    }

    // методы ниже нужны для получения/извлечения/проверки есть ли такое изображение в директории
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
