//
//  BezierSKActionBuilder.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 1/12/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//
import SpriteKit

extension SKAction {

    static func moveBezier(pointA: CGPoint, pointB: CGPoint, control1: BezierControlPoint, control2: BezierControlPoint, duration: NSTimeInterval) -> SKAction {
        let bezierCurve = BezierCurve(control1: control1, control2:control2)
        
        return SKAction.customActionWithDuration(duration, actionBlock: { (node, elapsedTime) -> Void in
            node.position = self.bezier(bezierCurve, pointA: pointA, pointB: pointB, duration: duration, elapsedTime: NSTimeInterval(elapsedTime))
        })
    }

    static func scaleBezier(pointA: CGPoint, pointB: CGPoint, control1: BezierControlPoint, control2: BezierControlPoint, duration: NSTimeInterval) -> SKAction {
        let bezierCurve = BezierCurve(control1: control1, control2:control2)
        
        return SKAction.customActionWithDuration(duration, actionBlock: { (node, elapsedTime) -> Void in
            let scale = self.bezier(bezierCurve, pointA: pointA, pointB: pointB, duration: duration, elapsedTime: NSTimeInterval(elapsedTime))
            node.xScale = scale.x;
            node.yScale = scale.y;
        })
    }
    
    static func colorBezier(color: SKColor, initBlendFactor: CGFloat, finalBlendFactor: CGFloat, control1: BezierControlPoint, control2: BezierControlPoint, duration: NSTimeInterval) -> SKAction {
        let bezierCurve = BezierCurve(control1: control1, control2:control2)

        return SKAction.customActionWithDuration(duration, actionBlock: { (node, elapsedTime) -> Void in
            
            let blendFactor =  self.bezier(bezierCurve, pointA: CGPointMake(initBlendFactor, 0), pointB: CGPointMake(finalBlendFactor, 0), duration: duration, elapsedTime: NSTimeInterval(elapsedTime)).x
                  
            if let node = node as? SKSpriteNode {
                node.color = color;
                node.colorBlendFactor = blendFactor;
            }
        })
    }
    
    static func rotateBezier(angleA: CGFloat, angleB: CGFloat, control1: BezierControlPoint, control2: BezierControlPoint, duration: NSTimeInterval) -> SKAction {
        let bezierCurve = BezierCurve(control1: control1, control2:control2)
        
        //Use shortest angle
        let pi = CGFloat(M_PI)
        var a = angleA < 0 ?  angleA + (pi * 2) : angleA;
        var b = angleB < 0 ?  angleB + (pi * 2) : angleB;
        
        if a > b {
            if a - b > CGFloat(M_PI) {
                a = a - (pi * 2)
            }
        } else if b - a > pi {
            b = b - (pi * 2)
        }
        
        return SKAction.customActionWithDuration(duration, actionBlock: { (node, elapsedTime) -> Void in
            let angle = self.bezier(bezierCurve, pointA: CGPointMake(a, 0), pointB: CGPointMake(b, 0), duration: duration, elapsedTime: NSTimeInterval(elapsedTime)).x
            node.zRotation = angle
        })
    }
    
    private static func bezier(curve: BezierCurve, pointA: CGPoint, pointB: CGPoint, duration: NSTimeInterval, elapsedTime: NSTimeInterval) -> CGPoint {
        let epsilon = (1000 / 60 / (duration * 1000)) / 4
        let bezierPoint = CGFloat(curve.solve(elapsedTime / duration, epsilon:epsilon))
        return CGPointMake(pointA.x * (1 - bezierPoint) + (pointB.x * bezierPoint), pointA.y * (1 - bezierPoint) + (pointB.y * bezierPoint));
    }
}