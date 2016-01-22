//
//  KeyFrame+SKAction.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 1/12/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//
import SpriteKit

protocol SKActionKeyFrame {
    
    func toSKAction(nodeToAnimate: SKNode, timeOffset: Double, curve: Curve) -> SKAction?
    
    func animationData() -> (time: Double, curve: Curve)
    
    func linearAction(nodeToAnimate: SKNode, timeOffset: Double) -> SKAction?
    
    func bezierAction(nodeToAnimate: SKNode, timeOffset: Double, bezier: Bezier) -> SKAction?
}

extension SKActionKeyFrame {
    
    func toSKAction(nodeToAnimate: SKNode, timeOffset: Double, curve: Curve) -> SKAction? {
        
        var result: SKAction? = nil
        switch curve {
            
        case .Stepped:
            
            if let linearAction = self.linearAction(nodeToAnimate, timeOffset: timeOffset) {
                linearAction.duration = 0
                result = SKAction.sequence([SKAction.waitForDuration(self.animationData().time - timeOffset), linearAction])
            }
            break
            
        case .Bezier:
            
            let duration: Double = Double(self.animationData().time - timeOffset)
            
            if let bezier = self.buildBezier() {
                result = bezierAction(nodeToAnimate, timeOffset: timeOffset, bezier: bezier)
                result?.timingFunction = self.bezierTimingFunction(duration, timeOffset: timeOffset, bezier: bezier)
            } else {
                result = linearAction(nodeToAnimate, timeOffset: timeOffset)
            }
            
            break
            
        default:
            
            result = linearAction(nodeToAnimate, timeOffset: timeOffset)
            break
        }
        return result
    }
    
    func bezierAction(nodeToAnimate: SKNode, timeOffset: Double, bezier: Bezier) -> SKAction? {
        return linearAction(nodeToAnimate, timeOffset: timeOffset)
    }

    private func bezierTimingFunction(duration: Double, timeOffset: Double, bezier: Bezier) -> (Float) -> Float {
        return { time in
            return Float(bezier.solve(Double(time), duration: duration))
        }
    }
    
    private func buildBezier() -> Bezier? {
    
        var result: Bezier? = nil
        
        switch animationData().curve  {
        
        case let .Bezier(points):
        
            if points.count == 4 {
            
                let control1 = (x: points[0], y: points[1])
                let control2 = (x: points[2], y: points[3])
                result = Bezier(control1: control1, control2: control2)
            }
            break
        default:
            break
        }
        return result
    }
    
}