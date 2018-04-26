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
  let numberOfTargets: Int
  let timeLimit: TimeInterval
  let info: ChallengeInfo!
  
  var targetsHit: Int = 0
  var startedAt: Date!
  
  
  init(_  info: ChallengeInfo) {
    self.id = info.gameID

    // default attrs
    self.timeLimit = 60.0
    self.numberOfTargets = 5
    
    if let path = Bundle.main.path(forResource: "Challenges", ofType: "plist"),
      let dict = NSDictionary(contentsOfFile: path),
      let metadata = dict.object(forKey: String(id)) as? NSDictionary {
        metadata.object(forKey: "numberOfTargets")
    }
  
    self.info = info
    startedAt = Date.init()
    super.init()
  }
  
  func name() -> String {
    return info.challengeName
  }
  
  func hit()  {
    self.targetsHit += 1
  }
  
  func isEnded() -> Bool {
    let timeDiff: TimeInterval =  Date.init().timeIntervalSince(startedAt)
    return targetsHit >= numberOfTargets || timeDiff >= timeLimit
  }
  
  func pushFinishScreen(source: UIViewController) {
//    source.present(FinishViewController, animated: true, completion: nil)
  }
  
}
