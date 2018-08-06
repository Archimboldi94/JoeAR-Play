//
//  JoeAR6VC.swift
//  SwiftProject
//
//  Created by Archimboldi on 2018/8/1.
//  Copyright © 2018年 KJ. All rights reserved.
//

import UIKit
import ARKit
class JoeAR6VC: JoeViewController {

    
    let sceneView = ARSCNView()
    
    let theImageView = UIImageView()
    
    lazy var theObjectNode: SCNNode = {
        var make = SCNNode()
        return make
    }()
    
    lazy var theInfoNode: SCNNode = {
        var make = SCNNode()
        let aPlane = SCNPlane(width: 0.2, height: 0.2)
        aPlane.firstMaterial?.diffuse.contents = UIColor.white
        make.geometry = aPlane
        make.position = SCNVector3Make(0.15, 0.05, 0)
        make.opacity = 0.0
        make.eulerAngles.x = -.pi / 2
        return make
    }()
    
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
        
        view.addSubview(theImageView)
        theImageView.snp.makeConstraints { (make) in
            make.width.equalTo(230/2)
            make.height.equalTo(210/2)
            make.bottom.equalTo(-50)
            make.centerX.equalTo(view.snp.centerX)
        }
    }
    
    func resetTrackingConfiguration() {
        guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil) else { return }
        let configuration = ARWorldTrackingConfiguration()
        configuration.detectionImages = referenceImages
        let options: ARSession.RunOptions = [.resetTracking, .removeExistingAnchors]
        sceneView.session.run(configuration, options: options)
        
    }

    let fadeDuration: TimeInterval = 1
    
    lazy var fadeAction: SCNAction = {
        return .sequence([
            .fadeOpacity(by: 0.5, duration: fadeDuration)
            ])
    }()
}


extension JoeAR6VC: ARSCNViewDelegate {
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        DispatchQueue.main.async {
            guard let imageAnchor = anchor as? ARImageAnchor,
                let imageName = imageAnchor.referenceImage.name else { return }
            uLog("imageName == \(imageName)")
            
            self.theImageView.image = UIImage.init(named: imageName)
            // TODO: Comment out code
            let planeNode = self.getPlaneNode(withReferenceImage: imageAnchor.referenceImage)
            planeNode.opacity = 0.0
            planeNode.eulerAngles.x = -.pi / 2
            planeNode.runAction(self.fadeAction)
            node.addChildNode(planeNode)
            self.makeMyObject(node)
            
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
//        guard let imageAnchor = anchor as? ARImageAnchor,
//            let imageName = imageAnchor.referenceImage.name else { return }
//            uLog("imageName == \(imageName)")
        //let imageAnchor = anchor as? ARImageAnchor
        //let planeNode = self.getPlaneNode(withReferenceImage: (imageAnchor?.referenceImage)!)
        //self.theObjectNode.childNodes.first?.position = node.position
    }
    
    func getPlaneNode(withReferenceImage image: ARReferenceImage) -> SCNNode {
        let plane = SCNPlane(width: image.physicalSize.width,
                             height: image.physicalSize.height)
        let node = SCNNode(geometry: plane)
        return node
    }
    
    func makeMyObject(_ thePlaneNode: SCNNode) {
        self.theObjectNode = thePlaneNode
        self.theObjectNode.addChildNode(theInfoNode)
        theInfoNode.runAction(self.fadeAction)
    }
    
    
}
