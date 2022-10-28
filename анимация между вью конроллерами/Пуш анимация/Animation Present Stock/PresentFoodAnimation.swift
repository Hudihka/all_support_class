//
//  PresentFoodAnimation.swift
//  GinzaGO
//
//  Created by Username on 26.09.2019.
//  Copyright © 2019 ITMegastar. All rights reserved.
//

import Foundation

class PresentFoodAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    private let originFrame: CGRect
    private let image: UIImage
    private let menu: MenuStruct

    private var imageProcent: UIImageView?

    init(tupl: TuplPresentFoodAnimation) {
        self.originFrame = tupl.0
        self.image = tupl.1
        self.menu = tupl.2
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationTimeIntervalFood
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toVC = transitionContext.viewController(forKey: .to) as? FoodViewController,      // вью контроллер с меню
            let fromVC = transitionContext.viewController(forKey: .from),
            let snapshot = fromVC.view.snapshotView(afterScreenUpdates: false), // снимок экрана
            let heder = toVC.hederTable.hederView
            else {
                return
        }

        let containerView = transitionContext.containerView

        let cardFoodImage = UIImageView(frame: self.originFrame)
        cardFoodImage.image = self.image
        cardFoodImage.contentMode = .scaleAspectFill
        cardFoodImage.layer.masksToBounds = true
        self.addCustomCirkle(cardFoodImage)

        //        self.addSalleImage(cardFoodImage, menu: self.menu)

        //создаем процент изображение
        //но не через функцию, тк надо будет его прятать

        if menu.thereIsShare() {
            self.imageProcent = UIImageView(frame: CGRect(x: 2, y: 5, width: 40, height: 41))
            imageProcent?.image = UIImage(named: "logoProcentSalle")
            imageProcent?.alpha = 1

            if menu.isZeroCount() {
                imageProcent?.blackAndWhiteImage()
            }

            cardFoodImage.addSubview(self.imageProcent ?? UIImageView())
        }

        toVC.hederTable.alpha = 0
        toVC.view.alpha = 0

        containerView.addSubview(snapshot)
        containerView.addSubview(toVC.view)
        containerView.addSubview(cardFoodImage)

        let oneTime = animationTimeIntervalFood * 3 / 5
        let twoTime = animationTimeIntervalFood * 2 / 5

        //делается через 2 анимации одна в другой а не через UIView.animateKeyframes
        //тк происходит противный скачек в результате каоторого фреймы не совпадают

        UIView.animate(withDuration: oneTime,
                       animations: {
                        cardFoodImage.addRadius(number: 0)//радиус закругления

                        cardFoodImage.frame = SupportClass.finalFrameHederTV
                        toVC.view.alpha = 1
                        toVC.hederTable.alpha = 0

                        self.imageProcent?.alpha = 0
        }) { (done) in
            if done {
                //////вторая анимация
                UIView.animate(withDuration: twoTime,
                               animations: {
                                cardFoodImage.alpha = 0
                                toVC.hederTable.alpha = 1
                }, completion: { (compl) in
                    if compl == true {
                        heder.startText()
                        heder.addShadow()

                        heder.labelTitle.textColor = UIColor.white
                        heder.labelDescription.textColor = UIColor.white

                        snapshot.removeFromSuperview()
                        cardFoodImage.removeFromSuperview()

                        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                    }
                })
                /////////
            }
        }
    }
}

extension UIViewControllerAnimatedTransitioning {
    func addSalleImage(_ cardFoodImage: UIImageView, menu: MenuStruct) {
        if menu.thereIsShare() {
            let imageProcent = UIImageView(frame: CGRect(x: 2, y: 5, width: 40, height: 41))
            imageProcent.image = UIImage(named: "logoProcentSalle")
            if menu.isZeroCount() {
                imageProcent.blackAndWhiteImage()
            }
            cardFoodImage.addSubview(imageProcent)
        }
    }

    func addCustomCirkle(_ view: UIView) {
        if #available(iOS 11.0, *) {
            view.layer.cornerRadius = 8
            view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        } else {
            view.addRadius(number: 8)
        }
    }
}
