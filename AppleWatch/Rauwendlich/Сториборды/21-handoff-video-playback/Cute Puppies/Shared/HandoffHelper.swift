//
//  HandoffHelper.swift
//  Cute Puppies Watch Extension
//
//  Created by Константин Ирошников on 04.09.2022.
//  Copyright © 2022 Soheil Azarpour. All rights reserved.
//

import Foundation

struct Handoff {
  // 2
  enum Activity: String {
    case viewHome = "com.razeware.cutepuppies.home"
    case playClip = "com.razeware.cutepuppies.clip"
    var stringValue: String {
      return self.rawValue
    }
}
// 3
  static let activityValueKey = "activityValue"
}
