//
//  MainViewController.swift
//  Challenged
//
//  Created by Ido Chetrit on 26/04/2018.
//  Copyright © 2018 hackidc66. All rights reserved.
//

import UIKit
import FSPagerView
import Hero

class MainViewController: UIViewController, FSPagerViewDataSource, FSPagerViewDelegate {
  
  var infos: [ChallengeInfo] = []
  
  @IBOutlet weak var FSPagerChallenges: FSPagerView!{
    didSet{
      self.FSPagerChallenges.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
      self.FSPagerChallenges.transformer = FSPagerViewTransformer(type: .ferrisWheel)
      self.FSPagerChallenges.itemSize = CGSize(width: 250, height: 250)
      FSPagerChallenges.isInfinite = true
    }
  }
  
  func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
    
    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
    let viewController = storyboard.instantiateViewController(withIdentifier: "challengeInfo") as! ChallengeInfoViewController
    
    viewController.hero.modalAnimationType = .zoom
    
    viewController.challengeInfo = infos[index]
    
    self.present(viewController, animated: true, completion: nil)
    
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    
    //All INFO
    infos = [ChallengeInfo(companyImage: #imageLiteral(resourceName: "icon_audi"), challengeName: "Audi", shortDescription: "A German car manufacturer", prizeImage: #imageLiteral(resourceName: "20precent"), longDescription: "Audiis a German automobile manufacturer that designs, engineers, produces, markets and distributes luxury vehicles. Audi is a member of the Volkswagen Group and has its roots at Ingolstadt, Bavaria, Germany. Audi-branded vehicles are produced in nine production facilities worldwide.", prizeDescription: "Get 20% OFF"),
             ChallengeInfo(companyImage: #imageLiteral(resourceName: "icon_audi"), challengeName: "Audi", shortDescription: "A German car manufacturer", prizeImage: #imageLiteral(resourceName: "20precent"), longDescription: "Audiis a German automobile manufacturer that designs, engineers, produces, markets and distributes luxury vehicles. Audi is a member of the Volkswagen Group and has its roots at Ingolstadt, Bavaria, Germany. Audi-branded vehicles are produced in nine production facilities worldwide.", prizeDescription: "Get 20% OFF"),
             ChallengeInfo(companyImage: #imageLiteral(resourceName: "icon_google"), challengeName: "Audi", shortDescription: "A German car manufacturer", prizeImage: #imageLiteral(resourceName: "20precent"), longDescription: "Audiis a German automobile manufacturer that designs, engineers, produces, markets and distributes luxury vehicles. Audi is a member of the Volkswagen Group and has its roots at Ingolstadt, Bavaria, Germany. Audi-branded vehicles are produced in nine production facilities worldwide.", prizeDescription: "Get 20% OFF"),
             ChallengeInfo(companyImage: #imageLiteral(resourceName: "icon_canada"), challengeName: "Audi", shortDescription: "A German car manufacturer", prizeImage: #imageLiteral(resourceName: "20precent"), longDescription: "Audiis a German automobile manufacturer that designs, engineers, produces, markets and distributes luxury vehicles. Audi is a member of the Volkswagen Group and has its roots at Ingolstadt, Bavaria, Germany. Audi-branded vehicles are produced in nine production facilities worldwide.", prizeDescription: "Get 20% OFF"),
             ChallengeInfo(companyImage: #imageLiteral(resourceName: "icon_intel"), challengeName: "Audi", shortDescription: "A German car manufacturer", prizeImage: #imageLiteral(resourceName: "20precent"), longDescription: "Audiis a German automobile manufacturer that designs, engineers, produces, markets and distributes luxury vehicles. Audi is a member of the Volkswagen Group and has its roots at Ingolstadt, Bavaria, Germany. Audi-branded vehicles are produced in nine production facilities worldwide.", prizeDescription: "Get 20% OFF"),
             ChallengeInfo(companyImage: #imageLiteral(resourceName: "icon_asana"), challengeName: "Audi", shortDescription: "A German car manufacturer", prizeImage: #imageLiteral(resourceName: "20precent"), longDescription: "Audiis a German automobile manufacturer that designs, engineers, produces, markets and distributes luxury vehicles. Audi is a member of the Volkswagen Group and has its roots at Ingolstadt, Bavaria, Germany. Audi-branded vehicles are produced in nine production facilities worldwide.", prizeDescription: "Get 20% OFF"),
             ChallengeInfo(companyImage: #imageLiteral(resourceName: "icon_canada"), challengeName: "Audi", shortDescription: "A German car manufacturer", prizeImage: #imageLiteral(resourceName: "20precent"), longDescription: "Audiis a German automobile manufacturer that designs, engineers, produces, markets and distributes luxury vehicles. Audi is a member of the Volkswagen Group and has its roots at Ingolstadt, Bavaria, Germany. Audi-branded vehicles are produced in nine production facilities worldwide.", prizeDescription: "Get 20% OFF")
    ]
  }

  
  // MARK: - FSPagerViewDelegate
  
  func numberOfItems(in pagerView: FSPagerView) -> Int {
     return infos.count
  }
  
  func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
    let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index) as! CollectionViewCell
    
    //cell design
    cell.layer.backgroundColor = UIColor(red: 0, green: 249, blue: 255, alpha: 1).cgColor
    
    
    let info = infos[index]
    cell.title.text = info.challengeName
    cell.bigImage.image = info.companyImage
    cell.descrip.text = info.prizeDescription
    cell.prizeImage.image = info.prizeImage
    
    
    return cell
  }
  
  
}
struct ChallengeInfo{
  var companyImage: UIImage
  var challengeName: String
  var shortDescription: String
  var prizeImage: UIImage
  var longDescription: String
  var prizeDescription: String
}
