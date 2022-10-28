//
//  RainView.swift
//  RainAndSmok
//
//  Created by Hudihka on 06/06/2019.
//  Copyright © 2019 konstantinRAZRAB. All rights reserved.
//

import UIKit
import SpriteKit   //импортни что бы работало

enum Meteo{
    case rain
    case smok
}

class RainView: SKView {//это класс наследник ЮАЙвью, но на котором может находится
                        //SpriteKit particle fail

    override func didMoveToSuperview() {

        let scene = SKScene(size: self.frame.size) //создаем сцену, участок на котором будето дождь
        scene.backgroundColor = UIColor.clear
        self.presentScene(scene)

        self.allowsTransparency = true//можно ли сделать вью прозрачной
        self.backgroundColor = UIColor.clear

    }

    func addMeteo(_ meteo: Meteo){

        let nameFile = meteo == .rain ? "RainFile.sks" : "MyParticle.sks"
        let frameHeight = meteo == .rain ? self.frame.size.height : 0 // это связанно с разным направлением
        //обьектов

        if let particles = SKEmitterNode(fileNamed: nameFile) {
            particles.position = CGPoint(x: self.frame.size.width / 2, y: frameHeight)
            particles.particlePositionRange = CGVector(dx: self.bounds.size.width, dy: 0)
            self.scene?.addChild(particles)
        }
    }

    func deleteMeteo(_ meteo: Meteo){

        let nameFile = meteo == .rain ? "RainFile.sks" : "MyParticle.sks"

        if let child = self.scene?.childNode(withName: nameFile) as? SKEmitterNode {
            child.removeFromParent()
        }

    }

    func settingsRain(slider: UISlider) {
        if let rain = self.scene?.childNode(withName: "RainFile.sks") as? SKEmitterNode {
            rain.particleBirthRate = CGFloat(slider.value)
        }
    }

}
