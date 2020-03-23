//
//  CircularLoaderView.swift
//  ImageLoaderIndicator
//
//  Created by Hudihka on 16/11/2019.
//  Copyright © 2019 Rounak Jain. All rights reserved.
//

import UIKit

class CircularLoaderView: UIView {

    let ​​circlePathLayer = CAShapeLayer() //круговой путь
    let circleRadius: CGFloat = 20.0


    var progress: CGFloat { //ну собствено процес загрузки если 1 то кольцо замкнуто
        get {
            return ​​circlePathLayer.strokeEnd
        }
        set {
            if newValue > 1 {
                ​​circlePathLayer.strokeEnd = 1
            } else if newValue < 0 {
                ​​circlePathLayer.strokeEnd = 0
            } else {
                ​​circlePathLayer.strokeEnd = newValue
            }
        }
    }



    override init(frame: CGRect) {
        super.init(frame: frame)
        ​configure()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        ​configure()
    }

    /*Поскольку слои не имеют autoresizingMask свойства, вы переопределите, layoutSubviewsчтобы соответствующим образом реагировать на изменения размера представления.*/

    override func layoutSubviews() {
        super.layoutSubviews()
        ​​circlePathLayer.frame = bounds
        //изменение в кадре также должно вызвать пересчет пути.
        ​​circlePathLayer.path = circlePath().cgPath
    }


    func ​configure() {

        progress = 0

        ​​circlePathLayer.frame = bounds
        ​​circlePathLayer.lineWidth = 2
        ​​circlePathLayer.fillColor = UIColor.clear.cgColor
        ​​circlePathLayer.strokeColor = UIColor.red.cgColor
        self.layer.addSublayer(​​circlePathLayer) //добавляем на наш слой круглую вью
        self.backgroundColor = UIColor.white

    }

    func circleFrame() -> CGRect {
        var circleFrame = CGRect(x: 0, y: 0, width: 2 * circleRadius, height: 2 * circleRadius)
        let circlePathBounds = ​​circlePathLayer.bounds
        circleFrame.origin.x = circlePathBounds.midX - circleFrame.midX
        circleFrame.origin.y = circlePathBounds.midY - circleFrame.midY
        return circleFrame
    }

    func circlePath() -> UIBezierPath {  //возвращаем овал в нутри нашего круга
        return UIBezierPath(ovalIn: circleFrame())
    }



    //самое иинттересное, расширяющ круг

    func reveal() {
        // 1 //этти свойства нам не особо нужны, просто для кольца загрузки
        backgroundColor = .clear
        progress = 1

        // удаляю все анимации связанные с закрыттиием кольца
        ​​circlePathLayer.removeAnimation(forKey: "strokeEnd")
        // 3
        //удаляю круг с супервью

        ​​circlePathLayer.removeFromSuperlayer()

        //чтобы изображение было видно через круглую маску «дыру»
        superview?.layer.mask = ​​circlePathLayer


        //расширение кольца во внуттрь и наружу

        // 1
        let center = CGPoint(x: bounds.midX, y: bounds.midY) //центр изображения
        let finalRadius = sqrt((center.x * center.x) + (center.y * center.y)) //фиинальный радиус круга
        let radiusInset = finalRadius - circleRadius  //финальный внешний радиус
        //Возвращает прямоугольник, который меньше или
        //больше исходного прямоугольника с той же центральной точкой.
        let outerRect = circleFrame().insetBy(dx: -radiusInset, dy: -radiusInset)
        let toPath = UIBezierPath(ovalIn: outerRect).cgPath //вписываем кривую безе во внутрь квадрата

         //берем значения что сейчас есть
        let fromPath = ​​circlePathLayer.path
        let fromLineWidth = ​​circlePathLayer.lineWidth

        /*
         Вы устанавливаете lineWidthи path их окончательные значения.
         Это не позволяет им вернуться к исходным значениям после
         завершения анимации. По оборачивать это изменения в CATransactionс
         kCATransactionDisableActionsнабором для true вас отключить неявные анимации слоя.

         */
        CATransaction.begin()
        CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
        ​​circlePathLayer.lineWidth = 2 * finalRadius
        ​​circlePathLayer.path = toPath
        CATransaction.commit()

        /*
         Вы создаете два экземпляра CABasicAnimation: один для,
         pathа другой для lineWidth. lineWidthдолжен увеличиваться
         вдвое быстрее, чем увеличивается радиус, чтобы круг
         расширялся как внутрь, так и наружу.
         */
        let lineWidthAnimation = CABasicAnimation(keyPath: "lineWidth")
        lineWidthAnimation.fromValue = fromLineWidth
        lineWidthAnimation.toValue = 2*finalRadius

        let pathAnimation = CABasicAnimation(keyPath: "path")
        pathAnimation.fromValue = fromPath
        pathAnimation.toValue = toPath

        /*
         Вы добавляете обе анимации в a CAAnimationGroupи добавляете группу анимации к слою
         */
        let groupAnimation = CAAnimationGroup()
        groupAnimation.duration = 1
        groupAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        groupAnimation.animations = [pathAnimation, lineWidthAnimation]
        groupAnimation.delegate = self
        ​​circlePathLayer.add(groupAnimation, forKey: "strokeWidth")


    }


}

extension CircularLoaderView: CAAnimationDelegate {

    //анимация завершилась
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        superview?.layer.mask = nil
    }
}


