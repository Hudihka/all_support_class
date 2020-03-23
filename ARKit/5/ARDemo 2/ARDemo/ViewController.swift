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
        
        let scene = SCNScene()
        
        let boxGeometry = SCNBox(width: 0.2, height: 0.2, length: 0.2, chamferRadius: 0)
        
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.brown
        
        let boxNode = SCNNode(geometry: boxGeometry)
        boxNode.geometry?.materials = [material]
        boxNode.position = SCNVector3(0, 0, -1.0)
        
        scene.rootNode.addChildNode(boxNode)

        //это новый материал

        //ну собственно задаем надпись и говорим на сколько она
        //будет выдавлена
        let textGeometry = SCNText(string: "This is the cube", extrusionDepth: 2.0)
        let textMaterial = SCNMaterial()
        textMaterial.diffuse.contents = UIColor.red
        
//        textGeometry.firstMaterial?.diffuse.contents
        
        let textNode = SCNNode(geometry: textGeometry)
        //изначально тек задаеттся гиганттским размером, здесь мы его уменьшаем
        textNode.scale = SCNVector3(0.005, 0.005, 0.005)
        textNode.geometry?.materials = [textMaterial]
        
        textNode.position = SCNVector3(0, 0.2, -1.0)
        scene.rootNode.addChildNode(textNode)
        
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















