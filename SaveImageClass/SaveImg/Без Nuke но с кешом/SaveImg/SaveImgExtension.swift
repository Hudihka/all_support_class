//
//  SaveImageExtension.swift
//  NUKEandDirectory
//
//  Created by Hudihka on 06/01/2020.
//  Copyright © 2020 Username. All rights reserved.
//

import Foundation


extension URL{
    var keyURL: NSString {
        let str = self.absoluteString
        return str.removeCharacters(from: "/:.") as NSString
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

extension String {

    func removeCharacters(from forbiddenChars: CharacterSet) -> String {
        let passed = self.unicodeScalars.filter { !forbiddenChars.contains($0) }
        return String(String.UnicodeScalarView(passed))
    }

    func removeCharacters(from: String) -> String {
        return removeCharacters(from: CharacterSet(charactersIn: from))
    }
}

extension Date {
    func secondsHavePassed(_ seconds: Int) -> Bool { //проверяем, прошло ли данное количество секунд
        let delta = -1 * seconds
        let frieDaysHave = Date(timeIntervalSinceNow: TimeInterval(delta))
        let deltaTime = Calendar.current.compare(frieDaysHave, to: self, toGranularity: .second)

        if deltaTime.rawValue == -1 {
            return false // не прошло 3е суток
        } else {
            return true
        }
    }
}
