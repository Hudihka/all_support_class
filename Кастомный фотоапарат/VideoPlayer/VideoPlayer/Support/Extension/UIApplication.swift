//
//  UIApplication.swift
//  VideoPlayer
//
//  Created by Админ on 19.08.2020.
//  Copyright © 2020 Админ. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
    
    var workVC: UIViewController {
        return self.keyWindow?.visibleViewController ?? UIViewController()
    }
    
    func deleteStatusBarView(){
        let tag = 38482458385
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        
        if let statusBar = keyWindow?.viewWithTag(tag) {
            statusBar.removeFromSuperview()
        }
        
    }

    var statusBarView: UIView? {
        
        if #available(iOS 13.0, *) {
            let tag = 38482458385
            let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            
            if let statusBar = keyWindow?.viewWithTag(tag) {
                return statusBar
            } else {
                guard let statusBarFrame = keyWindow?.windowScene?.statusBarManager?.statusBarFrame else { return nil }
                let statusBarView = UIView(frame: statusBarFrame)
                statusBarView.tag = tag
                keyWindow?.addSubview(statusBarView)
                return statusBarView
            }
            
        } else {
            return value(forKey: "statusBar") as? UIView
        }
        
    }
}
