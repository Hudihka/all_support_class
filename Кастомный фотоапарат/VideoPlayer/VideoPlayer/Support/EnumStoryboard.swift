//
//  EnumStoryboard.swift
//  VideoPlayer
//
//  Created by Админ on 19.08.2020.
//  Copyright © 2020 Админ. All rights reserved.
//

import Foundation
import UIKit

enum EnumStoryboard: String {
    case main    = "Main"
    
    var storyboard: UIStoryboard{
        return UIStoryboard(name: self.rawValue, bundle: nil)
    }
    
    func vc(_ identifier: String) -> UIViewController{
        return self.storyboard.instantiateViewController(withIdentifier: identifier)
    }
    
}
