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
        return value(forKey: "statusBar") as? UIView
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
