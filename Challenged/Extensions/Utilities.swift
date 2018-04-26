//
//  Utilities.swift
//  Challenged
//
//  Created by Ido Chetrit on 26/04/2018.
//  Copyright © 2018 hackidc66. All rights reserved.
//

import UIKit
import SceneKit

// MARK: - Collection extensions
extension Array {
  func randomItem() -> Element? {
    if self.isEmpty { return nil }
    let randomIndex: Int = Int(arc4random_uniform(UInt32(self.count)))
    return self[randomIndex]
  }
}


// MARK: - SCNVector3 extensions
extension SCNVector3 {
  static func positionFromTransform(_ transform: matrix_float4x4) -> SCNVector3 {
    return SCNVector3Make(transform.columns.3.x, transform.columns.3.y, transform.columns.3.z)
  }
}
