//
//  ChallengeInfoViewController.swift
//  EnigmaAR
//
//  Created by Ido Chetrit on 24/04/2018.
//  Copyright © 2018 Ido Chetrit. All rights reserved.
//

import UIKit
import Hero

class ChallengeInfoViewController: UIViewController {
  


  @IBOutlet weak var titleChallenge: UILabel!
  @IBOutlet weak var bigImage: UIImageView!
  @IBOutlet weak var lognText: UILabel!
  @IBOutlet weak var prizeDescrip: UILabel!
  @IBOutlet weak var prizeImg: UIImageView!
  @IBOutlet weak var secondView: UIView!
  @IBOutlet weak var playBut: UIButton!
  
  var challengeInfo: ChallengeInfo!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = UIColor(patternImage: UIImage(named: "galaxy_bg.png")!)
    secondView.backgroundColor = UIColor(white: 1, alpha: 1)
    secondView.layer.opacity = 1
    
    // border radius
    secondView.layer.cornerRadius = 15.0
    // border
    secondView.layer.borderColor = UIColor.lightGray.cgColor
    secondView.layer.borderWidth = 3
    // drop shadow
    secondView.layer.shadowColor = UIColor.black.cgColor
    secondView.layer.shadowRadius = 3.0
    secondView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
    
    self.hero.isEnabled = true
    
    //Place all Info
    titleChallenge?.text = challengeInfo.challengeName
    bigImage?.image = challengeInfo.companyImage
    lognText?.text = challengeInfo.longDescription
    prizeDescrip?.text = challengeInfo.prizeDescription
    prizeImg?.image = challengeInfo.prizeImage
    
    //Design
    //Button
    playBut.layer.cornerRadius = 15
    playBut.layer.shadowRadius = 3.0
    playBut.layer.shadowOpacity = 1.0
    playBut.layer.shadowOffset = CGSize(width: 2, height: 2)
    
    //Long Text
    lognText.textAlignment = .left
    lognText.lineBreakMode = .byWordWrapping
    lognText.numberOfLines = 9
    
    titleChallenge.numberOfLines = 2
    prizeDescrip.numberOfLines = 2
  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }
  
  @IBAction func back(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "startGame" {
      guard let destinationVC = segue.destination as? GameViewController
        else {return}
      destinationVC.gameInstance = ChallengeGame.init(challengeInfo)
    }
  }

}
