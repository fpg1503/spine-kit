//
//  RotateKeyFrame+SKAction.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 1/12/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//

import SpriteKit

extension RotateKeyFrame {
    
    func toSKAction(timeOffset: Double, curve: Curve) -> SKAction? {
        var result: SKAction? = nil

        if let angle = self.angle {
            switch curve {
            case .Stepped:
                result = SKAction.sequence([SKAction.waitForDuration(self.time - timeOffset), SKAction.rotateToAngle(CGFloat(angle.degreesToRadians), duration: 0)])
            default:
                result = SKAction.rotateToAngle(CGFloat(angle.degreesToRadians), duration: self.time - timeOffset)
            }
        }
        return result
    }
}