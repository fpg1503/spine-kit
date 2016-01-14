//
//  Bone+SpriteKit.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 1/12/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//

import SpriteKit

extension Bone {
    
    func toSKNode(parent: SKNode?) -> SKNode {
        
        let boneNode = SKShapeNode(rect: CGRect(x: -10, y: -10, width: 10, height: 10))
        boneNode.strokeColor = UIColor.blueColor()
        boneNode.lineWidth = 2
        
        boneNode.name = self.name
        boneNode.position = CGPoint(x: CGFloat(self.x), y: CGFloat(self.y))
        
        if self.inheritRotation {
            if let parentRotation = parent?.zRotation {
                boneNode.zRotation = (boneNode.zRotation + parentRotation)
            }
        } else {
            boneNode.zRotation = self.rotation.degreesToRadians
        }
        
        if self.inheritScale {
            
            if let parentXScale = parent?.xScale, let parentYScale = parent?.yScale {
                boneNode.xScale = parentXScale + CGFloat(self.scaleX)
                boneNode.yScale = parentYScale + CGFloat(self.scaleY)
            }
            
        } else {
            boneNode.xScale = CGFloat(self.scaleX)
            boneNode.yScale = CGFloat(self.scaleY)
        }
        
        return boneNode
    }
}