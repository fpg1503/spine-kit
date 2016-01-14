//
//  TranslateKeyFrame+SKAction.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 1/12/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//

import SpriteKit

extension TranslateKeyFrame: SKActionKeyFrame  {
    
    func toSKAction(timeOffset: Double, curve: Curve) -> SKAction? {
        
        var result: SKAction? = nil
        if let x = self.x, let y = self.y {
            
            switch curve {
            case .Stepped:
                result = SKAction.sequence([SKAction.waitForDuration(self.time - timeOffset), SKAction.moveTo(CGPoint(x: CGFloat(x), y: CGFloat(y)), duration:0)])
            default:
                result = SKAction.moveTo(CGPoint(x: CGFloat(x), y: CGFloat(y)), duration: self.time - timeOffset)
            }

        }
        return result
    }
    
    func animationData() -> (time: Double, curve: Curve) {
        return (self.time, self.curve)
    }
}