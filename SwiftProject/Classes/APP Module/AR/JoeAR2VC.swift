//
//  JoeAR2VC.swift
//  SwiftProject
//
//  Created by Archimboldi on 2018/7/30.
//  Copyright © 2018年 KJ. All rights reserved.
//

import UIKit
import ARKit

class JoeAR2VC: JoeViewController {

    let sceneView = ARSCNView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
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
        setUpSceneView()
        
        addTapGestureToSceneView()
        
        configureLighting()
    }

    func setUpSceneView() {
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal //.vertical (*11.3)
        sceneView.session.run(configuration)
        
        sceneView.delegate = self
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
    }
    
    func configureLighting() {
        sceneView.autoenablesDefaultLighting = true
        sceneView.automaticallyUpdatesLighting = true
    }
    
    @objc func addShipToSceneView(withGestureRecognizer recognizer: UIGestureRecognizer) {
        let tapLocation = recognizer.location(in: sceneView)
        let hitTestResults = sceneView.hitTest(tapLocation, types: .existingPlaneUsingExtent)
        //.existingPlaneUsingExtent 唯一的不同在我們在 types 傳送了不一樣的參數來偵測 sceneView 中已經存在的平面錨點。
        
        guard let hitTestResult = hitTestResults.first else { return }
        let translation = hitTestResult.worldTransform.translation
        let x = translation.x
        let y = translation.y
        let z = translation.z
        
        guard let shipScene = SCNScene(named: "ship.scn"),
            let shipNode = shipScene.rootNode.childNode(withName: "ship", recursively: false)
            else { return }
        
        
        shipNode.position = SCNVector3(x,y,z)
        sceneView.scene.rootNode.addChildNode(shipNode)
    }
    
    func addTapGestureToSceneView() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(JoeAR2VC.addShipToSceneView(withGestureRecognizer:)))
        sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
 
}

extension JoeAR2VC: ARSCNViewDelegate {
    
    //這個 Protocol 方法會在每次有 ARAnchor 被加進 sceneView 的 Session 時被呼叫。
    //一個 ARAnchor 物件代表著 3D 空間中一個物理上的位置及方向。我們會在稍後使用 ARAnchor 來偵測水平面。
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        // 1
        //我們將視為 ARPlaneAnchor 的 anchor 參數安全解包（unwrap）以確認我們有關於現實世界平面的資訊
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        
        // 2
        //在這邊，我們建立一個 SCNPlane 來視覺化 ARPlaneAnchor。SCNPlane 是一個單面的平面幾何矩形。我們拿解包的 ARPlaneAnchor 裡的 Extent 中的 X 及 Y 屬性來建立一個 SCNPlane。ARPlaneAnchor Extent 是指被偵測到的平面的估計大小。我們取 Extent 的 X 及 Y 來做為 SCNPlane 的高與寬。接著我們給這個平面上一層亮藍色來模擬水的樣子。
        let width = CGFloat(planeAnchor.extent.x)
        let height = CGFloat(planeAnchor.extent.z)
        let plane = SCNPlane(width: width, height: height)
        
        // 3
        //我們用我們剛建立好的 SCNPlane 幾何形來初始化 SCNNode
        plane.materials.first?.diffuse.contents = UIColor(red:0.25, green:0.62, blue:0.98, alpha:0.60)
        //plane.materials.first?.diffuse.contents = UIImage(named: "girl")
        
        // 4
        //我們初始化 x、y 以及 z 常數來表示 planeAnchor 中心的 X、Y、Z 座標。這是為了 planeNode 的座標位置。我們逆時針旋轉 planeNode 的 X尤拉角 90 度，否則 planeNode 會垂直立於桌上。如果是順時針旋轉，就會變成魔術般的錯覺畫面了，因為 SceneKit 預設使用一側的材質來渲染 SCNPlane 。
        let planeNode = SCNNode(geometry: plane)
        
        // 5
        //最後，我們將 planeNode 作為子節點放入至新增加的 SceneKit 節點上
        let x = CGFloat(planeAnchor.center.x)
        let y = CGFloat(planeAnchor.center.y)
        let z = CGFloat(planeAnchor.center.z)
        planeNode.position = SCNVector3(x,y,z)
        planeNode.eulerAngles.x = -.pi / 2
        
        // 6
        
        node.addChildNode(planeNode)
    }
    
    // 擴展水平面, 這個方法會在更新 SceneKit 節點的屬性好對應相對應的錨點時被呼叫。這可以讓 ARKit 改善對水平面位置及範圍的估算。
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
    
        // 1
        //我們將視為 ARPlaneAnchor 的 anchor 參數安全解包。接下來，將 node 的第一個子節點也安全解包。最後，我們也將視為 SCNPlane 的 planeNode 幾何形安全解包。我們只取出先前實作的 ARPlaneAnchor、SCNNode、SCNplane 以及使用相對應的參數更新屬性。
        guard let planeAnchor = anchor as?  ARPlaneAnchor,
            let planeNode = node.childNodes.first,
            let plane = planeNode.geometry as? SCNPlane
            else { return }
        
        // 2
        //這裡我們用 planeAnchor 範圍的 x 及 z 屬性來更新 plane 的寬高。
        let width = CGFloat(planeAnchor.extent.x)
        let height = CGFloat(planeAnchor.extent.z)
        plane.width = width
        plane.height = height
        
        // 3
        //最後，我們將 planeNode 的座標位置更新為 planeAnchor 中心點的 x、y、z 座標
        let x = CGFloat(planeAnchor.center.x)
        let y = CGFloat(planeAnchor.center.y)
        let z = CGFloat(planeAnchor.center.z)
        planeNode.position = SCNVector3(x, y, z)
    }
    
}
