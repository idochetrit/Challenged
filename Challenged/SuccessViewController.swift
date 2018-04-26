//
//  SuccessViewController.swift
//  Challenged
//
//  Created by Ido Chetrit on 26/04/2018.
//  Copyright © 2018 hackidc66. All rights reserved.
//

import UIKit

class SuccessViewController: UIViewController {

  
  
  @IBOutlet weak var secondView: UIView!

  @IBOutlet weak var prizeImage: UIImageView!
  @IBOutlet weak var logoImage: UIImageView!

  @IBAction func playAgain(_ sender: Any) {
    //IDO'S CODE - Play again
  }
  @IBAction func moreChallenges(_ sender: Any) {
    
  }
  
  override func viewDidLoad() {
        super.viewDidLoad()
    
    self.hero.isEnabled = true
    
    //Place all Info
    prizeImage?.image = UIImage(named:"20precent.png")
    logoImage?.image = UIImage(named:"icon_audi.png")
    
    //Backgrounds of 2 views
    self.view.backgroundColor = UIColor(patternImage: UIImage(named: "galaxy_bg.png")!)
    secondView.backgroundColor = UIColor(white: 0.9, alpha: 0.8)
    
    
  }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
