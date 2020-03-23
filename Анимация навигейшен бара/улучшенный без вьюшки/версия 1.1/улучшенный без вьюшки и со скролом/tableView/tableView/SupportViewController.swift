//
//  SupportViewController.swift
//  tableView
//
//  Created by Hudihka on 17/08/2019.
//  Copyright © 2019 konstantinRAZRAB. All rights reserved.
//

import UIKit

class SupportViewController: UIViewController {
    private var yOffset: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.goNextVC()
    }

}

extension SupportViewController {//методы применяемые для анимации навиг бара
    func animationNavigBar(scrollView: UIScrollView) {
        if !scrollView.navigBarScrollEnnable {
            return
        }

        let koef: CGFloat = SupportClass.isIPhoneXorXmax() ? 37 : 20
        var frame: CGRect = self.navigationController?.navigationBar.frame ?? SupportClass.defaultFrameNBar
        let size: CGFloat = frame.size.height - 21
        let framePercentageHidden: CGFloat = ((koef - frame.origin.y) / (frame.size.height - 1))
        let scrollOffset: CGFloat = scrollView.contentOffset.y
        let scrollDiff: CGFloat = scrollOffset - self.yOffset

        //если таблица идет до самого верха то поменяй -SupportClass.indentNavigationBarHeight
        //на -scrollView.contentInset.top

        print(scrollView.frame.origin.y)

        let SVO = scrollView.isZeroPosition ? scrollView.contentInset.top : SupportClass.indentNavigationBarHeight

        if scrollOffset <= -1 * SVO {
            frame.origin.y = koef
        } else {
            frame.origin.y = min(SupportClass.isIPhoneXorXmax() ? 36 : 20, max(-size, frame.origin.y - scrollDiff))
        }
        
        self.updateBarButtonItems(alpha: 1 - framePercentageHidden)
        self.navigationController?.navigationBar.frame = frame
        self.yOffset = scrollOffset
    }

    private func animateNavBarTo(y: CGFloat, scrollView: UIScrollView) {
        var alpha: CGFloat = 0

        if y == 44 || y == 20{
            alpha = 1
        }

//        scrollView.setContentOffset(CGPoint(x: 0, y: -20), animated: true)

        UIView.animate(withDuration: 0.3) {
            var frame: CGRect = self.navigationController?.navigationBar.frame ?? SupportClass.defaultFrameNBar
            frame.origin.y = y
            self.navigationController?.navigationBar.frame = frame

            self.updateBarButtonItems(alpha: alpha)
        }
    }


    func stoppedScrolling(scrollView: UIScrollView) {
        let frame: CGRect = self.navigationController?.navigationBar.frame ?? SupportClass.defaultFrameNBar

        let endPoinntZero: CGFloat = SupportClass.isIPhoneXorXmax() ? 0 : -24
        let endPoinntAll: CGFloat = SupportClass.isIPhoneXorXmax() ? 44 : 20
        let height: CGFloat = SupportClass.isIPhoneXorXmax() ? 20 : 0


        let zero: Bool = frame.origin.y < height
        self.animateNavBarTo(y: zero ? endPoinntZero : endPoinntAll, scrollView: scrollView)

    }

    private func updateBarButtonItems(alpha: CGFloat) {
        let color = UIColor(red: 0, green: 0, blue: 0, alpha: alpha)//поставить нужный цвет
        self.atributesColorNavigBar(color: color)
    }

    private func atributesColorNavigBar(color: UIColor) {
        self.navigationController?.navigationBar.tintColor = color

        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: color]
    }

    private func backColorBBItems(rectVC: CGRect) {
        self.navigationController?.navigationBar.frame = rectVC
        let alpha: CGFloat = rectVC.origin.y < 0 ? 0 : 1

        updateBarButtonItems(alpha: alpha)

    }

    func goNextVC() {
        //        rectVC = self.navigationController?.navigationBar.frame ?? SupportClass.defaultFrameNBar
        self.navigationController?.navigationBar.frame = SupportClass.defaultFrameNBar
    }

    private func getFrameNBar() -> CGRect {
        if SupportClass.isIPhoneXorXmax() {
            return SupportClass.defaultFrameNBar
        } else {
            return self.navigationController?.navigationBar.frame ?? SupportClass.defaultFrameNBar
        }
    }
}

extension UIScrollView{
    var navigBarScrollEnnable: Bool{
        return self.contentSize.height > SupportClass.Dimensions.hDdevice
    }

    var isZeroPosition: Bool {
        if #available(iOS 11.0, *) {
            return self.contentInsetAdjustmentBehavior == .never
        } else {
            let VC = UIApplication.shared.getWorkVC()
            return !VC.automaticallyAdjustsScrollViewInsets
        }
    }
}




class SupportClass: NSObject {
    enum Dimensions {
        static let hDdevice = UIScreen.main.bounds.size.height
        static let wDdevice = UIScreen.main.bounds.size.width
    }

    static func isIPhone5() -> Bool {
        return SupportClass.Dimensions.hDdevice == 568
    }

    static func isIPhoneXorXmax() -> Bool {
        return SupportClass.Dimensions.hDdevice >= 812
    }

    static let indentNavigationBarHeight: CGFloat = SupportClass.statusBarHeight + SupportClass.navigBarHeight
    static let statusBarHeight: CGFloat = SupportClass.isIPhoneXorXmax() ? 44 : 20
    static let navigBarHeight: CGFloat = 44

    static let defaultFrameNBar: CGRect = CGRect(x: 0,
                                                 y: SupportClass.statusBarHeight,
                                                 width: SupportClass.Dimensions.wDdevice,
                                                 height: SupportClass.navigBarHeight)


}
