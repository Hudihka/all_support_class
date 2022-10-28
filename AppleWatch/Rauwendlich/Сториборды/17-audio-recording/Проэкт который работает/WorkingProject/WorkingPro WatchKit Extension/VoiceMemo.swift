//
//  VoiceMemo.swift
//  WorkingPro WatchKit Extension
//
//  Created by Константин Ирошников on 30.08.2022.
//

import Foundation
import UIKit

@objc(VoiceMemo)
public class VoiceMemo: NSObject, NSCoding, NSCopying {

  public let date: Date
  public let filename: String
  public var url: URL

  public init(filename: String, date: Date) {
    self.filename = filename
    self.date = date

    let userDocuments = FileManager.default.userDocumentsDirectory
    self.url = userDocuments.appendingPathComponent(filename)

    super.init()
  }

  // MARK: NSCoding

  public required init?(coder aDecoder: NSCoder) {
    self.date = aDecoder.decodeObject(forKey: "date") as! Date
    self.filename = aDecoder.decodeObject(forKey: "filename") as! String
    let userDocuments = FileManager.default.userDocumentsDirectory
    self.url = userDocuments.appendingPathComponent(filename) as URL

    super.init()
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(self.date, forKey: "date")
    aCoder.encode(self.filename, forKey: "filename")
  }

  public func copy(with zone: NSZone? = nil) -> Any {
    let copy = VoiceMemo(filename: filename, date: date)
    return copy
  }

}

extension VoiceMemo {
    convenience init(
        date: Date,
        filename: String,
        url: URL
    ) {
        self.init(filename: filename, date: date)
        self.url = url
    }

    static var generateVoice: VoiceMemo? {
        let name = "90th"
        guard let assetURL: URL = Bundle.main.url(forResource: name, withExtension: "mp3") else {
            return nil
        }

        return VoiceMemo(date: Date(timeIntervalSinceNow: -10000), filename: name, url: assetURL)
    }
}
