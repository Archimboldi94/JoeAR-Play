//
//  JoeAR7VC.swift
//  SwiftProject
//
//  Created by Archimboldi on 2018/8/2.
//  Copyright © 2018年 KJ. All rights reserved.
//

import UIKit
import ARKit

class JoeAR7VC: JoeViewController {

    let sceneView = ARSCNView()
    
    var videoPlayer: AVPlayer?
    
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
        
        makeImageRing()
        
        makeVideo()
            
    }

    func makeImageRing() {
        
        let theRingNode = SCNNode()
        
        theRingNode.position = SCNVector3Zero
        sceneView.scene.rootNode.addChildNode(theRingNode)
        
        let imageArr : [String] = ["jiake", "girl", "1", "2"]
        
        let ringRadius: Float = 6.0
        let photoW: CGFloat       = 1.2
        let photoH: CGFloat       = photoW * 0.618
        let radius: CGFloat = 0
        
        for index in 0..<imageArr.count {
            let photo = SCNPlane(width: photoW, height: photoH)
            photo.cornerRadius = radius
            photo.firstMaterial?.diffuse.contents = UIImage.init(named: imageArr[index])
            
            let photoNode = SCNNode(geometry: photo)
            //photoNode 的位置都是一个  靠下面emptyNode的rotation来分布位置
            photoNode.position = SCNVector3Make(0, 0, -ringRadius)
            
            let emptyNode = SCNNode()
            emptyNode.position = SCNVector3Zero
            emptyNode.rotation = SCNVector4Make(0, 1, 0, Float.pi/Float(imageArr.count/2) * Float(index))
            emptyNode.addChildNode(photoNode)
            theRingNode.addChildNode(emptyNode)
            
        }
        let ringAction = SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: -1, z: 0, duration: 20))
        theRingNode.runAction(ringAction)
        
    }
    
    func makeVideo() {
        
        let boxNode = SCNNode()
        let width: CGFloat = 1.5
        let height: CGFloat = 0.7
        let box = SCNBox(width: width, height: height, length: 0.3, chamferRadius: 0)
        boxNode.geometry = box
        boxNode.geometry?.firstMaterial?.isDoubleSided = true
        boxNode.position = SCNVector3Make(0, 0, -3)
        box.firstMaterial?.diffuse.contents = UIColor.red
        sceneView.scene.rootNode.addChildNode(boxNode)
        
        let filePath = Bundle.main.path(forResource: "freeVideo", ofType: "mp4")
        let videoURL = URL(fileURLWithPath: filePath!)
        let avplayer = AVPlayer(url: videoURL)
        avplayer.volume = 0.0
        videoPlayer = avplayer
        let videoNode = SKVideoNode(avPlayer: avplayer)
        NotificationCenter.default.addObserver(self, selector: #selector(playEnd(notify:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
        videoNode.size = CGSize(width: 1600, height: 900)
        videoNode.position = CGPoint(x: videoNode.size.width/2, y: videoNode.size.height/2)
        videoNode.zRotation = CGFloat(Float.pi)
        let skScene = SKScene()
        skScene.addChild(videoNode)
        skScene.size = videoNode.size
        box.firstMaterial?.diffuse.contents = skScene
        videoNode.play()
        
    }
    
    @objc func playEnd(notify: Notification) {
        let item = notify.object as! AVPlayerItem
        if videoPlayer?.currentItem == item {
            videoPlayer?.seek(to: kCMTimeZero)
            videoPlayer?.play()
        }
//        else if  musicPlayer.currentItem == item {
//            musicPlayer.seek(to: kCMTimeZero)
//            musicPlayer.play()
//        }
    }
}
