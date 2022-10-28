//
//  GameScene.swift
//  WarFly
//
//  Created by Ivan Akulov on 19/04/2017.
//  Copyright © 2017 Ivan Akulov. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion  //фраемворк предсттавляющий акселирометр усттройсттва

class GameScene: SKScene {
    
    let motionManager = CMMotionManager() //собсттвенно обьект класса мониторинга, нужен для определения положения устройсттва
    var xAcceleration: CGFloat = 0
    var player: SKSpriteNode!


    //функция вроде вью дид лоада для сцены
    override func didMove(to view: SKView) {
        
        configureStartScene()
        spawnClouds()
        spawnIslands()
    }
    
    fileprivate func spawnClouds() {
        //этой и функцией ниже мы бесконечно формируем рандомные облака и осттрова

        //создаем действие которое по сути держит являеттся диспатчем задержки
        let spawnCloudWait = SKAction.wait(forDuration: 1)

        //так же задаем экшен просто добавления облака в рандомной тточке
        let spawnCloudAction = SKAction.run {
            let cloud = Cloud.populate(at: nil)
            self.addChild(cloud)
        }

        //запускаем эти экшены один за другим
        let spawnCloudSequence = SKAction.sequence([spawnCloudWait, spawnCloudAction])
        //здесь мы блок выполнения один за другим повтторяем бесконечно
        let spawnCloudForever = SKAction.repeatForever(spawnCloudSequence)
        //ну и собсттвенно запускаем этот бесконечный блок
        run(spawnCloudForever)
    }
    
    fileprivate func spawnIslands() {
        let spawnIslandWait = SKAction.wait(forDuration: 2)
        let spawnIslandAction = SKAction.run {
            let island = Island.populate(at: nil)
            self.addChild(island)
        }
        
        let spawnIslandSequence = SKAction.sequence([spawnIslandWait, spawnIslandAction])
        let spawnIslandForever = SKAction.repeatForever(spawnIslandSequence)
        run(spawnIslandForever)
    }

    //функция запускаемая при старте проектта, задаем фон и старттовые позиции первых облаков и осттравов
    
    fileprivate func configureStartScene() {

        //в начале создаем центтр вьюхи
        let screenCenterPoint = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        //ДАЛЕЕ создаем бэкграунд в центре вью
        let background = Background.populateBackground(at: screenCenterPoint)
        //и размером с наш вью контроллер
        background.size = self.size
        self.addChild(background)
        
        let screen = UIScreen.main.bounds


        //создаем пару островов
        let island1 = Island.populate(at: CGPoint(x: 100, y: 200))
        self.addChild(island1)
        
        let island2 = Island.populate(at: CGPoint(x: self.size.width - 100, y: self.size.height - 200))
        self.addChild(island2)

        //позиция самого юзера(его самолетта)
        player = PlayerPlane.populate(at: CGPoint(x: screen.size.width / 2, y: 100))
        self.addChild(player)

        //далее идут насттройки акселирометра

        //здесь мы говорим как часто будет срабаттывать аксилерометр
        motionManager.accelerometerUpdateInterval = 0.2

        //запускаем аксилерометтр                   //запускаем очередь операции котторая запусттила ттекущую
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data, error) in
            if let data = data {
                let acceleration = data.acceleration

                //чтто бы немного уменьшитть импульс мы умножаем на 0.7
                //что бы придатть ускорение добавляем self.xAcceleration * 0.3
                self.xAcceleration = CGFloat(acceleration.x) * 0.7 + self.xAcceleration * 0.3
            }
        }
    }

    //эттот специальный метод срабаттывает сразу после ттого как устройсттво поменяло ориентацию (в данном случае акселирометтр сработтал)
    
    override func didSimulatePhysics() {
        super.didSimulatePhysics()


        //поскольку число небольшое то мы домножаем на 50
        player.position.x += xAcceleration * 50


        //если держать устройство постоянно в наклоне тто самолет будет исчезать с одной стороны и появлятться с
        //другой
        if player.position.x < -70 {
            player.position.x = self.size.width + 70
        } else if player.position.x > self.size.width + 70 {
            player.position.x = -70
        }

        //ЗДЕСЬ мы проходимся по всем нодам и если нод имеет имя "backgroundSprite" (облако или осттров)
        //и его позиция далеко в низу
        //тто мы его удаляем. stop нужен для того чтто бы завершить перебор
        
        enumerateChildNodes(withName: "backgroundSprite") { (node, stop) in
            if node.position.y < -199 {
                node.removeFromParent()
            }
        }
    }
}

















