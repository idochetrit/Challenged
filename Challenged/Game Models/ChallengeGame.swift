//
//  ChallengeGame.swift
//  Challenged
//
//  Created by Ido Chetrit on 26/04/2018.
//  Copyright © 2018 hackidc66. All rights reserved.
//

import UIKit

class ChallengeGame: NSObject {
  
  let id: Int
  var numOfTargets: Int
  var timeLimit: TimeInterval
  let info: ChallengeInfo!
  
  var plistData: [String: AnyObject] = [:] //Our data
  var targetsHits: Int = 0
  var startedAt: Date!
  
  
  init(_  info: ChallengeInfo) {
    
    self.id = info.gameID
    
    // default attrs
    self.timeLimit = 60.0
    self.numOfTargets = 5
    
    
    
//    var myDict: NSDictionary?
//    if let path = Bundle.main.path(forResource: "Challenges", ofType: "plist") {
//      myDict = NSDictionary(contentsOfFile: path)
//    }
//    if let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
//      let dict = NSDictionary(contentsOfFile: path) as? [String: AnyObject] {
//       use swift dictionary as normal

      

    if let path = Bundle.main.path(forResource: "Challenges", ofType: "plist"),
      let arr = NSArray(contentsOfFile: path),
      let metadata = arr[id] as? NSDictionary {
        metadata.object(forKey: "numOfTargets")
      
      // Use your dict here
      timeLimit = Double(metadata.object(forKey: "timeLimit") as! String)!
      numOfTargets = Int(metadata.object(forKey: "numOfTargets") as! String)!
      
    }
  


    
    self.info = info
    startedAt = Date.init()
    
    super.init()
  }
  

  
  func name() -> String {
    return info.challengeName
  }
  
  func hit()  {
    self.targetsHits += 1
  }
  
  func isEnded() -> Bool {
    let timeDiff: TimeInterval =  Date.init().timeIntervalSince(startedAt)
    return targetsHits >= numberOfTargets || timeDiff >= timeLimit
  }
  
  func pushFinishScreen(source: UIViewController) {
    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
    let viewController = storyboard.instantiateViewController(withIdentifier: "successView") as! SuccessViewController
    source.present(viewController, animated: false, completion: nil)
  }
  
}
