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
  
  var targetsHit: Int!
  var startedAt: Date!
  
  
  init(_  info: ChallengeInfo) {
    self.id = info.gameID
    
    var myDict: NSDictionary?
    if let path = Bundle.main.path(forResource: "Game\\ Models/Challenges", ofType: "plist") {
      myDict = NSDictionary(contentsOfFile: path)
    }
    if let dict = myDict {
      dict[String(id)]
    }
    self.timeLimit = 60.0
    self.numberOfTargets = 2
    self.info = info
    startedAt = Date.init()
    super.init()
  }
  
  func name() -> String {
    return info.challengeName
  }
  
  func isEnded() -> Bool {
    let timeDiff: TimeInterval =  Date.init().timeIntervalSince(startedAt)
    return targetsHit >= numberOfTargets || timeDiff >= timeLimit
  }
  
  func pushFinishScreen(source: UIViewController) {
//    source.present(FinishViewController, animated: true, completion: nil)
  }
  
}
