//
//  RotateKeyFrame+SKAction.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 1/12/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//

import SpriteKit

extension RotateKeyFrame: SKActionKeyFrame {
    
    func toSKAction(nodeToAnimate: SKNode, timeOffset: Double, curve: Curve) -> SKAction? {
        
        var result: SKAction? = nil

        if let angle = self.angle, bone = nodeToAnimate as? SKBoneNode {

            let absoluteAngle: Double = bone.rotation() + angle
            
            switch curve {
            case .Stepped:
                result = SKAction.sequence([SKAction.waitForDuration(self.time - timeOffset), SKAction.rotateToAngle(CGFloat(absoluteAngle.degreesToRadians), duration: 0, shortestUnitArc: true)])
            default:
                result = SKAction.rotateToAngle(CGFloat(absoluteAngle.degreesToRadians), duration: self.time - timeOffset, shortestUnitArc: true)
            }
        }
        return result
    }
    
    func animationData() -> (time: Double, curve: Curve) {
        return (self.time, self.curve)
    }
}