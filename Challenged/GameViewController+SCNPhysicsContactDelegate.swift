//
//  GameViewController+SCNPhysicsContactDelegate.swift
//  Challenged
//
//  Created by Ido Chetrit on 26/04/2018.
//  Copyright © 2018 hackidc66. All rights reserved.
//

import UIKit
import SceneKit

extension GameViewController: SCNPhysicsContactDelegate {
  
  // MARK: - Contact Delegate
  func physicsWorld(_ world: SCNPhysicsWorld, didEnd contact: SCNPhysicsContact) {
    print("did begin contact", contact.nodeA.physicsBody!.categoryBitMask,
          contact.nodeB.physicsBody!.categoryBitMask)
    
    print("Hit robot!")
    
    var collisionBoxNode: SCNNode!
    if contact.nodeA.physicsBody?.categoryBitMask == Bullet.BitMask {
      collisionBoxNode = contact.nodeB
    } else {
      collisionBoxNode = contact.nodeA
    }
    var contactNode: SCNNode!
    if contact.nodeA.physicsBody?.categoryBitMask == Robot.BitMask {
      contactNode = contact.nodeB
    } else {
      contactNode = contact.nodeA
    }
    
    // update game
    gameInstance.hit()
    
    // play sounds effect
    DispatchQueue.main.async {
      self.playSoundEffect(ofType: .explosion)
    }
    
    // remove the bullet
    self.removeNodeWithAnimation(collisionBoxNode, explosion: false)
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
      // // remove/replace robot after half a second to visualize collision
      self.removeNodeWithAnimation(contactNode, explosion: true)
    })
  }
  
  
  func removeNodeWithAnimation(_ node: SCNNode, explosion: Bool) {
    // Play collision sound for all collisions (bullet-bullet, etc.)
    
    if explosion {
      let particleSystem = SCNParticleSystem(named: "explosion", inDirectory: "art.scnassets")
      let systemNode = SCNNode()
      systemNode.addParticleSystem(particleSystem!)
      // place explosion where node is
      if let robotNode = node as? Robot {
        systemNode.position = robotNode.robot.position
        sceneView.scene.rootNode.addChildNode(systemNode)
      }
    }
    
    // remove node
    node.removeFromParentNode()
  }
  
}
