//
//  ViewController.swift
//  ARKitPlanes
//
//  Created by Ivan Akulov on 30/12/2017.
//  Copyright © 2017 Ivan Akulov. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet var sceneView: ARSCNView!
    //в этом уроке мы на конец применим методы делегата
    //создаем массив наших классов поверхность
    var planes = [Plane]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        
        sceneView.autoenablesDefaultLighting = true
        
        // Create a new scene
        let scene = SCNScene()
        
        // Set the scene to the view
        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        configuration.planeDetection = .horizontal

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
}


// MARK: - ARSCNViewDelegate

extension ViewController: ARSCNViewDelegate {

    ///это методы делегата

    //здесь мы добавляем новую поверхность в массив
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {

        //в начале мы определяем что якорь горизонтальной поверхности
        
        guard anchor is ARPlaneAnchor else { return }

        //затем создаем по этому якорю поверхность
        
        let plane = Plane(anchor: anchor as! ARPlaneAnchor)

        //ну и добавляем поверхность
        self.planes.append(plane)
        node.addChildNode(plane)
    }

    //здесь поверхность увеличивается
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        //фильтруем до тех пор пока не получим обьект с таким же якорем

        let plane = self.planes.filter { plane in
            return plane.anchor.identifier == anchor.identifier
        }.first
        
        guard plane != nil else { return }

        //увеличиваем поверхность в размерах
        plane?.update(anchor: anchor as! ARPlaneAnchor)
    }
}


















