//
//  Robot.swift
//  Challenged
//
//  Created by Ido Chetrit on 26/04/2018.
//  Copyright © 2018 hackidc66. All rights reserved.
//

import UIKit
import SceneKit

class Robot: SCNNode {
  var id: Int?
  var parentPlaneNode: Plane!
  var robot: SCNNode!
  static let BitMask = 0b0001

  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(id: Int) {
    super.init()
    self.id = id
    
    // add scene
    guard let robotScene = SCNScene(named: "art.scnassets/Robot2.scn")
      else { print("cant find scene"); return }

    for childNode in robotScene.rootNode.childNodes {
      self.addChildNode(childNode)
    }
    
    guard let rootRobot = self.childNode(withName: "Robot", recursively: true)
      else { print("cant find robot root node"); return }
    self.robot = rootRobot
    
    self.robot.castsShadow = true
    
    self.robot.scale = SCNVector3(0.05, 0.05, 0.05)
    
  }
  
  func setupPosition(node: Plane) {
    self.parentPlaneNode = node
    
    let index = id!
    let transform = SCNVector3.positionFromTransform(node.simdTransform)
    
    let toggled = index % 2 == 0
    let insertionYOffset : Float = 1.1
    let intervalXOffset =  min(Float(index) * (0.8), 5)
    let intervalZOffset =  min(Float(index) * (0.7), 3.4)
    print("Z offset: ", intervalZOffset, " + ")
    print("X offset: ", intervalXOffset, " -/+: ", toggled)
    
    let position = SCNVector3(
      transform.x + (toggled ? -intervalXOffset : intervalXOffset),
      transform.y - insertionYOffset,
      transform.z - 1.42 - intervalZOffset
    )
    
    robot.position = position
    robot.eulerAngles.y = -.pi/2
  }
  
  
}
