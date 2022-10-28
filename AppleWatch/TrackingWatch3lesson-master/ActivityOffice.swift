//
//  ActivityOffice.swift
//  TrackingWatch
//
//  Created by Алексей Пархоменко on 24.03.2020.
//  Copyright © 2020 Алексей Пархоменко. All rights reserved.
//

import Foundation

class ActivityOffice {
    
    private enum SettingKey: String {
        case steps
        case distance
    }
    
    static var steps: Int! {
        get {
            return UserDefaults.standard.integer(forKey: SettingKey.steps.rawValue)
        }
        set {
            let defaults = UserDefaults.standard
            let key = SettingKey.steps.rawValue
            
            if let steps = newValue {
                print("value: \(steps) was added to key \(key)")
                defaults.set(steps, forKey: key)
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
    
    static var distance: Double! {
        get {
            return UserDefaults.standard.double(forKey: SettingKey.distance.rawValue)
        }
        set {
            let defaults = UserDefaults.standard
            let key = SettingKey.distance.rawValue
            
            if let distance = newValue {
                print("value: \(distance) was added to key \(key)")
                defaults.set(distance, forKey: key)
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
}
