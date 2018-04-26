//
//  Sun.swift
//  Challenged
//
//  Created by Ido Chetrit on 26/04/2018.
//  Copyright © 2018 hackidc66. All rights reserved.
//

import UIKit
import SceneKit

class Sun: SCNNode {
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init() {
    super.init()

    // add scene
    let sunScene = SCNScene(named: "art.scnassets/Sun.scn")!
    guard let sunNode = sunScene.rootNode.childNode(withName: "Sun", recursively: true)
      else { print("cant find scene"); return }
    guard let ambientNode = sunScene.rootNode.childNode(withName: "ambient", recursively: true)
      else { print("cant find scene"); return }
    
    addChildNode(ambientNode)
//    sunNode.position = SCNVector3(0, -19.4, 5)
    addChildNode(sunNode)
  }

}
