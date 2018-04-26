//
//  ViewController.swift
//  Challenged
//
//  Created by Ido Chetrit on 26/04/2018.
//  Copyright © 2018 hackidc66. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class GameViewController: UIViewController, SCNPhysicsContactDelegate {

  @IBOutlet var sceneView: ARSCNView!
  
  // models
  var planeNodes: [Plane] = []
  var player: AVAudioPlayer!
  var aliens: [Robot] = []
  
  // utils
  var timer: Timer!
  
  override func viewDidLoad() {
    super.viewDidLoad()

    setupWorld()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    configureSession()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    sceneView.session.pause()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  
  func setupWorld() {
    // Set the view's delegate
    sceneView.delegate = self
    
    // Show statistics such as fps and timing information, debuge options
    sceneView.showsStatistics = true
    sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, .showPhysicsShapes]
    
    // Set the scene to the view
    sceneView.scene = SCNScene()
    sceneView.scene.physicsWorld.contactDelegate = self
    
    configureLighting()
    // add aliens timer
    if (timer == nil) {
      timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.addAlienTimed), userInfo: nil, repeats: true)
    }
  }
  
  func configureSession() {
    let configuration = ARWorldTrackingConfiguration()
    configuration.planeDetection = .horizontal
    configuration.isLightEstimationEnabled = true
    
    // Run the view's session
    sceneView.session.run(configuration)
  }
  
  func configureLighting() {
    sceneView.autoenablesDefaultLighting = false
    sceneView.automaticallyUpdatesLighting = true
    
    let lightNode = Sun()
    self.sceneView.scene.rootNode.addChildNode(lightNode)
  }
  
  // MARK: - Actions
  
  @IBAction func didTapScreen(_ sender: UITapGestureRecognizer) {
    let bulletsNode = Bullet()
    
    let (dir, pos) = getUserVector()
    bulletsNode.position = pos
    
    let bulletVector = SCNVector3(dir.x * 3.5, dir.y * 3.5, dir.z * 3.5)
    bulletsNode.physicsBody?.applyForce(bulletVector, asImpulse: true)
    sceneView.scene.rootNode.addChildNode(bulletsNode)
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
      self.removeNodeWithAnimation(bulletsNode, explosion: false)
    })
  }

  func removeNodeWithAnimation(_ node: SCNNode, explosion: Bool) {
    // Play collision sound for all collisions (bullet-bullet, etc.)
    
    if explosion {
      DispatchQueue.main.async {
        self.playSoundEffect(ofType: .explosion)
      }
      
      let particleSystem = SCNParticleSystem(named: "explosion", inDirectory: "art.scnassets")
      let systemNode = SCNNode()
      systemNode.addParticleSystem(particleSystem!)
      // place explosion where node is
      systemNode.position = node.position
      sceneView.scene.rootNode.addChildNode(systemNode)
    }
    
    // remove node
    node.removeFromParentNode()
  }
  
  
  // MARK: - Contact Delegate
  
  func physicsWorld(_ world: SCNPhysicsWorld, didEnd contact: SCNPhysicsContact) {
    print("did begin contact", contact.nodeA.physicsBody!.categoryBitMask,
          contact.nodeB.physicsBody!.categoryBitMask)
    
    print("Hit alien!")
    
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
    
    // remove the bullet
    self.removeNodeWithAnimation(collisionBoxNode, explosion: false)
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
      // // remove/replace ship after half a second to visualize collision
      self.removeNodeWithAnimation(contactNode, explosion: true)
    })
  }
  
  // MARK: - Sound Effects
  
  func playSoundEffect(ofType effect: SoundEffect) {
    
    // Async to avoid substantial cost to graphics processing (may result in sound effect delay however)
    DispatchQueue.main.async {
      do
      {
        if let effectURL = Bundle.main.url(forResource: effect.rawValue, withExtension: "mp3") {
          
          self.player = try AVAudioPlayer(contentsOf: effectURL)
          self.player.play()
          
        }
      }
      catch let error as NSError {
        print(error.description)
      }
    }
  }
}


enum SoundEffect: String {
  case explosion = "explosion"
}
