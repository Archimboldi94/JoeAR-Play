//
//  P5Tool.swift
//  SwiftProject
//
//  Created by Archimboldi on 2018/8/3.
//  Copyright © 2018 KJ. All rights reserved.
//

import UIKit
import ARKit

class P5Tool: NSObject {

    let config = P5Config()
    
    lazy var theObjectNode = SCNNode()
    
    ///附在卡片上的白色
    func getPlaneNode(withReferenceImage image: ARReferenceImage) -> SCNNode {
        let plane = SCNPlane(width: image.physicalSize.width,
                             height: image.physicalSize.height)
        let node = SCNNode(geometry: plane)
        node.opacity = 0.0
        node.eulerAngles.x = -.pi / 2
        theObjectNode = node
        return node
    }
    
    
    lazy var theIconNode: SCNNode = {
        var image = SCNPlane(width: config.iconW, height: config.iconH)
        image.firstMaterial?.diffuse.contents = UIImage.init(named: config.theIconStr)

        var iconNode = SCNNode(geometry: image)
        iconNode.eulerAngles.z = -.pi
        iconNode.position = self.theObjectNode.position
        iconNode.position.x = config.iconX
        iconNode.position.y = config.iconY
        return iconNode
    }()
    
    lazy var theNameNode: SCNNode = {
        let text = SCNText(string: config.theNameStr, extrusionDepth: 0)
        text.font = UIFont.systemFont(ofSize: 0.4)
        text.alignmentMode = kCAAlignmentLeft;
        
        let oneTextMaterial = SCNMaterial()
        oneTextMaterial.diffuse.contents = UIColor.red
        text.materials = [oneTextMaterial]
        
        
        let textNode = SCNNode(geometry: text)
        textNode.position = self.theObjectNode.position
        textNode.position.x = config.nameX
        textNode.position.y = config.nameY
        textNode.scale = self.theObjectNode.scale
        textNode.scale.x = config.nameScaleX
        textNode.scale.y = config.nameScaleY
 
        return textNode
    }()
    
    
    var videoPlayer: AVPlayer?
    
    lazy var theVideoNode: SCNNode = {
        
        let plane = SCNPlane(width: config.videoW, height: config.videoW)
         plane.firstMaterial?.diffuse.contents = UIColor.red
        
        var boxNode = SCNNode(geometry: plane)
        boxNode.position = self.theObjectNode.position
        boxNode.position.x = config.videoX
        boxNode.position.y = config.videoY
        //boxNode.scale = self.theObjectNode.scale
        boxNode.eulerAngles.z = -.pi
        
        let filePath = Bundle.main.path(forResource: config.theVideoStr, ofType: "mp4")
        let videoURL = URL(fileURLWithPath: filePath!)
        let avplayer = AVPlayer(url: videoURL)
        avplayer.volume = 0.0
        videoPlayer = avplayer
        let videoNode = SKVideoNode(avPlayer: avplayer)
        NotificationCenter.default.addObserver(self, selector: #selector(playEnd(notify:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
        videoNode.size = CGSize(width: 200, height: 100)
        videoNode.position = CGPoint(x: videoNode.size.width/2, y: videoNode.size.height/2)
        videoNode.zRotation = CGFloat(Float.pi)
        let skScene = SKScene()
        skScene.addChild(videoNode)
        skScene.size = videoNode.size
        plane.firstMaterial?.diffuse.contents = skScene
        videoNode.play()
        
        
        return boxNode
    }()
    
    @objc func playEnd(notify: Notification) {
        let item = notify.object as! AVPlayerItem
        if videoPlayer?.currentItem == item {
            videoPlayer?.seek(to: kCMTimeZero)
            videoPlayer?.play()
        }
    }
}
