//
//  RotateKeyFrame+SKAction.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 1/12/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//

import SpriteKit

extension RotateKeyFrame: SKActionKeyFrame {
    
    func linearAction(nodeToAnimate: SKNode, duration: Double) -> SKAction? {

        var result: SKAction? = nil

        if let angle = self.angle, bone = nodeToAnimate as? SKBoneNode {
            
            let absoluteAngle: Double = bone.rotation() + angle
            result = SKAction.rotateToAngle(CGFloat(absoluteAngle.degreesToRadians), duration: duration, shortestUnitArc: true)
        }
        return result
    }

    func bezierAction(nodeToAnimate: SKNode, duration: Double, bezier: Bezier) -> SKAction? {

        var result: SKAction? = nil

        if let angle = self.angle, bone = nodeToAnimate as? SKBoneNode {
            
            result = SKAction.customActionWithDuration(duration, actionBlock: { (node, elapsedTime) -> Void in

                let point = bezier.solve(Double(elapsedTime), curveSampleDataBlock: { () -> BezierCurveSampleData in

                    let initialAngle = node.zRotation
                    let finalAngle = bone.rotation().degreesToRadians + angle.degreesToRadians
                    
                    let (origin, dest) = MathUtils().shortestAngleBetween(Double(initialAngle), to: Double(finalAngle))
                    
                    return BezierCurveSampleData(pointA: (x: origin, y: 0), pointB: (x: dest, 0), duration: duration)
                })
            
                node.zRotation = point.x > M_PI * 2 ? CGFloat(point.x - M_PI * 2):  CGFloat(point.x)
            })
        }
        return result
    }

    func animationData() -> (time: Double, curve: Curve) {
        return (self.time, self.curve)
    }
}