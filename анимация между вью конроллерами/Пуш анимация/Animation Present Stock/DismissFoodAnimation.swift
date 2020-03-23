//
//  DismissFoodAnimation.swift
//  GinzaGO
//
//  Created by Username on 27.09.2019.
//  Copyright © 2019 ITMegastar. All rights reserved.
//

import Foundation

class DismissFoodAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    private let finalFrame: CGRect
    private let image: UIImage
    private let menu: MenuStruct

    private var imageProcent: UIImageView?

    init(frame: CGRect, image: UIImage, menu: MenuStruct) {
        self.finalFrame = frame
        self.image = image
        self.menu = menu
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationTimeIntervalFood
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let foodVC = transitionContext.viewController(forKey: .from) as? FoodViewController,
            let toVC = transitionContext.viewController(forKey: .to),
            let heder = foodVC.hederTable.hederView else {
                return
        }

        let containerView = transitionContext.containerView
        containerView.backgroundColor = UIColor.clear

        let imageCell = UIImageView(frame: SupportClass.finalFrameHederTV) //в начале создаем изображение которое будет
        imageCell.image = self.image
        imageCell.contentMode = .scaleAspectFill
        imageCell.layer.masksToBounds = true
        self.addSalleImage(imageCell, menu: self.menu)
        imageCell.alpha = 0

        let cardFood = GradientImageView(frame: SupportClass.finalFrameHederTV) //на него накладываем изображение что сейчас
        cardFood.image = foodVC.hederTable.getActiveImageForAnimation ?? self.image
        cardFood.contentMode = .scaleAspectFill
        cardFood.layer.masksToBounds = true

        foodVC.hederTable.alpha = 0
        //        heder.alpha = 0
        heder.addClerText()

        containerView.addSubview(foodVC.view)
        containerView.addSubview(imageCell)
        containerView.addSubview(cardFood)

        transitionContext.containerView.insertSubview(toVC.view, belowSubview: foodVC.view)

        UIView.animate(withDuration: animationTimeInterval,
                       animations: {
                        //кастоимные радиусы
                        self.addCustomCirkle(imageCell)
                        self.addCustomCirkle(cardFood)

                        cardFood.frame = self.finalFrame
                        imageCell.frame = self.finalFrame

                        cardFood.alpha = 0
                        self.imageProcent?.alpha = 1
                        imageCell.alpha = 1

                        foodVC.view.alpha = 0
        }) { (compl) in
            if compl == true {
                foodVC.view.removeFromSuperview()
                imageCell.removeFromSuperview()
                cardFood.removeFromSuperview()

                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        }
    }
}
