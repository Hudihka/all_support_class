//
//  ViewController.swift
//  start
//
//  Created by Hudihka on 26/08/2019.
//  Copyright © 2019 konstantinRAZRAB. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self   //ну этто и так поняттно
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true//это надо для дебага, что бы в нижней частти экрана показывалась статисттика
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/ship.scn")! //это мы достаем обьект котрый собсвенно и отобразим
        
        // Set the scene to the view
        sceneView.scene = scene //на наше проперти сцена вью накладываем обьект
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()      //создаем просттую конфигурацию и запускаем при заходе на экран

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()   //сттавим на паузу что бы не кушало батарею
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/



    /////////методы делегата
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
