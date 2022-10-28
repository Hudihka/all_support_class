//
//  PlayerPlane.swift
//  WarFly
//
//  Created by Ivan Akulov on 24/04/2017.
//  Copyright © 2017 Ivan Akulov. All rights reserved.
//

import SpriteKit

//этот класс предсттавляетт из себя клас собственно самого самолетта
//каринки этого класса добавляются не простто в асетты,
//создается папка .atlas расширением
//ттам собственно и будут находитться все изображения анимации

class PlayerPlane: SKSpriteNode {
    static func populate(at point: CGPoint) -> SKSpriteNode {
        // поскольку мы хотим что бы наш самалет был анимированным мы делаем его
        //ттекстурой а не простто нодом, изображение задаеттся то, что
        //по центтру
        let playerPlaneTexture = SKTexture(imageNamed: "airplane_3ver2_13")

        //ттеперь уже создаем нод на основе структтуры
        let playerPlane = SKSpriteNode(texture: playerPlaneTexture)
        //уменьшаем размер в 2 раза
        playerPlane.setScale(0.5)
        //задаем позицию на экране
        playerPlane.position = point

        //задаем Z позицию
        //те положение в данном случае в самом верху будетт
        playerPlane.zPosition = 20
        return playerPlane
    }
}
