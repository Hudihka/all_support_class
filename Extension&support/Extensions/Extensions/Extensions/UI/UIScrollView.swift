//
//  UIScrollView.swift
//  GinzaGO
//
//  Created by Username on 20.08.2019.
//  Copyright © 2019 Hudihka. All rights reserved.
//

import Foundation
import UIKit

extension UIScrollView {
    func paralax(constraitArray: [NSLayoutConstraint]) { //паралакс эффект
        let delta: CGFloat = self.contentOffset.y
        if delta < 0 {
            for obj in constraitArray {
                obj.constant = delta
            }
        }
    }


    func bottomScrollView() {
        if #available(iOS 11.0, *) {
            self.contentInsetAdjustmentBehavior = .never
        } else {
            UIApplication.shared.workVC.automaticallyAdjustsScrollViewInsets = false
        }
    }

    func addShadow(view: UIView) { //тень в зависимости от оффсета
        let delta: CGFloat = self.contentOffset.y
        if delta >= 7, delta < 28 {
            let opasity = delta / 30
            addShadowDown(view: view, opasity: Float(opasity))
        } else if delta < 7 {
            addShadowDown(view: view, opasity: 0)
        } else if delta >= 28 {
            addShadowDown(view: view, opasity: 0.7)
        }
    }

    private func addShadowDown(view: UIView, opasity: Float){
        view.layer.shadowOffset = CGSize(width: 0, height: 7)
        view.layer.shadowRadius = 7
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = opasity
    }
    
    
    var downOffset: Bool{
        //срабатывает когда оттянули на 35 пунктов
        //для бесконечного скролинга
        
        let delta = self.contentSize.height - self.frame.size.height
        
        if delta < 0 {
            return false
        }
        
        return self.contentOffset.y - 35 >= delta
    }

}
