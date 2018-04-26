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
    ChallengeInfo(companyImage: #imageLiteral(resourceName: "macdonalds"),
                  challengeName: "Bull's Eye", shortDescription: "Save us from the robot invasion",
                  prizeImage: #imageLiteral(resourceName: "hamburger"),
                  gameID: 0, longDescription: "Robots invaided Macdonald's. Their vulnerability is WATER. Help us to stop them by using the water baloons. Eliminate more than 20 in 1 minute to win the prize",
                  prizeDescription: "Yummy Big MAC"),
    ChallengeInfo(companyImage: #imageLiteral(resourceName: "apple"),
                  challengeName: "Treasure Hunt", shortDescription: "Help us to find the treasure",
                  prizeImage: #imageLiteral(resourceName: "charger"),
                  gameID: 1, longDescription: "Robots invaided Macdonald's. Their vulnerability is WATER. Help us to stop them by using the water baloons. Eliminate more than 20 in 1 minute to win the prize",
                  prizeDescription: "An IPHONE charger"),
    ChallengeInfo(companyImage: #imageLiteral(resourceName: "H&M"),
                  challengeName: "The Grand Robbery", shortDescription: "Help us to stop the   thieves ",
                  prizeImage: #imageLiteral(resourceName: "shirt"),
                  gameID: 2, longDescription: "Robots invaided Macdonald's. Their vulnerability is WATER. Help us to stop them by using the water baloons. Eliminate more than 20 in 1 minute to win the prize",
                  prizeDescription: "Beautiful H&M Shirt"),
    ChallengeInfo(companyImage: #imageLiteral(resourceName: "sabon"),
                  challengeName: "SABON", shortDescription: "A German car manufacturer",
                  prizeImage: #imageLiteral(resourceName: "bodycream"),
                  gameID: 3, longDescription: "Robots invaided Macdonald's. Their vulnerability is WATER. Help us to stop them by using the water baloons. Eliminate more than 20 in 1 minute to win the prize",
                  prizeDescription: "SABON's Body Cream"),
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
