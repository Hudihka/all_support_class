//
//  PowerUp.swift
//  WarFly
//
//  Created by Ivan Akulov on 05/05/2017.
//  Copyright © 2017 Ivan Akulov. All rights reserved.
//

import UIKit
import SpriteKit

class PowerUp: SKSpriteNode {
    let initialSize = CGSize(width: 52, height: 52)
    let textureAtlas = SKTextureAtlas(named: "GreenPowerUp")//атлас в проектте
    var animationSpriteArray = [SKTexture]()
    
    init() {
        let greenTexture = textureAtlas.textureNamed("missle_green_01") //находим ттекстуру
        super.init(texture: greenTexture, color: .clear, size: initialSize)
        self.name = "powerUp"
        self.zPosition = 20//позиция котторая должна бытть такой же как и положение самолета
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func performRotation() {
        for i in 1...15 {   //заполняем массив тексттур
            let number = String(format: "%02d", i)
            animationSpriteArray.append(SKTexture(imageNamed: "missle_green_\(number)"))
        }
        
        SKTexture.preload(animationSpriteArray) {
            //создаем анимацию
            let rotation = SKAction.animate(with: self.animationSpriteArray, timePerFrame: 0.05, resize: true, restore: false)
            //говорим что она повтторяется бесконечно
            let rotationForever = SKAction.repeatForever(rotation)
            self.run(rotationForever)
        }
    }
}
