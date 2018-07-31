//
//  JoeARVC.swift
//  SwiftProject
//
//  Created by Archimboldi on 2018/7/30.
//  Copyright © 2018年 KJ. All rights reserved.
//

import UIKit
import ARKit

class JoeAR1VC: JoeViewController {
    
    let sceneView = ARSCNView()

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
        
        addTapGestureToSceneView()
        
        //addPaperPlane()
        
        addCar()
        
        configureLighting()
    }
    
    
    func makeOneSCNNode() -> SCNNode {
        
        let box = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)

        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "girl")
        
        let boxNode = SCNNode()
        boxNode.geometry = box
        //boxNode.position = SCNVector3(0, 0, -0.2)
        boxNode.geometry?.materials = [material]
        
        //let scene = SCNScene()
        //scene.rootNode.addChildNode(boxNode)
        //sceneView.scene = scene
        
        return boxNode
    }
    
    
    func addTapGestureToSceneView() {
        
        let tapGestureRecognizer_Remove = UITapGestureRecognizer(target: self, action: #selector(didDoubleTap(_:)))
        tapGestureRecognizer_Remove.numberOfTapsRequired = 1 //次数
        tapGestureRecognizer_Remove.numberOfTouchesRequired = 2 //手指数
        
        
        let tapGestureRecognizer_Add = UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
        tapGestureRecognizer_Add.numberOfTapsRequired = 1 //次数
        tapGestureRecognizer_Add.numberOfTouchesRequired = 1 //手指数
        
        sceneView.addGestureRecognizer(tapGestureRecognizer_Remove)
        sceneView.addGestureRecognizer(tapGestureRecognizer_Add)
    }
    
    @objc func didDoubleTap(_ recognizer: UIGestureRecognizer){
        
        let tapLocation = recognizer.location(in: sceneView)
        let hitTestResults = sceneView.hitTest(tapLocation)
        guard let node = hitTestResults.first?.node else { return }
        node.removeFromParentNode()
    }
    
    @objc func didTap(_ recognizer: UIGestureRecognizer){
        let tapLocation = recognizer.location(in: sceneView)
        
        let hitTestResultsWithFeaturePoints = sceneView.hitTest(tapLocation, types: .featurePoint)
        
        if let hitTestResultWithFeaturePoints = hitTestResultsWithFeaturePoints.first {
            
            let translation = hitTestResultWithFeaturePoints.worldTransform.translation
            addBox(x: translation.x, y: translation.y, z: translation.z)
        }
        
    }
 
    func addBox(x: Float = 0, y: Float = 0, z: Float = -0.2) {
        
        //let box = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
        
        let boxNode = makeOneSCNNode()
        //boxNode.geometry = box
        boxNode.position = SCNVector3(x, y, z)

        sceneView.scene.rootNode.addChildNode(boxNode)
        
    }
    
    
    func addPaperPlane(x: Float = 0, y: Float = 0, z: Float = -0.5) {
        
        guard let paperPlaneScene = SCNScene(named: "paperPlane.scn"), let paperPlaneNode = paperPlaneScene.rootNode.childNode(withName: "paperPlane", recursively: true) else { return }
        paperPlaneNode.position = SCNVector3(x, y, z)
        sceneView.scene.rootNode.addChildNode(paperPlaneNode)
        
    }
    
    func addCar(x: Float = 0, y: Float = 0, z: Float = -0.5) {
        guard let carScene = SCNScene(named: "car.dae") else { return }
        let carNode = SCNNode()
        let carSceneChildNodes = carScene.rootNode.childNodes
        
        for childNode in carSceneChildNodes {
            carNode.addChildNode(childNode)
        }
        
        carNode.position = SCNVector3(x, y, z)
        carNode.scale = SCNVector3(0.5, 0.5, 0.5)
        sceneView.scene.rootNode.addChildNode(carNode)
    }
    
    func configureLighting() {
        sceneView.autoenablesDefaultLighting = true
        sceneView.automaticallyUpdatesLighting = true
    }
}

extension float4x4 {
    
    var translation: float3 {
        let translation = self.columns.3
        return float3(translation.x, translation.y, translation.z)
    }
    
}
