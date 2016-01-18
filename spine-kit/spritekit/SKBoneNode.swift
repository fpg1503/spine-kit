//
//  Bone+SpriteKit.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 1/12/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//

import SpriteKit

class SKBoneNode: SKNode {
    
    private var bone: Bone?
    
    private var slotNode: SKSlotNode?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(bone: Bone) {
        super.init()
        
        self.name = bone.name
        self.bone = bone
    }
    
    func addSlot(slotNode: SKSlotNode) {
        self.slotNode = slotNode
        self.addChild(slotNode)
    }
    
    func originCGPoint() -> CGPoint {
        var point = CGPoint(x: CGFloat(0), y: CGFloat(0))
        if let bone = self.bone {
            point = CGPoint(x: CGFloat(bone.x), y: CGFloat(bone.y))
        }
        return point
    }

    func rotation() -> Double {
        var rotation: Double = 0
        if let bone = self.bone {
            rotation = bone.rotation
        }
        return rotation
    }
    
    func setupPose() {
        
        if let bone = self.bone {
            
            self.position = CGPoint(x: CGFloat(bone.x), y: CGFloat(bone.y))
            
            if bone.inheritRotation {
                
                if let parentRotation = parent?.zRotation {
                    self.zRotation = (self.zRotation + parentRotation)
                }
                
            } else {
                self.zRotation = bone.rotation.degreesToRadians
            }
            
            if bone.inheritScale {
                
                if let parentXScale = parent?.xScale, let parentYScale = parent?.yScale {
                    self.xScale = parentXScale + CGFloat(bone.scaleX)
                    self.yScale = parentYScale + CGFloat(bone.scaleY)
                }
                
            } else {
                self.xScale = CGFloat(bone.scaleX)
                self.yScale = CGFloat(bone.scaleY)
            }
            
            self.slotNode?.setupPose()
            
            for child in self.children {
                if let boneChild = child as? SKBoneNode {
                    boneChild.setupPose()
                }
            }
        }
    }
}