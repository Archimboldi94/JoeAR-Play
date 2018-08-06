//
//  JoeAR8VC.swift
//  SwiftProject
//
//  Created by Archimboldi on 2018/8/2.
//  Copyright © 2018年 KJ. All rights reserved.
//

import UIKit
import ARKit
import WebKit

class JoeAR8VC: JoeViewController {

    let sceneView = ARSCNView()
     
    let queue = DispatchQueue(label: "AR.Joe.8")
    
    let theWebView = UIWebView(frame: CGRect(x: 0, y: 0, width: 800, height: 1000))
    
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
       
        makeWebView()
        
        
    }

    func makeWebView() {
        //theWebView.navigationDelegate = self
        //let url = URL(string: "https://www.jianshu.com/p/29e0d8ab91f1")!
        //theWebView.load(URLRequest(url: url))
        
        theWebView.loadRequest(NSURLRequest(url:NSURL.init(string:"https://item.taobao.com/item.htm?spm=a230r.1.14.1.48c3a359V1lZQs&id=548610360208&ns=1&abbucket=18#detail")! as URL) as URLRequest)
        let node = SCNNode()
        node.geometry = SCNPlane(width: 1, height: 0.8)
        node.geometry?.firstMaterial?.diffuse.contents = theWebView
        //node.geometry?.firstMaterial?.isDoubleSided = true
        node.position = SCNVector3(0.1, 0.2, -2)
        
        self.sceneView.scene.rootNode.addChildNode(node)
         
    }
    
}

extension JoeAR8VC: ARSCNViewDelegate, WKNavigationDelegate{

    // WKWebView delegate method
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // Page should be loaded by now. However sometimes it took even more to load, so you can use delay and wait more, then take the screenshot.
        
        sleep(5)
        
        let screenshot = webView.screenshot()
        
        let node = SCNNode()
        node.geometry = SCNPlane(width: 3, height: 2)
        node.geometry?.firstMaterial?.diffuse.contents = screenshot
        node.geometry?.firstMaterial?.isDoubleSided = true
        node.position = SCNVector3(0.1, 0.2, -1)
        
        self.sceneView.scene.rootNode.addChildNode(node)

        
    }
}

extension WKWebView {
    func screenshot() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, true, 0);
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: true);
        let snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return snapshotImage;
    }
}
