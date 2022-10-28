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

    //здесь добавлялись жесты
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        sceneView.autoenablesDefaultLighting = true  //добавление теней на обьекты
        
        let scene = SCNScene()
        createBox(in: scene)

        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(boxTapped(touch:)))//добавляем жест
        self.sceneView.addGestureRecognizer(gestureRecognizer)
        
        sceneView.scene = scene
    }
    
    @objc func boxTapped(touch: UITapGestureRecognizer) {
        let sceneView = touch.view as! SCNView              //в начале мы определяем сцена ли это
        let touchLocation = touch.location(in: sceneView)   //заттем локацию сцены по локации ттапа
        
        let touchResults = sceneView.hitTest(touchLocation, options: [:])   //и в конце концов берем обьекты по локации

        //далее проверяем что естть обьект и берем первый нод отттуда
        guard !touchResults.isEmpty, let node = touchResults.first?.node else { return }
        let boxMaterial = SCNMaterial()
        boxMaterial.diffuse.contents = UIColor.blue  //ну и задаем новый материал
        boxMaterial.specular.contents = UIColor.red
        node.geometry?.materials[0] = boxMaterial
        
    }


    //прсто добавляем кубик на сцену
    private func createBox(in scene: SCNScene) {
        let box = SCNBox(width: 0.2, height: 0.2, length: 0.2, chamferRadius: 0)
        let boxMaterial = SCNMaterial()
        
        boxMaterial.diffuse.contents = UIColor.red
        boxMaterial.specular.contents = UIColor.yellow  //цвет который отражается от обьктта
        
        let boxNode = SCNNode(geometry: box)
        boxNode.geometry?.materials = [boxMaterial]
        boxNode.position = SCNVector3(0.0, 0.0, -1.0)
        scene.rootNode.addChildNode(boxNode)
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















