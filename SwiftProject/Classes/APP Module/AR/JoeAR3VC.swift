//
//  JoeAR3VC.swift
//  SwiftProject
//
//  Created by Archimboldi on 2018/7/30.
//  Copyright © 2018年 KJ. All rights reserved.
//

import UIKit
import ARKit

class JoeAR3VC: JoeViewController {
    
    
    let rocketshipNodeName = "rocketship"
    
    var planeNodes = [SCNNode]()
    
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

        addTapGestureToSceneView()
        
        setUpSceneView()
        
        configureLighting()
        // Do any additional setup after loading the view.
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
 
    func addTapGestureToSceneView() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(JoeAR3VC.addRocketshipToSceneView(withGestureRecognizer:)))
        sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func addSwipeGesturesToSceneView() {
        let swipeUpGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(JoeAR3VC.applyForceToRocketship(withGestureRecognizer:)))
        swipeUpGestureRecognizer.direction = .up
        sceneView.addGestureRecognizer(swipeUpGestureRecognizer)
        
        let swipeDownGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(JoeAR3VC.launchRocketship(withGestureRecognizer:)))
        swipeDownGestureRecognizer.direction = .down
        sceneView.addGestureRecognizer(swipeDownGestureRecognizer)
    }
    
    @objc func addRocketshipToSceneView(withGestureRecognizer recognizer: UIGestureRecognizer) {
        let tapLocation = recognizer.location(in: sceneView)
        let hitTestResults = sceneView.hitTest(tapLocation, types: .existingPlaneUsingExtent)
        guard let hitTestResult = hitTestResults.first else { return }
        
        let translation = hitTestResult.worldTransform.translation
        let x = translation.x
        let y = translation.y + 0.1
        let z = translation.z
        
        guard let rocketshipScene = SCNScene(named: "rocketship.scn"),
            let rocketshipNode = rocketshipScene.rootNode.childNode(withName: "rocketship", recursively: false)
            else { return }
        
        rocketshipNode.position = SCNVector3(x,y,z)
        
        // TODO: Attach physics body to rocketship node
        let physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        rocketshipNode.physicsBody = physicsBody
        rocketshipNode.name = rocketshipNodeName
        
        sceneView.scene.rootNode.addChildNode(rocketshipNode)
    }
    
    func getRocketshipNode(from swipeLocation: CGPoint) -> SCNNode? {
        let hitTestResults = sceneView.hitTest(swipeLocation)
        
        guard let parentNode = hitTestResults.first?.node.parent,
            parentNode.name == rocketshipNodeName
            else { return nil }
        
        return parentNode
    }
  
    // TODO: Create apply force to rocketship method
    @objc func applyForceToRocketship(withGestureRecognizer recognizer: UIGestureRecognizer) {
        // 1 确认滑动手势状态为已结束。
        guard recognizer.state == .ended else { return }
        // 2 从滑动位置获取hit test results。
        let swipeLocation = recognizer.location(in: sceneView)
        // 3 查看滑动手势是否在火箭飞船上执行过。
        guard let rocketshipNode = getRocketshipNode(from: swipeLocation),
            let physicsBody = rocketshipNode.physicsBody
            else { return }
        // 4 我们将y 方向的力施加到父节点(parent node) 的physics body。如果你有注意到，我们也把冲力的参数设置为true，这施用于冲力的瞬时变化，来立即加速physics body。基本上，这个选项可以在设置为true 时，模拟物体发射时的瞬间效果。
        let direction = SCNVector3(0, 3, 0)
        physicsBody.applyForce(direction, asImpulse: true)
    }
    
    @objc func launchRocketship(withGestureRecognizer recognizer: UIGestureRecognizer) {
        // 1 確保滑動手勢狀態已結束。
        guard recognizer.state == .ended else { return }
        // 2 像剛才一樣安全地解包 (unwrapped) rocketshipNode 及 physicsBody。此外，也安全解包 reactorParticleSystem 和 engineNode。希望將 reactorParticleSystem 添加到飛船的引擎上
        let swipeLocation = recognizer.location(in: sceneView)
        guard let rocketshipNode = getRocketshipNode(from: swipeLocation),
            let physicsBody = rocketshipNode.physicsBody,
            let reactorParticleSystem = SCNParticleSystem(named: "reactor", inDirectory: nil),
            let engineNode = rocketshipNode.childNode(withName: "node2", recursively: false)
            else { return }
        // 3 將 physics body *受重力影響*的屬性設置為 false。重力不會再影響飛船節點，我們還將阻尼 (damping) 屬性設置為零，阻尼屬性模擬流體摩擦或空氣阻力對 body 的影響，將其設置為零，就可以將導致火箭節點的 physics body 上流體摩擦或空氣阻力的影響零。
        physicsBody.isAffectedByGravity = false
        physicsBody.damping = 0
        // 4 將 planeNodes 設置為 reactorParticleSystem 的 colliderNodes。這將使粒子系統中的粒子在接觸時從檢測平面反彈，而不是直接飛行穿過它們。
        reactorParticleSystem.colliderNodes = planeNodes
        // 5 將 reactorParticleSystem 添加到 engineNode 上。
        engineNode.addParticleSystem(reactorParticleSystem)
        // 6 我們將火箭節點向上移動了 0.3 米，並且選擇 easeInEaseOut 動畫效果。
        let action = SCNAction.moveBy(x: 0, y: 0.3, z: 0, duration: 3)
        action.timingMode = .easeInEaseOut
        rocketshipNode.runAction(action)
    }
}


extension JoeAR3VC: ARSCNViewDelegate {
    
    //在这个方法中，我们创建了一个SCNPhysicsShape物件。一个SCNPhysicsShape物件代表physics body的形状，当SceneKit检测到你场景的SCNPhysicsBody物件连结时，它会使用你定义的physics shapes，而不是rendered geometry的可见(visible)物件。
    func update(_ node: inout SCNNode, withGeometry geometry: SCNGeometry, type: SCNPhysicsBodyType) {
        
    let shape = SCNPhysicsShape(geometry: geometry, options: nil)
    let physicsBody = SCNPhysicsBody(type: type, shape: shape)
    node.physicsBody = physicsBody
        
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        
        let width = CGFloat(planeAnchor.extent.x)
        let height = CGFloat(planeAnchor.extent.z)
        let plane = SCNPlane(width: width, height: height)
        
        plane.materials.first?.diffuse.contents = UIColor(red:0.25, green:0.62, blue:0.98, alpha:0.60)
        
        var planeNode = SCNNode(geometry: plane)
        
        let x = CGFloat(planeAnchor.center.x)
        let y = CGFloat(planeAnchor.center.y)
        let z = CGFloat(planeAnchor.center.z)
        planeNode.position = SCNVector3(x,y,z)
        planeNode.eulerAngles.x = -.pi / 2
        
        update(&planeNode, withGeometry: plane, type: .static)
        //地板、墙壁和地形等类型的SceneKit 物件适合使用静态physics body type。静态类型不受力或碰撞影响，不能移动。
        
        node.addChildNode(planeNode)
        
        planeNodes.append(planeNode)
    }
    
    //当对应于一个已被移除ARAnchor 的SceneKit node 从场景中被删除时，就调用这个委托方法。这此同时，我们会在planeNodes 阵列中过滤已被移除的plane node。
    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        guard anchor is ARPlaneAnchor,
        let planeNode = node.childNodes.first
        else { return }
        planeNodes = planeNodes.filter { $0 != planeNode }
    }

    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as?  ARPlaneAnchor,
            var planeNode = node.childNodes.first,
            let plane = planeNode.geometry as? SCNPlane
            else { return }
        
        let width = CGFloat(planeAnchor.extent.x)
        let height = CGFloat(planeAnchor.extent.z)
        plane.width = width
        plane.height = height
        
        let x = CGFloat(planeAnchor.center.x)
        let y = CGFloat(planeAnchor.center.y)
        let z = CGFloat(planeAnchor.center.z)
        
        planeNode.position = SCNVector3(x, y, z)
        
        update(&planeNode, withGeometry: plane, type: .static)
    }
}
