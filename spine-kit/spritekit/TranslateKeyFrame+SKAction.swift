//
//  TranslateKeyFrame+SKAction.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 1/12/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//

import SpriteKit

extension TranslateKeyFrame: SKActionKeyFrame  {
    
    func linearAction(nodeToAnimate: SKNode, duration: Double) -> SKAction? {
        
        if let x = self.x, let y = self.y, let bone = nodeToAnimate as? SKBoneNode {
            
            let origin = bone.originCGPoint()
            let absoluteX = origin.x + CGFloat(x)
            let absoluteY = origin.y + CGFloat(y)
            
            return SKAction.moveTo(CGPoint(x: absoluteX, y: absoluteY), duration: duration)
        }
        return nil
    }
   
    func bezierAction(nodeToAnimate: SKNode, duration: Double, bezier: Bezier) -> SKAction? {
        
        var result: SKAction? = nil
        
        if let x = self.x, let y = self.y, let bone = nodeToAnimate as? SKBoneNode {
            
            let origin = bone.originCGPoint()
            var initialPoint: (x: Double, y: Double)? = nil
            let finalPoint =  (x: Double(origin.x) + x, y: Double(origin.y) + y)

            result = SKAction.customActionWithDuration(duration, actionBlock: { (node, elapsedTime) -> Void in
                
                if initialPoint == nil {
                    initialPoint = (x: Double(node.position.x), y: Double(node.position.y))
                }
                
                let point = bezier.solve(initialPoint ?? (x: 0, y: 0), pointB: finalPoint, duration: duration, elapsedTime: Double(elapsedTime))
                
                node.position = CGPoint(x: CGFloat(point.x), y: CGFloat(point.y))
            })
        }
        return result
    }
    
    func animationData() -> (time: Double, curve: Curve) {
        return (self.time, self.curve)
    }
}