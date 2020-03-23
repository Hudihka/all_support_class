//
//  Plane.swift
//  ARKitPlanes
//
//  Created by Ivan Akulov on 30/12/2017.
//  Copyright © 2017 Ivan Akulov. All rights reserved.
//

import SceneKit
import ARKit

//это кастомный класс поверхностти

class Plane: SCNNode {
    
    var anchor: ARPlaneAnchor!
    var planeGeometry: SCNPlane! //собсттвенно поверхностть
    
    init(anchor: ARPlaneAnchor) {
        self.anchor = anchor
        super.init()
        configure()
    }
    
    private func configure() {


        //моя поверхностть создается на основе якоря и плоскосттей якоря
        //x и z, будь в плоскосттях икс и игрик то она была бы стеной перед нами
        //игрик зет, ребом

        self.planeGeometry = SCNPlane(width: CGFloat(anchor.extent.x), height: CGFloat(anchor.extent.z))

        //ну тут поняттно маттериал предсттавляющиий рисунок
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "pinkWeb.png")
        
        self.planeGeometry.materials = [material]

        //далее поскольку наш класс поверхностть мы задаем его геометрию
        self.geometry = planeGeometry

        //позицию по центру якоря
        self.position = SCNVector3(anchor.center.x, 0, anchor.center.z)

        //здесь не совсем понял, но вроде как это задаетт угол поворотта в пространсттве
        self.transform = SCNMatrix4MakeRotation(Float(-Double.pi / 2), 1.0, 0.0, 0.0)
    }
    
    func update(anchor: ARPlaneAnchor) {
        //просто новая позиция нашей поверхностти
        self.planeGeometry.width = CGFloat(anchor.extent.x)
        self.planeGeometry.height = CGFloat(anchor.extent.z)
        self.position = SCNVector3(anchor.center.x, 0, anchor.center.z)
    }

    //это требует компилятор
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}











