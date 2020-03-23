//
//  GameViewController.swift
//  SpriteKitDemo
//
//  Created by Ivan Akulov on 15/04/2017.
//  Copyright © 2017 Ivan Akulov. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                scene.size = self.view.bounds.size
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true    //если включено тру, то при виде с верху видны все обьекты что установленны один на другой. В противном случае только старшего родителя
            
            view.showsFPS = true        //в нижней частти экрана показывает какое фпс
            view.showsNodeCount = true  //показывает количество нодов на сцене
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    //метод для определения ориентации вью контроллера
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
