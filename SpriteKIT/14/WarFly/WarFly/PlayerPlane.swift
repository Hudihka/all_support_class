//
//  PlayerPlane.swift
//  WarFly
//
//  Created by Ivan Akulov on 24/04/2017.
//  Copyright © 2017 Ivan Akulov. All rights reserved.
//

import SpriteKit
import CoreMotion



class PlayerPlane: SKSpriteNode {
    
    let motionManager = CMMotionManager()
    var xAcceleration: CGFloat = 0
    let screenSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)

    //массивы с обьектами которые будем применять для анимации

    var leftTextureArrayAnimation = [SKTexture]()
    var rightTextureArrayAnimation = [SKTexture]()
    var forwardTextureArrayAnimation = [SKTexture]()
    //каой сейчас ттип анимации используеттся
    var moveDirection: TurnDirection = .none

    //сейчас идетт анимация
    var stillTurning = false
    
    static func populate(at point: CGPoint) -> PlayerPlane {
        let playerPlaneTexture = SKTexture(imageNamed: "airplane_3ver2_13")
        let playerPlane = PlayerPlane(texture: playerPlaneTexture)
        playerPlane.setScale(0.5)
        playerPlane.position = point
        playerPlane.zPosition = 20
        return playerPlane
    }
    
    func checkPosition() {
        self.position.x += xAcceleration * 50
        
        if self.position.x < -70 {
            self.position.x = screenSize.width + 70
        } else if self.position.x > screenSize.width + 70 {
            self.position.x = -70
        }
    }
    
    func performFly() {


        //перед каждой анимацией заполняется 3 массива
        //каждый из которых нужен для какой нибудь анимации
        planeAnimationFillArray()


        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { [unowned self] (data, error) in
            if let data = data {
                let acceleration = data.acceleration
                self.xAcceleration = CGFloat(acceleration.x) * 0.7 + self.xAcceleration * 0.3
                print(self.xAcceleration)
            }
        }
        
        let planeWaitAction = SKAction.wait(forDuration: 1.0)
        let planeDirectionCheckAction = SKAction.run { [unowned self] in
            self.movementDirectionCheck()
        }
        let planeSequence = SKAction.sequence([planeWaitAction, planeDirectionCheckAction])
        let planeSequenceForever = SKAction.repeatForever(planeSequence)
        self.run(planeSequenceForever)
        
    }
    
    fileprivate func planeAnimationFillArray() {

        //досттаем атлас из проектта
        SKTextureAtlas.preloadTextureAtlases([SKTextureAtlas(named: "PlayerPlane")]) {

            //заполняем каждый массив
            self.leftTextureArrayAnimation = {
                
                var array = [SKTexture]()
                //от 13 до 1 с шагом -1
                for i in stride(from: 13, through: 1, by: -1) {
                    let number = String(format: "%02d", i)
                    let texture = SKTexture(imageNamed: "airplane_3ver2_\(number)")
                    array.append(texture)
                }

                //здесь прогружаем массив, этто надо для того что бы не было притормаживания
                
                SKTexture.preload(array, withCompletionHandler: {
                    print("preload is done")
                })
                return array
                
            }()
            
            self.rightTextureArrayAnimation = {
                
                var array = [SKTexture]()
                for i in stride(from: 13, through: 26, by: 1) {
                    let number = String(format: "%02d", i)
                    let texture = SKTexture(imageNamed: "airplane_3ver2_\(number)")
                    array.append(texture)
                }
                
                SKTexture.preload(array, withCompletionHandler: {
                    print("preload is done")
                })
                return array
                
            }()
            
            self.forwardTextureArrayAnimation = {
                
                var array = [SKTexture]()
                let texture = SKTexture(imageNamed: "airplane_3ver2_13")
                array.append(texture)
                
                
                SKTexture.preload(array, withCompletionHandler: {
                    print("preload is done")
                })
                return array
                
            }()
        }
    }
    
    fileprivate func movementDirectionCheck() {

        //здесь происходит насттройка параметров анимации
        //те когда начнем, чтто бы не было ситтуаций чтто запусттили анимацию пока другая не закончилась

        //сильно ли наклонили    //использовалась не правая анимация
        if xAcceleration > 0.02, moveDirection != .right,
            stillTurning == false { //превед анимация закончилась
            stillTurning = true
            moveDirection = .right
            turnPlane(direction: .right)
        } else if xAcceleration < -0.02, moveDirection != .left, stillTurning == false {
            stillTurning = true
            moveDirection = .left
            turnPlane(direction: .left)
        } else if stillTurning == false {
            turnPlane(direction: .none)
        }
    }

    //ну и собсттвенно запускаем анимацию
    fileprivate func turnPlane(direction: TurnDirection) {
        var array = [SKTexture]()

        //выбираем нужный массив
        if direction == .right {
            array = rightTextureArrayAnimation
        } else if direction == .left {
            array = leftTextureArrayAnimation
        } else {
            array = forwardTextureArrayAnimation
        }
        //анимация вперед
        let forwardAction = SKAction.animate(with: array,   //какой массив
                                             timePerFrame: 0.05,//каой промежуток между сменой кадров
                                             resize: true,      //меняет ли изображение размер во время анимации
                                             restore: false)    //возвращается ли в исходное положение после заверщения

        //анимация назад
        let backwardAction = SKAction.animate(with: array.reversed(), timePerFrame: 0.05, resize: true, restore: false)

        //создаем очередь анимаций
        let sequenceAction = SKAction.sequence([forwardAction, backwardAction])

        //запускаем их и после этого говорим чтто анимация завершилась
        self.run(sequenceAction) { [unowned self] in
            self.stillTurning = false
        }
    }
}


enum TurnDirection {
    case left
    case right
    case none
}






























