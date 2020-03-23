//
//  MainViewController.swift
//  open text
//
//  Created by Hudihka on 03/12/2019.
//  Copyright © 2019 konstantinRAZRAB. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    var isTwoVC = false

    override func viewDidLoad() {
        super.viewDidLoad()

//        self.view.backgroundColor = SupportClass.Colors.bacgroundVCColor

        if isTwoVC {
            //что делатть во втором

            /* добавь в класс еслии хочешь что бы это был 2рой
             required init?(coder aDecoder: NSCoder) {
             super.init(coder: aDecoder)
             self.isTwoVC = true
             }

             */
        }

        self.customNavigationBar()
//        self.settingsNavigBar()//настройка навиг ББИтем
    }

    func customNavigationBar() {
        self.clearNavigationBar()

//        let color = isTwoVC ? SupportClass.Colors.barButtonItemAlpha06 : SupportClass.Colors.whiteButtonNavigationBar
//        self.navigationController?.navigationBar.tintColor = color
//        navigationController?.navigationBar.titleTextAttributes =
//            [NSAttributedString.Key.foregroundColor: SupportClass.Colors.whiteButtonNavigationBar]
    }

}

