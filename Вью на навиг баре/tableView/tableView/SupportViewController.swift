//
//  SupportViewController.swift
//  tableView
//
//  Created by Username on 18.06.2019.
//  Copyright © 2019 konstantinRAZRAB. All rights reserved.
//

import UIKit

class SupportViewController: UIViewController {

    var yOffset: CGFloat = 0

    private var isIPhoneXorXmax: Bool{
        return UIScreen.main.bounds.size.height >= 812
    }

    private var defaultFrameNBar: CGRect{
        return CGRect(x: 0,
                      y: self.isIPhoneXorXmax ? 44 : 20,
                      width: UIScreen.main.bounds.size.width,
                      height: 44)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }


    func animationNavigBar(scrollView: UIScrollView) {
        let koef: CGFloat = isIPhoneXorXmax ? 37 : 20
        var frame: CGRect = self.navigationController?.navigationBar.frame ?? defaultFrameNBar
        let size: CGFloat = frame.size.height - 61  //(вообще здесь должно стоять 21 но поскольку высота нашей кастомной вьюхи 40, добавляем еще 40)
        let framePercentageHidden: CGFloat = ((koef - frame.origin.y) / (frame.size.height - 1))
        let scrollOffset: CGFloat = scrollView.contentOffset.y
        let scrollDiff: CGFloat = scrollOffset - self.yOffset
        let scrollHeight: CGFloat = scrollView.frame.size.height
        let scrollContentSizeHeight: CGFloat = scrollView.contentSize.height + scrollView.contentInset.bottom

        if scrollOffset <= -scrollView.contentInset.top {
            frame.origin.y = koef
        } else if scrollOffset + scrollHeight >= scrollContentSizeHeight {
            frame.origin.y = -size
        } else {
            frame.origin.y = min(self.isIPhoneXorXmax ? 36 : 20, max(-size, frame.origin.y - scrollDiff))
        }
        self.updateBarButtonItems(alpha: 1 - framePercentageHidden)
        self.navigationController?.navigationBar.frame = frame
        self.yOffset = scrollOffset
    }

    func animateNavBarTo(y: CGFloat) {
        UIView.animate(withDuration: 0.2) {
            var frame: CGRect = self.navigationController?.navigationBar.frame ?? self.defaultFrameNBar
            frame.origin.y = y
            let alpha: CGFloat = frame.origin.y >= y ? 0 : 1
            self.navigationController?.navigationBar.frame = frame

            self.updateBarButtonItems(alpha: alpha)
        }
    }

    func stoppedScrolling() {
        let frame: CGRect = self.navigationController?.navigationBar.frame ?? defaultFrameNBar

        if frame.origin.y < 20 {
            self.animateNavBarTo(y: -(frame.size.height - 21))
        }
    }

    func updateBarButtonItems(alpha: CGFloat) {
        let color = UIColor(red: 0, green: 0, blue: 0, alpha: alpha) //поменяйте цвет на нужный
        self.atributesColorNavigBar(color: color)
    }

    func atributesColorNavigBar(color: UIColor) {  //эта функция делает прозрачным в зависимости от положения


        self.navigationController?.navigationBar.tintColor = color

        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: color]
    }

}

