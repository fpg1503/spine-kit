//
//  BezierSKActionBuilder.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 1/12/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//
import SpriteKit

class BezierBuilder {

    func moveBezier(pointA: CGPoint, pointB: CGPoint, control1: BezierControlPoint, control2: BezierControlPoint, duration: NSTimeInterval) -> SKAction {
        let bezierCurve = BezierCurve(control1: control1, control2:control2)
        
        return SKAction.customActionWithDuration(duration, actionBlock: { (node, elapsedTime) -> Void in
            node.position = self.bezier(bezierCurve, pointA: pointA, pointB: pointB, duration: duration, elapsedTime: NSTimeInterval(elapsedTime))
        })
    }

    func scaleBezier(pointA: CGPoint, pointB: CGPoint, control1: BezierControlPoint, control2: BezierControlPoint, duration: NSTimeInterval) -> SKAction {
        let bezierCurve = BezierCurve(control1: control1, control2:control2)
        
        return SKAction.customActionWithDuration(duration, actionBlock: { (node, elapsedTime) -> Void in
            let scale = self.bezier(bezierCurve, pointA: pointA, pointB: pointB, duration: duration, elapsedTime: NSTimeInterval(elapsedTime))
            node.xScale = scale.x;
            node.yScale = scale.y;
        })
    }
    
    func colorBezier(color: SKColor, initBlendFactor: CGFloat, finalBlendFactor: CGFloat, control1: BezierControlPoint, control2: BezierControlPoint, duration: NSTimeInterval) -> SKAction {
        let bezierCurve = BezierCurve(control1: control1, control2:control2)

        return SKAction.customActionWithDuration(duration, actionBlock: { (node, elapsedTime) -> Void in
            
            let blendFactor =  self.bezier(bezierCurve, pointA: CGPointMake(initBlendFactor, 0), pointB: CGPointMake(finalBlendFactor, 0), duration: duration, elapsedTime: NSTimeInterval(elapsedTime)).x
                  
            if let node = node as? SKSpriteNode {
                node.color = color;
                node.colorBlendFactor = blendFactor;
            }
        })
    }
    
    func rotateBezier(angleA: CGFloat, angleB: CGFloat, control1: BezierControlPoint, control2: BezierControlPoint, duration: NSTimeInterval) -> SKAction {
        let bezierCurve = BezierCurve(control1: control1, control2:control2)
        let shortestAngle: (origin: Double, dest: Double) = MathUtils().shortestAngleBetween((Double(angleA), Double(angleB)))

        return SKAction.customActionWithDuration(duration, actionBlock: { (node, elapsedTime) -> Void in
            let angle = self.bezier(bezierCurve, pointA: CGPointMake(CGFloat(shortestAngle.origin), 0), pointB: CGPointMake(CGFloat(shortestAngle.dest), 0), duration: duration, elapsedTime: NSTimeInterval(elapsedTime)).x
            node.zRotation = angle
        })
    }
    
    private func bezier(curve: BezierCurve, pointA: CGPoint, pointB: CGPoint, duration: NSTimeInterval, elapsedTime: NSTimeInterval) -> CGPoint {
        let epsilon = (1000 / 60 / (duration * 1000)) / 4
        let bezierPoint = CGFloat(curve.solve(elapsedTime / duration, epsilon:epsilon))
        return CGPointMake(pointA.x * (1 - bezierPoint) + (pointB.x * bezierPoint), pointA.y * (1 - bezierPoint) + (pointB.y * bezierPoint));
    }
}