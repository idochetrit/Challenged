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

// MARK: - String extensions

extension String {
  func capturedGroups(withRegex pattern: String) -> [String]? {
    var regex: NSRegularExpression
    do {
      regex = try NSRegularExpression(pattern: pattern, options: [])
    } catch {
      return nil
    }
    
    let matches = regex.matches(in: self, options: [], range: NSRange(location:0, length: self.count))
    
    guard let match = matches.first else { return nil }
    
    // Note: Index 1 is 1st capture group, 2 is 2nd, ..., while index 0 is full match which we don't use
    let lastRangeIndex = match.numberOfRanges - 1
    guard lastRangeIndex >= 1 else { return nil }
    
    var results = [String]()
    
    for i in 1...lastRangeIndex {
      let capturedGroupIndex = match.range(at: i)
      let matchedString = (self as NSString).substring(with: capturedGroupIndex)
      results.append(matchedString)
    }
    
    return results
  }
}

