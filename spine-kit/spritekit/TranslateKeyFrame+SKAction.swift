//
//  TranslateKeyFrame+SKAction.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 1/12/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//

import SpriteKit

extension TranslateKeyFrame {
    
    func toSKAction(timeOffset: Double, curve: Curve) -> SKAction? {
        var result: SKAction? = nil
        if let x = self.x, let y = self.y {
            
            switch curve {
            case .Stepped:
                result = SKAction.sequence([SKAction.waitForDuration(self.time - timeOffset), SKAction.moveTo(CGPoint(x: CGFloat(x), y: CGFloat(-y)), duration: self.time - timeOffset)])
            default:
                result = SKAction.moveTo(CGPoint(x: CGFloat(x), y: CGFloat(-y)), duration: self.time - timeOffset)
            }

        }
        return result
    }
}