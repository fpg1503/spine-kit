//
//  RotateKeyFrame+SKAction.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 1/12/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//

import SpriteKit

extension RotateKeyFrame: SKActionKeyFrame {
    
    func linearAction<Context>(context: Context, duration: Double) -> SKAction? {

        var result: SKAction? = nil

        if let angle = self.angle, bone = context as? SKBoneNode {
            
            let absoluteAngle: Double = bone.rotation() + angle
            result = SKAction.rotateToAngle(CGFloat(absoluteAngle.degreesToRadians), duration: duration, shortestUnitArc: true)
        }
        return result
    }

    func bezierAction<Context>(context: Context, duration: Double, bezier: Bezier) -> SKAction? {

        var result: SKAction? = nil

        if let angle = self.angle, bone = context as? SKBoneNode {
            
            let finalAngle = bone.rotation().degreesToRadians + angle.degreesToRadians
            var initialAngle: CGFloat? = nil
            var (origin, dest): (Double, Double) = (0, 0)
            
            result = SKAction.customActionWithDuration(duration, actionBlock: { (node, elapsedTime) -> Void in

                if initialAngle == nil {
                    initialAngle = node.zRotation
                    (origin, dest) = MathUtils().shortestAngleBetweenInRadians(Double(initialAngle ?? 0), to: Double(finalAngle))
                }
                
                let point = bezier.solve((x: 0, y: origin), pointB: (x: 0, dest), duration: duration, elapsedTime: Double(elapsedTime))

                node.zRotation = CGFloat(point.y)
            })
        }
        return result
    }

    func animationData() -> (time: Double, curve: Curve) {
        return (self.time, self.curve)
    }
}