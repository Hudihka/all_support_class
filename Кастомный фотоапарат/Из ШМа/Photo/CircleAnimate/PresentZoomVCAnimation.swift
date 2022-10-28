//
//  PresentZoomVCAnimation.swift
//  ChefMarket_2.0
//
//  Created by Админ on 11.08.2020.
//  Copyright © 2020 itMegaStar. All rights reserved.
//

import Foundation
import UIKit


class PresentZoomVCAnimation: NSObject, UIViewControllerAnimatedTransitioning {

    private let startPoint: CGPoint = CGPoint(x: wDevice / 2 , y: hDevice / 2)

    override init() {}

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        guard let toVCN = transitionContext.viewController(forKey: .to) as? ZoomViewController,
              let snapshot = toVCN.view.snapshotView(afterScreenUpdates: true),
            //////
              let fromVC = transitionContext.viewController(forKey: .from),
              let snaphotFromVC = fromVC.view.snapshotView(afterScreenUpdates: true)

            else {
                return
        }


        let containerView = transitionContext.containerView
        containerView.backgroundColor = UIColor.clear

        let maskView = MaskCircleView(frame: snapshot.frame)
        snapshot.addSubview(maskView)

        containerView.addSubview(toVCN.view)     //в начале в контейнер добавляем конечный
        containerView.addSubview(snaphotFromVC)
        containerView.addSubview(snapshot)


        maskView.startPoint = startPoint
        maskView.​configure()

//        maskView.completionBlock = {
//            snaphotFromVC.removeFromSuperview()
//            snapshot.removeFromSuperview()
//            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
//        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        snaphotFromVC.removeFromSuperview()
                        snapshot.removeFromSuperview()
                        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }

    }
}
