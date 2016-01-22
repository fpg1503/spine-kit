//
//  TranslateKeyFrame+SKAction.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 1/12/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//

import SpriteKit

extension TranslateKeyFrame: SKActionKeyFrame  {
    
    func linearAction(nodeToAnimate: SKNode, timeOffset: Double) -> SKAction? {
        
        if let x = self.x, let y = self.y, let bone = nodeToAnimate as? SKBoneNode  {
            
            let origin = bone.originCGPoint()
            let absoluteX = origin.x + CGFloat(x)
            let absoluteY = origin.y + CGFloat(y)
            
            return SKAction.moveTo(CGPoint(x: absoluteX, y: absoluteY), duration: self.time - timeOffset)
        }
        return nil
    }
    
    func animationData() -> (time: Double, curve: Curve) {
        return (self.time, self.curve)
    }
}