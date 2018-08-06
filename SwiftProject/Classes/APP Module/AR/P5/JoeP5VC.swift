//
//  JoeP5VC.swift
//  SwiftProject
//
//  Created by Archimboldi on 2018/8/3.
//  Copyright © 2018 KJ. All rights reserved.
//

import UIKit
import ARKit

class JoeP5VC: JoeViewController {
    
    let sceneView = ARSCNView()
    
    let theTool = P5Tool()
    
    lazy var thePlanNode = SCNNode()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        resetTrackingConfiguration()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        view.addSubview(sceneView)
        sceneView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    
    func resetTrackingConfiguration() {
 
        if #available(iOS 12.0, *) {
            let configuration = ARImageTrackingConfiguration()
            guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil) else {
                fatalError("Missing expected asset catalog resources.")
            }
            
            configuration.trackingImages = referenceImages
            
            // Run the view's session
            sceneView.session.run(configuration)
        }
    }
 
    lazy var fadeAction: SCNAction = {
        return .sequence([
            .fadeOpacity(by: 1, duration: 1)
            ])
    }()

}


extension JoeP5VC: ARSCNViewDelegate {
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        DispatchQueue.main.async {
            guard let imageAnchor = anchor as? ARImageAnchor,
                let imageName = imageAnchor.referenceImage.name else { return }
            uLog("imageName == \(imageName)")
            
            let planeNode = self.theTool.getPlaneNode(withReferenceImage: imageAnchor.referenceImage)
           
            planeNode.runAction(self.fadeAction)
            node.addChildNode(planeNode)
            self.thePlanNode = planeNode
           
            self.addInfoNodes()
        }
    }
    
 
    func addInfoNodes() {
        self.thePlanNode.addChildNode(self.theTool.theIconNode)
        self.thePlanNode.addChildNode(self.theTool.theNameNode)
        self.thePlanNode.addChildNode(self.theTool.theVideoNode)
        
    }
    
    

}
