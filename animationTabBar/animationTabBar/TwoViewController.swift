//
//  TwoViewController.swift
//  animationTabBar
//
//  Created by Hudihka on 05/10/2019.
//  Copyright © 2019 konstantinRAZRAB. All rights reserved.
//

import UIKit


class TwoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


    }

    @IBAction func sliderMannager(_ sender: UISlider) {
        self.view.alpha = 0.1//CGFloat(sender.value)

    }


    @IBAction func tabBarAction(_ sender: UIButton) {

        let frame = self.tabBarController!.tabBar.frame
//        let TB = MyTabBar.getTabBar()
//
//        switch sender.tag {
//        case 1:
//            TB.setTabBarVisible(visible: true, animated: true)
//        case 2:
//            TB.setTabBarVisible(visible: true, animated: false)
//        case 3:
//            TB.setTabBarVisible(visible: false, animated: true)
//        default:
//            TB.setTabBarVisible(visible: false, animated: false)
        }

    

    static func route() -> TwoViewController{
        let storubord = UIStoryboard.init(name: "Main", bundle: nil)

        let VC = storubord.instantiateViewController(withIdentifier: "TwoViewController") as! TwoViewController
        return VC
    }

}

