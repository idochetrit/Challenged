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
  var challengeInfo: ChallengeInfo!
  
  var panGR: UIPanGestureRecognizer!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = UIColor(patternImage: UIImage(named: "galaxy_bg.png")!)
    secondView.backgroundColor = UIColor(white: 0.9, alpha: 0.8)
    self.hero.isEnabled = true
    
    //Place all Info
    titleChallenge.text = challengeInfo.challengeName
    bigImage.image = challengeInfo.companyImage
    lognText.text = challengeInfo.longDescription
    prizeDescrip.text = challengeInfo.prizeDescription
    prizeImg.image = challengeInfo.prizeImage
    
    //Design
    //Long Text
    lognText.textAlignment = NSTextAlignment.left
    lognText.lineBreakMode = .byWordWrapping
    lognText.numberOfLines = 9
  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }
  
  @IBAction func back(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  /*
  // MARK: - Navigation

  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      // Get the new view controller using segue.destinationViewController.
      // Pass the selected object to the new view controller.
  }
  */

}
