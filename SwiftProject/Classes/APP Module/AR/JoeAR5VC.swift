//
//  JoeAR5VC.swift
//  SwiftProject
//
//  Created by Archimboldi on 2018/8/1.
//  Copyright © 2018年 KJ. All rights reserved.
//

import UIKit
import ARKit
class JoeAR5VC: JoeViewController {

   
    let sunNode = SCNNode()
    let earthNode = SCNNode()
    let moonNode = SCNNode()
    
    let earthColor = UIColor(red:0.18, green:0.58, blue:0.97, alpha:0.70)
    let moonColor = UIColor(red:0.83, green:0.82, blue:0.83, alpha:0.70)
    
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
        
        addSun()
        rotation(sunNode)
        
        addEarth()
        rotation(earthNode)
        sunNode.addChildNode(earthNode)
        
        addMoon()
        rotation(moonNode)
        earthNode.addChildNode(moonNode)
        
    }
    
    func addSun() {
        
        //创建太阳
        let sunPhere = SCNSphere(radius: 0.1)
        sunPhere.firstMaterial?.diffuse.contents = UIImage.init(named: "JoeSun")
        sunNode.geometry = sunPhere
        sunNode.position = SCNVector3Make(0, 0, -0.7)

        //将太阳设置成光源
        sunNode.geometry?.firstMaterial?.lightingModel = .constant
        let omniLightNode = SCNNode()
        omniLightNode.light = SCNLight()
        omniLightNode.light?.type = .omni
        omniLightNode.light?.color = UIColor.white
        sunNode.addChildNode(omniLightNode)
        
        //创建文字
        let text = SCNText(string: "太阳", extrusionDepth: 0.1)
        text.font = UIFont.systemFont(ofSize: 0.3)
        text.alignmentMode = kCAAlignmentCenter;
        let textNode = SCNNode(geometry: text)
        //textNode.eulerAngles = SCNVector3Make(0, .pi, 0) //
        
        sunNode.addChildNode(textNode)
        textNode.position = sunNode.position
        
        sceneView.scene.rootNode.addChildNode(sunNode)
 
    }
    
    func addEarth() {
        let earthPhere = SCNSphere(radius: 0.05)
        earthPhere.firstMaterial?.diffuse.contents = earthColor
        earthNode.geometry = earthPhere
        earthNode.position = SCNVector3Make(0, 0, -0.3)
    }
    
    func addMoon() {
        let moonPhere = SCNSphere(radius: 0.02)
        moonPhere.firstMaterial?.diffuse.contents = moonColor
        moonNode.geometry = moonPhere
        moonNode.position = SCNVector3Make(0, 0, -0.1)
    }
    
    //自转
    func rotation(_ theNode: SCNNode) {
        let rotationAction = SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 1, z: 0, duration: 3))
        theNode.runAction(rotationAction)
    }
 
    func recenterText(_ theNode: SCNNode) {
        let sceneText = theNode.geometry as! SCNText
        let min = sceneText.boundingBox.min
        let max = sceneText.boundingBox.max
        sceneText.alignmentMode = kCAAlignmentCenter
        let textHeight = max.y - min.y
        let textWidth = max.x - min.x
        theNode.position = SCNVector3Make(-textWidth/2 , -textHeight/3*2 , 0)
    }
 

}
