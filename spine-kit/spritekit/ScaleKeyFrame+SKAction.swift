//
//  ScaleKeyFrame+SKAction.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 1/12/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//

import SpriteKit

extension ScaleKeyFrame: SKActionKeyFrame  {
    
    func toSKAction(bone: SKBoneNode, timeOffset: Double, curve: Curve) -> SKAction? {

        var result: SKAction? = nil
        
        if let x = self.x, let y = self.y {
            switch curve {
            case .Stepped:
                result = SKAction.sequence([SKAction.waitForDuration(self.time - timeOffset), SKAction.group([SKAction.scaleXTo(CGFloat(x), duration: 0), SKAction.scaleYTo(CGFloat(y), duration: 0)])])
                break
            default:
                result = SKAction.group([SKAction.scaleXTo(CGFloat(x), duration: self.time - timeOffset), SKAction.scaleYTo(CGFloat(y), duration: self.time - timeOffset)])
            }
        }
        return result
    }
    
    func animationData() -> (time: Double, curve: Curve) {
        return (self.time, self.curve)
    }
}