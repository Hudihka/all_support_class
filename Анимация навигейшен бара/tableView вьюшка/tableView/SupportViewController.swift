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
    private var flagsUpdateSCV: Bool = true
    private var flagsUpdateNVBar: Bool = true

    var animateView: UIView? = nil
    var scrollViewContent: UIScrollView? = nil

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

        if !flagsUpdateNVBar{
            return
        }
        self.updateSCV()

        let koef: CGFloat = SupportClass.isIPhoneXorXmax() ? 37 : 20
        var frame: CGRect = self.navigationController?.navigationBar.frame ?? SupportClass.defaultFrameNBar
        let size: CGFloat = frame.size.height - 21
        let framePercentageHidden: CGFloat = ((koef - frame.origin.y) / (frame.size.height - 1))
        let scrollOffset: CGFloat = scrollView.contentOffset.y
        let scrollDiff: CGFloat = scrollOffset - self.yOffset
        let scrollHeight: CGFloat = scrollView.frame.size.height
        let scrollContentSizeHeight: CGFloat = scrollView.contentSize.height + scrollView.contentInset.bottom
                            //если таблица идет до самого верха то поменяй -SupportClass.navigationBarHeight
                            //на -scrollView.contentInset.top

        if scrollOffset <= -scrollView.contentInset.top {

            frame.origin.y = koef
            positionView(positionYZeroNBar: frame.origin.y)
        } else if scrollOffset + scrollHeight >= scrollContentSizeHeight {

            frame.origin.y = -size
            positionView(positionYZeroNBar: frame.origin.y)
        } else {
            
            frame.origin.y = min(SupportClass.isIPhoneXorXmax() ? 36 : 20, max(-size, frame.origin.y - scrollDiff))
            positionView(positionYZeroNBar: frame.origin.y)
        }
        self.updateBarButtonItems(alpha: 1 - framePercentageHidden)
        self.navigationController?.navigationBar.frame = frame
        self.yOffset = scrollOffset
    }

    private func updateSCV(){
        if flagsUpdateSCV, let view = scrollViewContent, let heightView = animateView?.frame.height {
            let newHeight = view.frame.height + heightView
            view.frame = CGRect(x: view.frame.origin.x,
                                y: view.frame.origin.y,
                                width: view.frame.width,
                                height: newHeight)

        }

        flagsUpdateSCV = false
    }

    private func positionView(positionYZeroNBar: CGFloat){
        if let view = self.animateView {
            view.frame.origin.y = positionYZeroNBar + SupportClass.navigBarHeight

            if let SVC = self.scrollViewContent {
                SVC.frame.origin.y = view.frame.origin.y + view.frame.height
            }
        }
    }


    private func positionViewTableViewDown(){
        if let view = self.animateView, let SVC = self.scrollViewContent {
            view.frame.origin.y = 61
            SVC.frame.origin.y = 101
        }
    }


    private func animateNavBarTo(y: CGFloat) {
        UIView.animate(withDuration: 0.2) {
            var frame: CGRect = self.navigationController?.navigationBar.frame ?? SupportClass.defaultFrameNBar
            frame.origin.y = y
            let alpha: CGFloat = frame.origin.y >= y ? 0 : 1
            self.navigationController?.navigationBar.frame = frame

            self.updateBarButtonItems(alpha: alpha)
        }
    }

    private func animateContentView() {
        UIView.animate(withDuration: 0.2) {
            self.positionView(positionYZeroNBar: -21)
        }
    }


    func stoppedScrolling() {
        let frame: CGRect = self.navigationController?.navigationBar.frame ?? SupportClass.defaultFrameNBar

        if frame.origin.y < 20 {
            self.animateNavBarTo(y: -(frame.size.height - 21))
            self.animateContentView()
        }
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
        if rectVC.origin.y < 0 {
            updateBarButtonItems(alpha: 0)
        }
    }

    private func reviersFlag(){
        flagsUpdateNVBar = !flagsUpdateNVBar
    }

    private func goNextVC() {

        self.reviersFlag()
        self.navigationController?.navigationBar.frame = SupportClass.defaultFrameNBar
        self.positionView(positionYZeroNBar: SupportClass.statusBarHeight)
        self.reviersFlag()

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

