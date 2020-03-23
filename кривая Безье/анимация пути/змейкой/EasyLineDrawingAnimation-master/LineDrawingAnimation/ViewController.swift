//
//  ViewController.swift
//  BezierPathLineDrawingAnimation
//
//  Created by Nutchaphon Rewik on 30/12/2015.
//  Copyright © 2015 Nutchaphon Rewik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let shapeLayer = CAShapeLayer()

    @IBOutlet weak var viewTest: UIView!
    @IBOutlet weak var pathView: UIView!


    override func viewDidLoad() {
        super.viewDidLoad()



    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let testBezierWay = viewTest.bezierPathFromView(lineWidth: 5) {

            //просто рисуем весь путь
            shapeLayer.path = testBezierWay.cgPath

            shapeLayer.lineCap = CAShapeLayerLineCap.round;// Конец и начало линии будут заокругленными
            shapeLayer.lineJoin = CAShapeLayerLineJoin.round;//Переход между линиями будет заоккругл

            shapeLayer.strokeColor = UIColor.black.cgColor
            shapeLayer.fillColor = UIColor.clear.cgColor //содержимое внутри
            shapeLayer.lineWidth = 5.0

            self.view.layer.addSublayer(shapeLayer)


            //анимация

            let duration: Double = 5
            let rollToStroke: CGFloat = 0.59 //часть что мы потом хотим скрыть (в данном случае сделано подбором)

            var pathAnimation: CABasicAnimation = CABasicAnimation(keyPath: "strokeEnd")
            pathAnimation.duration = duration;
            pathAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
            pathAnimation.fromValue = 0
            pathAnimation.toValue = 1

            pathAnimation.autoreverses = false
            shapeLayer.add(pathAnimation, forKey: "strokeEndAnimation")

            shapeLayer.strokeEnd = 1.0;


            ///
            pathAnimation = CABasicAnimation(keyPath: "strokeStart")
            pathAnimation.duration = 1.2 * duration

            pathAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
            pathAnimation.fromValue = 0
            pathAnimation.toValue = rollToStroke
            pathAnimation.autoreverses = false

            shapeLayer.add(pathAnimation, forKey: "strokeStartAnimation")
            shapeLayer.strokeStart = rollToStroke

        }

    }



    
    
    @IBAction func sliderValueChanged(sender: UISlider) {
        shapeLayer.removeAllAnimations()
        shapeLayer.strokeEnd = CGFloat(sender.value)
    }

    @IBAction func playButton(_ sender: Any) {

        let animation = CABasicAnimation(keyPath: "strokeEnd")

        animation.fromValue = 0.0
        animation.byValue = 1.0
        animation.duration = 1.5

        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = true

        shapeLayer.add(animation, forKey: "drawLineAnimation")

    }


}


extension UIView{

    private func bezierWay(finishPoint: CGPoint) -> UIBezierPath {

        let bPath = UIBezierPath()
        bPath.move(to: CGPoint.zero)

        bPath.addLine(to: CGPoint(x: 50, y: 50))

        bPath.addArc(withCenter: CGPoint(x: 75, y: 75),
                     radius: 50,
                     startAngle: 0,
                     endAngle: .pi/2,
                     clockwise: true)


        bPath.addLine(to: CGPoint(x: 200, y: 100))

        bPath.addArc(withCenter: CGPoint(x: 200, y: 200),
                     radius: 50,
                     startAngle: .pi,
                     endAngle: .pi/2,
                     clockwise: true)

        bPath.addLine(to: CGPoint(x: 300, y: 300))
        bPath.addLine(to: finishPoint)
        
        return bPath

    }



    var frameInSuperview: CGRect? {

        guard let frameSuperview = self.superview?.convert(self.frame, to: nil) else {
            return nil
        }

        return frameSuperview
    }


    func bezierPathFromView(lineWidth: CGFloat) -> UIBezierPath? {

        guard let frameSuperview = self.frameInSuperview else {
            return nil
        }

        let aHalfWidth = lineWidth / 2

        let pointOriginX = frameSuperview.origin.x - aHalfWidth
        let pointOriginY = frameSuperview.origin.y - aHalfWidth

        let pointUpRightX = frameSuperview.origin.x + frameSuperview.size.width + aHalfWidth
        let pointDownY = frameSuperview.origin.y + frameSuperview.size.height + aHalfWidth


        let bPath = self.bezierWay(finishPoint: frameSuperview.origin)

        bPath.lineCapStyle = .round
        bPath.lineJoinStyle = .round

        let radius = self.layer.cornerRadius
        let isCirklAngl = radius != 0

        //НАЧИНАЕМ ОТРИСОВКУ

        bPath.move(to: CGPoint(x: pointOriginX + radius, y: pointOriginY))
        bPath.addLine(to: CGPoint(x: pointUpRightX - radius, y: pointOriginY))

        //верхний правый угол

        if isCirklAngl {

            let pointCentr = CGPoint(x: pointUpRightX - radius, y: pointOriginY + radius)
            bPath.addArc(withCenter: pointCentr,
                         radius: radius,
                         startAngle: 3 * .pi / 2,
                         endAngle: 0,
                         clockwise: true)

        }

        bPath.addLine(to: CGPoint(x: pointUpRightX, y: pointDownY - radius))


        //нижний правый угол

        if isCirklAngl {

            let pointCentr = CGPoint(x: pointUpRightX - radius, y: pointDownY - radius)
            bPath.addArc(withCenter: pointCentr,
                         radius: radius,
                         startAngle: 0,
                         endAngle: .pi/2,
                         clockwise: true)

        }

        bPath.addLine(to: CGPoint(x: pointOriginX + radius, y: pointDownY))

        //нижний левый угол

        if isCirklAngl {

            let pointCentr = CGPoint(x: pointOriginX + radius, y: pointDownY - radius)

            bPath.addArc(withCenter: pointCentr,
                         radius: radius,
                         startAngle: .pi/2,
                         endAngle: .pi,
                         clockwise: true)

        }

//        //верхний правый угол

        if isCirklAngl {

            let pointCentr = CGPoint(x: pointOriginX + radius,
                                     y: pointOriginY + radius)

            bPath.addArc(withCenter: pointCentr,
                         radius: radius,
                         startAngle: .pi,
                         endAngle: 3 * .pi / 2,
                         clockwise: true)

        }

        bPath.close()

        return bPath


    }
}














