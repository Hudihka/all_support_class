//
//  GameScene.swift
//  SpriteKitDemo
//
//  Created by Ivan Akulov on 15/04/2017.
//  Copyright © 2017 Ivan Akulov. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
        //ноды по умолчанию создаются по центру
        //но с помощью этого метода мы переопределяем их в точку ноль
        self.anchorPoint = .zero
        let sprite = SKSpriteNode(color: .red, size: CGSize(width: 100, height: 100))
        self.addChild(sprite)

        //здесь мы создаем нод уже через изображение
        let spaceship = SKSpriteNode(imageNamed: "Spaceship")
        //задаем его размер
        spaceship.setScale(0.3)
        //позицию
        spaceship.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        self.addChild(spaceship)


        //создаем точку куда будет перемещатться обьектт
        let movePoint = CGPoint(x: self.size.width, y: self.size.height)
        //по сутти это анимация время и в какую точку
        let moveSpaceShipAction = SKAction.move(to: movePoint, duration: 3)
        //запускаем анимацию
//        spaceship.run(moveSpaceShipAction)

        //говорим что бы обьект исчез в течении 0.5 секунд
        let fadeOutAction = SKAction.fadeOut(withDuration: 0.5)
        //чтто бы появился в течении 0.5 секунд
        let fadeInAction = SKAction.fadeIn(withDuration: 0.5)
        //мы можем задать сразу несколько анимаций обьектту одна за другой таким способом
        let fadeOutFadeInSequence = SKAction.sequence([fadeOutAction, fadeInAction])
        //и говорим сколько раз повторятть
        let fadeOutFadeInSequenceFiveTimes = SKAction.repeat(fadeOutFadeInSequence, count: 5)
        
//        spaceship.run(fadeOutFadeInSequenceFiveTimes)



        //когда надо запуститть сразу несколько анимаций применяются
        //такой метод
        let groupMoveAndFadeActions = SKAction.group([moveSpaceShipAction, fadeOutFadeInSequenceFiveTimes])
        spaceship.run(groupMoveAndFadeActions)
        
    }
}
