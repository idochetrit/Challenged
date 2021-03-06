//
//  CollectionViewCell.swift
//  EnigmaAR
//
//  Created by Ido Chetrit on 22/04/2018.
//  Copyright © 2018 Ido Chetrit. All rights reserved.
//

import UIKit
import FSPagerView
class CollectionViewCell:  FSPagerViewCell {

  @IBOutlet weak var prizeImage: UIImageView!
  @IBOutlet weak var descrip: UILabel!
  @IBOutlet weak var title: UILabel!
  @IBOutlet weak var bigImage: UIImageView!
  override func awakeFromNib() {
      super.awakeFromNib()
      // Initialization code
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    //design HEADLINE-title
    title.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
    title.textAlignment = NSTextAlignment.center
    title.layer.shadowColor = UIColor.lightGray.cgColor
    title.layer.shadowRadius = 3.0
    title.layer.shadowOpacity = 1.0
    title.layer.shadowOffset = CGSize(width: 2, height: 2)
    title.layer.masksToBounds = false
    title.numberOfLines = 2
    
    descrip.lineBreakMode = .byWordWrapping
    descrip.numberOfLines = 4
  }

}
