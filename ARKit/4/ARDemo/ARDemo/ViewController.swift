//
//  ViewController.swift
//  ARDemo
//
//  Created by Ivan Akulov on 11/12/2017.
//  Copyright © 2017 Ivan Akulov. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        let scene = SCNScene()   //создаем сцену

        //здесь создаем куб, размеры в метрах chamferRadius это радиус кривизны если он равен 1 то этто шар
        let boxGeometry = SCNBox(width: 0.2, height: 0.2, length: 0.2, chamferRadius: 0)

        //создаем маттериал в данном случае простто говорим чтто куб будет коричневым
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.brown

        //по сутти обьекты чтто мы создаем и хоттим положить на сцену это ноды
        let boxNode = SCNNode(geometry: boxGeometry)        //задаем геометтрию
        boxNode.geometry?.materials = [material]            //задаем маттериал
        boxNode.position = SCNVector3(0, 0, -1.0)           //задаем позицию по xyz кординатам z = -1
                                                            //значит что обьектт будет перед нами

        
        scene.rootNode.addChildNode(boxNode)                //ну и собсттвенно добавление на сцену
        
        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
}















