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

class GameViewController: UIViewController {

  // view components
  @IBOutlet var containerView: UIView!
  @IBOutlet weak var timerLabel: UILabel!
  @IBOutlet weak var hitCountLabel: UILabel!
  @IBOutlet var sceneView: ARSCNView!
  private var crosshairImageView: UIImageView?
  
  // models
  var gameInstance: ChallengeGame!
  var planeNodes: [Plane] = []
  var aliens: [Robot] = []
  
  // utils
  var robotsInterval: Timer!
  var player: AVAudioPlayer!
  var gameTime: TimeInterval!
  
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
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
  
  func setupWorld() {
    // Set the view's delegate
    sceneView.delegate = self
    
    // Show statistics such as fps and timing information, debuge options
//    sceneView.showsStatistics = true
//    sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, .showPhysicsShapes]
    
    // Set the scene to the view
    sceneView.scene = SCNScene()
    sceneView.scene.physicsWorld.contactDelegate = self

    configureLighting()
    // add robots timer
    if (robotsInterval == nil) {
      robotsInterval = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.addRobotInterval), userInfo: nil, repeats: true)
    }
    
    //start counter
    gameTime = 0.0
    
    setupHUD()
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
    
//    let lightNode = Sun()
//    self.sceneView.scene.rootNode.addChildNode(lightNode)
  }
  
  // MARK: - Actions
  
  @IBAction func didTapScreen(_ sender: UITapGestureRecognizer) {
    let bulletsNode = Bullet()
    
    let (dir, pos) = getUserVector()
    bulletsNode.position = pos
    
    //play sound
    DispatchQueue.main.async {
      self.playSoundEffect(ofType: .shoot)
    }
    
    let bulletVector = SCNVector3(dir.x * 1.8, dir.y * 1.8, dir.z * 1.8)
    bulletsNode.physicsBody?.applyForce(bulletVector, asImpulse: true)
    sceneView.scene.rootNode.addChildNode(bulletsNode)
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
      self.removeNodeWithAnimation(bulletsNode, explosion: false)
    })
  }
  
  func setupHUD() {
    timerLabel.layer.cornerRadius = 15
    hitCountLabel.layer.cornerRadius = 15
  }
  
  func updateHUDLabels() {
    DispatchQueue.main.async {
      let timeLeft = self.gameInstance.timeLimit - self.gameTime
      let secs = Int(timeLeft.truncatingRemainder(dividingBy: 60))
      let mins = Int(timeLeft / 60.0)

      // minutes:seconds format
      let minsStr = mins < 10 ? "0\(mins)" : String(mins)
      let secsStr = secs < 10 ? "0\(secs)" : String(secs)
      self.timerLabel.text = "\(minsStr):\(secsStr)"
      
      // update hitcount
      self.hitCountLabel.text =
      "\(self.gameInstance.targetsHits) \\ \(self.gameInstance.numOfTargets)"
    }
    
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
  case explosion = "splash"
  case shoot = "shoot"
}

