//
//  ColorTransitionKeyFrame+ SKAction.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 1/12/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//

import SpriteKit

extension ColorTransitionKeyFrame: SKActionKeyFrame {
    
    func linearAction(nodeToAnimate: SKNode, timeOffset: Double) -> SKAction? {
        return SKAction.colorizeWithColor(self.color ?? UIColor.clearColor(), colorBlendFactor: 1, duration: self.time - timeOffset)
    }

    func bezierAction(nodeToAnimate: SKNode, timeOffset: Double, bezier: Bezier) -> SKAction? {
        
        let duration = self.time - timeOffset
        
        return SKAction.customActionWithDuration(duration, actionBlock: { (node, elapsedTime) -> Void in

            let blendFactor =  bezier.solve(pointA: (x: 0, y: 0), pointB: (x: 1, y: 0), duration: duration, elapsedTime: Double(elapsedTime)).x
            
            if let node = node as? SKSpriteNode {
                node.color = self.color ?? UIColor.clearColor();
                node.colorBlendFactor = CGFloat(blendFactor);
            }
        })
    }
    
    func animationData() -> (time: Double, curve: Curve) {
        return (self.time, self.curve)
    }
}