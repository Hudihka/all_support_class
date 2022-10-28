//
//  DismissZoomVCAnimation.swift
//  ChefMarket_2.0
//
//  Created by Админ on 11.08.2020.
//  Copyright © 2020 itMegaStar. All rights reserved.
//

import Foundation
import UIKit

class DismissZoomVCAnimation: NSObject, UIViewControllerAnimatedTransitioning {

    private let finalPoint: CGPoint

    init(finalPoint: CGPoint) {
        self.finalPoint = finalPoint
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        guard let twoButtonVC = transitionContext.viewController(forKey: .to),
            let cameraVC = transitionContext.viewController(forKey: .from),
            let snaphotCamera = cameraVC.view.snapshotView(afterScreenUpdates: true)

            else {
                return
        }


        let containerView = transitionContext.containerView
        containerView.backgroundColor = UIColor.clear

        let maskView = MaskCircleView(frame: snaphotCamera.frame)
        snaphotCamera.addSubview(maskView)

        containerView.addSubview(twoButtonVC.view)
        containerView.addSubview(snaphotCamera)


        maskView.finishPoint = finalPoint
        maskView.​configure()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            snaphotCamera.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }

    }
}
