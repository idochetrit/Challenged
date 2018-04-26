
import Foundation
import ARKit

class Plane: SCNNode {
    
  // MARK: - Properties
	var anchor: ARPlaneAnchor
    
  // MARK: - Initialization
  init(_ anchor: ARPlaneAnchor, hidden: Bool = true) {
    self.anchor = anchor
    super.init()
		
    // 1. determine size of plane anchor
    let width = CGFloat(anchor.extent.x)
    let height = CGFloat(anchor.extent.z)
    let plane = SCNPlane(width: width, height: height)
    
    // (2.) color the surface
    if (hidden) {
      let worldGroundMaterial = SCNMaterial()
      worldGroundMaterial.lightingModel = .constant
      worldGroundMaterial.writesToDepthBuffer = true
      worldGroundMaterial.colorBufferWriteMask = []
      worldGroundMaterial.isDoubleSided = true
      plane.materials = [worldGroundMaterial]
    } else {
      plane.materials.first?.diffuse.contents = UIColor.lightGray
      plane.materials.first?.transparency = 0.4
    }
    
    // 3. create plane node and assign the geometry and position
    self.geometry = plane
    self.position = SCNVector3Make(anchor.center.x, 0, anchor.center.z)
    self.eulerAngles.x = -.pi / 2
    
    // 4. add physical body to the node
//    self.physicsBody = SCNPhysicsBody(type: .kinematic,
//                                      shape: SCNPhysicsShape(geometry: self.geometry!,
//                                                             options: nil))
    
    
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
    
  // MARK: - ARKit
	
	func update(_ anchor: ARPlaneAnchor) {
		self.anchor = anchor
    
    let width = CGFloat(anchor.extent.x)
    let height = CGFloat(anchor.extent.z)
    let plane = SCNPlane(width: width, height: height)
    self.geometry = plane
    
    self.position = SCNVector3(anchor.center.x, 0, anchor.center.z);
    
//    self.physicsBody = SCNPhysicsBody(type: .kinematic,
//                                      shape: SCNPhysicsShape(geometry: self.geometry!,
//                                                             options: nil))
	}
		
}

