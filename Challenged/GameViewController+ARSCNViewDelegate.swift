//
//  GameViewController+ARSCNViewDelegate.swift
//  Challenged
//
//  Created by Ido Chetrit on 26/04/2018.
//  Copyright © 2018 hackidc66. All rights reserved.
//

import UIKit
import ARKit
import SceneKit

extension GameViewController: ARSCNViewDelegate {
  // adds planes
  func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
    guard let planeAnchor = anchor as? ARPlaneAnchor
      else { return }
    
    let planeNode = Plane(planeAnchor, hidden: false)
    node.addChildNode(planeNode)
    planeNodes.append(planeNode)
  }
  
  // updates planes
  func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
    guard let planeAnchor = anchor as? ARPlaneAnchor,
      let planeNode = node as? Plane
      else { return }
    
    planeNode.update(planeAnchor)
  }
  
  
  func addAlienNode(planeNode: Plane, index: Int) {
    let alienNode = Robot(id: index)
    
    alienNode.setupPosition(node: planeNode)
    print("Alien pos. ", alienNode.position)
    print("Plane Node pos. ", planeNode.position)
    
    sceneView.scene.rootNode.addChildNode(alienNode)
    aliens.append(alienNode)
  }
  
  @objc func addAlienTimed() {
    // choose plane node
    if (self.aliens.count < 10 && self.planeNodes.count > 0) {
      guard let node = self.planeNodes.randomItem()
        else {return}
      DispatchQueue.main.async {
        self.addAlienNode(planeNode: node, index: self.aliens.count)
      }
    }
  }
  
  func getUserVector() -> (SCNVector3, SCNVector3) { // (direction, position)
    if let frame = self.sceneView.session.currentFrame {
      let mat = SCNMatrix4(frame.camera.transform) // 4x4 transform matrix describing camera in world space
      let dir = SCNVector3(-1 * mat.m31, -1 * mat.m32, -1 * mat.m33) // orientation of camera in world space
      let pos = SCNVector3(mat.m41, mat.m42, mat.m43) // location of camera in world space
      
      return (dir, pos)
    }
    return (SCNVector3(0, 0, -1), SCNVector3(0, 0, -0.2))
  }
}