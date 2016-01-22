//
//  ScaleKeyFrame+SKAction.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 1/12/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//

import SpriteKit

extension ScaleKeyFrame: SKActionKeyFrame  {
    
    func linearAction(nodeToAnimate: SKNode, timeOffset: Double) -> SKAction? {

        var result: SKAction? = nil
        
        if let x = self.x, let y = self.y {
            result = SKAction.group([SKAction.scaleXTo(CGFloat(x), duration: self.time - timeOffset), SKAction.scaleYTo(CGFloat(y), duration: self.time - timeOffset)])
        }
        
        return result
    }
    
    func bezierAction(nodeToAnimate: SKNode, timeOffset: Double, bezier: Bezier) -> SKAction? {
        return linearAction(nodeToAnimate, timeOffset: timeOffset)
    }

    func animationData() -> (time: Double, curve: Curve) {
        return (self.time, self.curve)
    }
}