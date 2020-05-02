//
//  UIApplication.swift
//  Extensions
//
//  Created by Hudihka on 29/03/2020.
//  Copyright © 2020 itMegastar. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
    var workVC: UIViewController {
        return self.keyWindow?.visibleViewController ?? UIViewController()
    }

	var statusBarView: UIView? {
		
		if #available(iOS 13.0, *) {
			let tag = 38482
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
	
	//видно ли клавиатуру
	var isKeyboardPresented: Bool {
        if let keyboardWindowClass = NSClassFromString("UIRemoteKeyboardWindow"),
            self.windows.contains(where: { $0.isKind(of: keyboardWindowClass) }) {
            return true
        } else {
            return false
        }
    }
}
