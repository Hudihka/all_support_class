//
//  Island.swift
//  WarFly
//
//  Created by Ivan Akulov on 19/04/2017.
//  Copyright © 2017 Ivan Akulov. All rights reserved.
//

import SpriteKit
import GameplayKit

//в начале посмоттри на протокол

final class Island: SKSpriteNode, GameBackgroundSpriteable {
    //здесь мы собсттвенно создаем остров
    static func populate(at point: CGPoint?) -> Island {

        //рандом имя из функции ниже
        let islandImageName = configureName()
        let island = Island(imageNamed: islandImageName)

        //рандом размер из функции ниже
        island.setScale(randomScaleFactor)


        island.position = point ?? randomPoint()
        island.zPosition = 1
        island.name = "backgroundSprite"
        island.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        island.run(rotateForRandomAngle())
        island.run(move(from: island.position))
        return island
    }

    //поскольку у нас несколько моделей островов
    //то и файл с именем осттрова мы выбираем рандомно
    
    fileprivate static func configureName() -> String {
        //это выборка с учетом границ
        let distribution = GKRandomDistribution(lowestValue: 1, highestValue: 4)
        let randomNumber = distribution.nextInt()
        let imageName = "is" + "\(randomNumber)"

        //ну и собсттвенно имя
        return imageName
    }
    
    fileprivate static var randomScaleFactor: CGFloat {
        //здесь мы получаем коеф размера острова те от 0.1 до 1
        let distribution = GKRandomDistribution(lowestValue: 1, highestValue: 10)
        let randomNumber = CGFloat(distribution.nextInt()) / 10
        
        return randomNumber
    }
    
    fileprivate static func rotateForRandomAngle() -> SKAction {
        //что бы остров оказался в наклоне надо угол резко поменять
        //по сути зделать анимацию за 0 времени

        //здесь мы получаем угол от 0 до 360 в градусах
        let distribution = GKRandomDistribution(lowestValue: 0, highestValue: 360)
        let randomNumber = CGFloat(distribution.nextInt())

        //далее мы поворачиваем                        это коэфициентт для радиан
        return SKAction.rotate(toAngle: randomNumber * CGFloat(Double.pi / 180), duration: 0)
    }
    
    fileprivate static func move(from point: CGPoint) -> SKAction {
        //здесь мы задаем начальную позицию
        //где то в верху за картой и икс
        let movePoint = CGPoint(x: point.x, y: -200)

        //конечная тточка немного в низу
        let moveDistance = point.y + 200

        //здесь мы задаеми скорость
        let movementSpeed: CGFloat = 100.0
        //и вычисляем время
        let duration = moveDistance / movementSpeed
        //ну и говорим обьекту что бы он двигался горизонтально в низ
        return SKAction.move(to: movePoint, duration: TimeInterval(duration))
    }
}
















