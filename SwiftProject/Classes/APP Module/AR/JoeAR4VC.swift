//
//  JoeAR4VC.swift
//  SwiftProject
//
//  Created by Archimboldi on 2018/8/1.
//  Copyright © 2018年 KJ. All rights reserved.
//

import UIKit
import ARKit
class JoeAR4VC: JoeViewController {
    
    let sceneView = ARSCNView()
    
    let carNode = SCNNode()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(sceneView)
        sceneView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        configureLighting()
        
        addCar()
        
        rotateByCamera()
    }

    func configureLighting() {
        sceneView.autoenablesDefaultLighting = true
        sceneView.automaticallyUpdatesLighting = true
    }
    
    func addCar(x: Float = 0, y: Float = 0, z: Float = -0.5) {
        guard let carScene = SCNScene(named: "car.dae") else { return }
        
        let carSceneChildNodes = carScene.rootNode.childNodes
        
        for childNode in carSceneChildNodes {
            carNode.addChildNode(childNode)
        }
        
        carNode.position = SCNVector3(x, y, z)
        carNode.scale = SCNVector3(0.5, 0.5, 0.5)
        sceneView.scene.rootNode.addChildNode(carNode)
    }

    func rotateByCamera() {
        
        let emptyNode = SCNNode()
        
        emptyNode.position = SCNVector3Zero
        //emptyNode.rotation = SCNVector4Make(0, 1, 0, Float.pi/Float(1/2) * Float(1)) ??
        sceneView.scene.rootNode.addChildNode(emptyNode)
        emptyNode.addChildNode(carNode)
        //这个position就是node的坐标原点相对parentNode坐标原点的位置。
        carNode.position = SCNVector3(120, 0, 0)
        
        let ringAction = SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 1, z: 0, duration: 3))
        emptyNode.runAction(ringAction)

    }
}
