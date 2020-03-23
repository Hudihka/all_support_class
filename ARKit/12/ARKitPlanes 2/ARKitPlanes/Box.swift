//
//  Box.swift
//  ARKitPlanes
//
//  Created by Ivan Akulov on 30/12/2017.
//  Copyright © 2017 Ivan Akulov. All rights reserved.
//

import SceneKit
import ARKit

class Box: SCNNode {
    
    init(atPosition position: SCNVector3) {
        super.init()
        
        let boxGeometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
        
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.green
        
        boxGeometry.materials = [material]
        
        self.geometry = boxGeometry

        /*по сути физику включают эти 2 строчки
         первая строка это для какой геометрии применить
         вттроя это добавлению ноду этой геометрии и тип
         динамический значит что обьект ведет себя как мячик
         статический как например грузавик в который кинули мячик
         kinematic вообще не подвизный
         */
        let physicsShape = SCNPhysicsShape(geometry: self.geometry!, options: nil)
        self.physicsBody = SCNPhysicsBody(type: .dynamic, shape: physicsShape)
        
        self.position = position
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}








