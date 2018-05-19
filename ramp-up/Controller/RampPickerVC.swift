//
//  RampPickerVC.swift
//  ramp-up
//
//  Created by Koki Tabayashi on 2018/05/18.
//  Copyright © 2018年 Koki Tabayashi. All rights reserved.
//

import UIKit
import SceneKit

class RampPickerVC: UIViewController {

    var sceneView: SCNView!
    var size: CGSize!
    weak var rampPlacerVC: RampPlacerVC!
    
    init(size: CGSize) {
        super.init(nibName: nil, bundle: nil)
        self.size = size
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.frame = CGRect(origin: CGPoint.zero, size: size)
        sceneView = SCNView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        view.insertSubview(sceneView, at: 0)
        
        preferredContentSize = size
        
        let scene = SCNScene(named: "art.scnassets/ramps.scn")!
        sceneView.scene = scene
        
        let camera = SCNCamera()
        camera.usesOrthographicProjection = true
        scene.rootNode.camera = camera
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        sceneView.addGestureRecognizer(tap)
        
        let pipe = Ramp.getPipe()
        Ramp.startRotation(node: pipe, duration: 0.05)
        scene.rootNode.addChildNode(pipe)
        
        let pyramid = Ramp.getPyramid()
        Ramp.startRotation(node: pyramid, duration: 0.06)
        scene.rootNode.addChildNode(pyramid)
        
        let quarter = Ramp.getQuarter()
        Ramp.startRotation(node: quarter, duration: 0.07)
        scene.rootNode.addChildNode(quarter)
        
        
//        var rotate = SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: CGFloat(0.01 * Double.pi), z: 0, duration: 0.05))
//
//        var obj = SCNScene(named: "art.scnassets/pipe.dae")
//        var node = obj?.rootNode.childNode(withName: "pipe", recursively: true)!
//        node?.runAction(rotate)
//        node?.scale = SCNVector3Make(0.0022, 0.0022, 0.0022)
//        node?.position = SCNVector3Make(-0.95, 0.8, -1)
//        scene.rootNode.addChildNode(node!)
//
//        rotate = SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: CGFloat(0.01 * Double.pi), z: 0, duration: 0.06))
//
//        obj = SCNScene(named: "art.scnassets/pyramid.dae")
//        node = obj?.rootNode.childNode(withName: "pyramid", recursively: true)!
//        node?.runAction(rotate)
//        node?.scale = SCNVector3Make(0.0058, 0.0058, 0.0058)
//        node?.position = SCNVector3Make(-0.95, 0, -1)
//        scene.rootNode.addChildNode(node!)
//
//        rotate = SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: CGFloat(0.01 * Double.pi), z: 0, duration: 0.07))
//
//        obj = SCNScene(named: "art.scnassets/quarter.dae")
//        node = obj?.rootNode.childNode(withName: "quarter", recursively: true)!
//        node?.runAction(rotate)
//        node?.scale = SCNVector3Make(0.0058, 0.0058, 0.0058)
//        node?.position = SCNVector3Make(-0.95, -1.4, -1)
//        scene.rootNode.addChildNode(node!)
        
    }
    
    @objc func handleTap(_ gestureRecognizer: UIGestureRecognizer) {
        let p = gestureRecognizer.location(in: sceneView)
        let hitResults = sceneView.hitTest(p, options: [:])
        
        if hitResults.count > 0 {
            let node = hitResults[0].node
            rampPlacerVC.onRampSelected(node.name!)
        }
    }
    

}
