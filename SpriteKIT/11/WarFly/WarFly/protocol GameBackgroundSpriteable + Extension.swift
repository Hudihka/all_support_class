//
//  protocol GameBackgroundSpriteable + Extension.swift
//  WarFly
//
//  Created by Ivan Akulov on 27/04/2017.
//  Copyright © 2017 Ivan Akulov. All rights reserved.
//

import SpriteKit
import GameplayKit


protocol GameBackgroundSpriteable {
    static func populate(at point: CGPoint?) -> Self
    static func randomPoint() -> CGPoint
}

//я как понял при создании игр точка ноль находиттся в нижнем левом углу а не в правом


extension GameBackgroundSpriteable {

    //функция нужна для генерации
    static func randomPoint() -> CGPoint {

        //поскольку эттой функцией мы генерируем облака и острова а их тточка ноль находится в верху(на самом
        //деле в центре, но мы переделали якорь под верхнюю границу), поэттому мы добавляем к высоте
        //экрана от 400 до 500 через GKRandomDistribution что бы сгенерироватть непредвзятое
        //число между эттих границ

        let screen = UIScreen.main.bounds
        let distribution = GKRandomDistribution(lowestValue: Int(screen.size.height) + 400, highestValue: Int(screen.size.height) + 500)


        let y = CGFloat(distribution.nextInt()) //ну и собсттвенно берем число из выборки
        //в случае с иксом все проще, мы делаем выборку от 0 до макс икс
        let x = CGFloat(GKRandomSource.sharedRandom().nextInt(upperBound: Int(screen.size.width)))
        return CGPoint(x: x, y: y)
    }
}
