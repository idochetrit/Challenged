//
//  Alien.swift
//  EnigmaAR
//
//  Created by Ido Chetrit on 14/04/2018.
//  Copyright © 2018 Ido Chetrit. All rights reserved.
//

import UIKit
import SceneKit

class Robot: SCNNode {
  var id: Int?
  var parentPlaneNode: Plane!
  static let BitMask = 0b0001

  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(id: Int) {
    super.init()
    self.id = id
    
    // add scene
    let alienScene = SCNScene(named: "art.scnassets/Robot.scn")!
    guard let rootAlienNode = alienScene.rootNode.childNode(withName: "Robot", recursively: true)
      else { print("cant find scene"); return }
    let alienNodes: [SCNNode] = rootAlienNode.childNodes

    for childNode in alienNodes {
      self.addChildNode(childNode)
    }
    
    
//    let w = CGFloat(2.0)
//    let h = CGFloat(4.277)
//    let l =  CGFloat(2.387)
//    let box = SCNBox(width: w, height: h, length: l, chamferRadius: 0)
//    let clear =  SCNMaterial()
//    clear.transparency = 0.5
//    clear.diffuse.contents = UIColor.lightGray
//    box.materials = [clear]
//    self.geometry = box
//    let shape = SCNPhysicsShape(geometry: box, options: nil)
//    self.geometry = rootAlienNode.geometry
//    let shape = SCNPhysicsShape(node: rootAlienNode,
//                                options: [SCNPhysicsShape.Option.type: SCNPhysicsShape.ShapeType.boundingBox])
//    let alienShape = rootAlienNode.physicsBody?.physicsShape
//    self.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
    self.physicsBody?.isAffectedByGravity = false
    self.physicsBody?.contactTestBitMask = Bullet.BitMask
    self.physicsBody?.categoryBitMask = Robot.BitMask
    
    self.castsShadow = true
    
    self.scale = SCNVector3(0.02, 0.02, 0.02)
  }
  
  func setupPosition(node: Plane) {
    self.parentPlaneNode = node
    
    let index = id!
    let transform = SCNVector3.positionFromTransform(node.simdTransform)
    
    let toggled = index % 2 == 0
    let insertionYOffset : Float = 0.5
    let intervalXOffset =  min(Float(index) * (0.4), 2)
    let intervalZOffset =  min(Float(index) * (0.4), 2)
    print("Z offset: ", intervalZOffset, " -/+: ", toggled)
    print("X offset: ", intervalXOffset, " -/+: ", toggled)
    
    let position = SCNVector3(
      transform.x + (toggled ? -intervalXOffset : intervalXOffset),
      transform.y - insertionYOffset,
      transform.z - 0.22 + (toggled ? -intervalZOffset : intervalZOffset)
    )
    
    self.position = position
    self.eulerAngles.z = -.pi / 2
  }
  
  
}
