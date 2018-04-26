//
//  ChallengeInfo.swift
//  Challenged
//
//  Created by Ido Chetrit on 26/04/2018.
//  Copyright © 2018 hackidc66. All rights reserved.
//

import UIKit

struct ChallengeInfoStore {
  static let data = [
    ChallengeInfo(companyImage: #imageLiteral(resourceName: "icon_audi"),
                  challengeName: "Audi", shortDescription: "A German car manufacturer",
                  prizeImage: #imageLiteral(resourceName: "20precent"),
                  gameID: 0, longDescription: "Audiis a German automobile manufacturer that designs, engineers, produces, markets and distributes luxury vehicles. Audi is a member of the Volkswagen Group and has its roots at Ingolstadt, Bavaria, Germany. Audi-branded vehicles are produced in nine production facilities worldwide.",
                  prizeDescription: "Get 20% OFF"),
    ChallengeInfo(companyImage: #imageLiteral(resourceName: "icon_audi"),
                  challengeName: "Audi", shortDescription: "A German car manufacturer",
                  prizeImage: #imageLiteral(resourceName: "20precent"),
                  gameID: 1, longDescription: "Audiis a German automobile manufacturer that designs, engineers, produces, markets and distributes luxury vehicles. Audi is a member of the Volkswagen Group and has its roots at Ingolstadt, Bavaria, Germany. Audi-branded vehicles are produced in nine production facilities worldwide.", prizeDescription: "Get 20% OFF"),
    ChallengeInfo(companyImage: #imageLiteral(resourceName: "icon_google"),
                  challengeName: "Audi", shortDescription: "A German car manufacturer",
                  prizeImage: #imageLiteral(resourceName: "20precent"),
                  gameID: 2, longDescription: "Audiis a German automobile manufacturer that designs, engineers, produces, markets and distributes luxury vehicles. Audi is a member of the Volkswagen Group and has its roots at Ingolstadt, Bavaria, Germany. Audi-branded vehicles are produced in nine production facilities worldwide.", prizeDescription: "Get 20% OFF"),
    ChallengeInfo(companyImage: #imageLiteral(resourceName: "icon_canada"),
                  challengeName: "Audi", shortDescription: "A German car manufacturer",
                  prizeImage: #imageLiteral(resourceName: "20precent"),
                  gameID: 3, longDescription: "Audiis a German automobile manufacturer that designs, engineers, produces, markets and distributes luxury vehicles. Audi is a member of the Volkswagen Group and has its roots at Ingolstadt, Bavaria, Germany. Audi-branded vehicles are produced in nine production facilities worldwide.", prizeDescription: "Get 20% OFF"),
    ChallengeInfo(companyImage: #imageLiteral(resourceName: "icon_intel"),
                  challengeName: "Audi", shortDescription: "A German car manufacturer",
                  prizeImage: #imageLiteral(resourceName: "20precent"),
                  gameID: 4, longDescription: "Audiis a German automobile manufacturer that designs, engineers, produces, markets and distributes luxury vehicles. Audi is a member of the Volkswagen Group and has its roots at Ingolstadt, Bavaria, Germany. Audi-branded vehicles are produced in nine production facilities worldwide.", prizeDescription: "Get 20% OFF"),
    ChallengeInfo(companyImage: #imageLiteral(resourceName: "icon_asana"),
                  challengeName: "Audi", shortDescription: "A German car manufacturer",
                  prizeImage: #imageLiteral(resourceName: "20precent"),
                  gameID: 5, longDescription: "Audiis a German automobile manufacturer that designs, engineers, produces, markets and distributes luxury vehicles. Audi is a member of the Volkswagen Group and has its roots at Ingolstadt, Bavaria, Germany. Audi-branded vehicles are produced in nine production facilities worldwide.", prizeDescription: "Get 20% OFF"),
    ChallengeInfo(companyImage: #imageLiteral(resourceName: "icon_canada"),
                  challengeName: "Audi", shortDescription: "A German car manufacturer",
                  prizeImage: #imageLiteral(resourceName: "20precent"),
                  gameID: 6, longDescription: "Audiis a German automobile manufacturer that designs, engineers, produces, markets and distributes luxury vehicles. Audi is a member of the Volkswagen Group and has its roots at Ingolstadt, Bavaria, Germany. Audi-branded vehicles are produced in nine production facilities worldwide.", prizeDescription: "Get 20% OFF")
  ]
}



struct ChallengeInfo{
  var companyImage: UIImage
  var challengeName: String
  var shortDescription: String
  var prizeImage: UIImage
  var gameID: Int
  var longDescription: String
  var prizeDescription: String
}
