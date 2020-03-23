//
//  MainTabBar.swift
//  animationTabBar
//
//  Created by Hudihka on 05/10/2019.
//  Copyright © 2019 konstantinRAZRAB. All rights reserved.
//

import Foundation
import UIKit

class MyTabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.red
        setupTabBar()
    }


    static func getTabBar() -> MyTabBar{
        let storubord = UIStoryboard.init(name: "Main", bundle: nil)
        let TB = storubord.instantiateViewController(withIdentifier: "MyTabBar") as! MyTabBar
        return TB
    }

    func setupTabBar() {
        tabBar.barTintColor = .purple
        tabBar.isTranslucent = false

        let selectedColor   = UIColor(red: 246.0/255.0, green: 155.0/255.0, blue: 13.0/255.0, alpha: 1.0)
        let unselectedColor = UIColor(red: 16.0/255.0, green: 224.0/255.0, blue: 223.0/255.0, alpha: 1.0)

        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: unselectedColor], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: selectedColor], for: .selected)


        self.selectedIndex = 0
        viewControllers?.forEach({
            let id = $0.restorationIdentifier

            if let tabInfo = MainTab(rawValue: id ?? "") {
                $0.tabBarItem.title = tabInfo.title
                $0.tabBarItem.image = tabInfo.icons.normal.withRenderingMode(.alwaysOriginal)
                $0.tabBarItem.selectedImage = tabInfo.icons.selected.withRenderingMode(.alwaysOriginal)
            }
        })
    }
}

enum MainTab: String {
    case user
    case car

    var title: String {
        switch self {
        case .user:
            return "Владельцы"

        case .car:
            return "Авто"

        }
    }

    var icons: (normal: UIImage, selected: UIImage) {
        var cartage: (UIImage?, UIImage?) = (nil, nil)

        switch self {
        case .user:
            cartage = (UIImage(named: "fridge"), UIImage(named: "fridgePress"))

        case .car:
            cartage = (UIImage(named: "basket"), UIImage(named: "basketPress"))

        }

        return (cartage.0 ?? UIImage(), cartage.1 ?? UIImage())
    }
}

extension MyTabBar {

    private struct AssociatedKeys {
        // Declare a global var to produce a unique address as the assoc object handle
        static var orgFrameView:     UInt8 = 0
        static var movedFrameView:   UInt8 = 1
    }

    var orgFrameView:CGRect? {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.orgFrameView) as? CGRect }
        set { objc_setAssociatedObject(self, &AssociatedKeys.orgFrameView, newValue, .OBJC_ASSOCIATION_COPY) }
    }

    var movedFrameView:CGRect? {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.movedFrameView) as? CGRect }
        set { objc_setAssociatedObject(self, &AssociatedKeys.movedFrameView, newValue, .OBJC_ASSOCIATION_COPY) }
    }

    override open func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if let movedFrameView = movedFrameView {
            view.frame = movedFrameView
        }
    }

    func setTabBarVisible(visible:Bool, animated:Bool) {
        //since iOS11 we have to set the background colour to the bar color it seams the navbar seams to get smaller during animation; this visually hides the top empty space...
        view.backgroundColor =  self.tabBar.barTintColor
        // bail if the current state matches the desired state
        if (tabBarIsVisible() == visible) { return }

        //we should show it
        if visible {
            tabBar.isHidden = false
            UIView.animate(withDuration: animated ? 0.3 : 0.0) {
                //restore form or frames
                self.view.frame = self.orgFrameView!
                //errase the stored locations so that...
                self.orgFrameView = nil
                self.movedFrameView = nil
                //...the layoutIfNeeded() does not move them again!
                self.view.layoutIfNeeded()
            }
        }
            //we should hide it
        else {
            //safe org positions
            orgFrameView   = view.frame
            // get a frame calculation ready
            let offsetY = self.tabBar.frame.size.height
            movedFrameView = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height + offsetY)
            //animate
            UIView.animate(withDuration: animated ? 0.3 : 0.0, animations: {
                self.view.frame = self.movedFrameView!
                self.view.layoutIfNeeded()
            }) {
                (_) in
                self.tabBar.isHidden = true
            }
        }
    }

    func tabBarIsVisible() ->Bool {
        return orgFrameView == nil
    }
}
