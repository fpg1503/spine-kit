//
//  ScaleKeyFrame+SKAction.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 1/12/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//

import SpriteKit

extension ScaleKeyFrame: SKActionKeyFrame  {
    
    func linearAction<Context>(context: Context, duration: Double) -> SKAction? {

        var result: SKAction? = nil
        
        if let x = self.x, let y = self.y {
            result = SKAction.group([SKAction.scaleXTo(CGFloat(x), duration: duration), SKAction.scaleYTo(CGFloat(y), duration: duration)])
        }
        
        return result
    }
    
    func bezierAction<Context>(context: Context, duration: Double, bezier: Bezier) -> SKAction? {
        
        var result: SKAction? = nil
        
        if let x = self.x, let y = self.y {
            
            var initialPoint: (x: Double, y: Double)? = nil
            let finalPoint =  (x: x, y: y)
            
            result = SKAction.customActionWithDuration(duration, actionBlock: { (node, elapsedTime) -> Void in
                
                if initialPoint == nil {
                    initialPoint = (x: Double(node.xScale), y: Double(node.yScale))
                }
                
                let point = bezier.solve(initialPoint ?? (x: 0, y: 0), pointB: finalPoint, duration: duration, elapsedTime: Double(elapsedTime))
            
                node.xScale = CGFloat(point.x)
                node.yScale = CGFloat(point.y)

            })
        }
        return result
    }

    func animationData() -> (time: Double, curve: Curve) {
        return (self.time, self.curve)
    }
}