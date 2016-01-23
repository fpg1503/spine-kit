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
    
    func linearAction(nodeToAnimate: SKNode, duration: Double) -> SKAction?
    
    func bezierAction(nodeToAnimate: SKNode, duration: Double, bezier: Bezier) -> SKAction?
}

extension SKActionKeyFrame {
    
    func toSKAction(nodeToAnimate: SKNode, timeOffset: Double, curve: Curve) -> SKAction? {
        let duration = animationData().time - timeOffset

        var result: SKAction? = nil
        switch curve {
            
        case .Stepped:
            
            if let linearAction = self.linearAction(nodeToAnimate, duration: duration) {
                linearAction.duration = 0
                result = SKAction.sequence([SKAction.waitForDuration(self.animationData().time - timeOffset), linearAction])
            }
            break
            
        case .Bezier:

            
            if let bezier = self.buildBezier() where duration != 0 {
                result = bezierAction(nodeToAnimate, duration: duration, bezier: bezier)
            } else {
                result = linearAction(nodeToAnimate, duration: duration)
            }
            
            break
            
        default:
            
            result = linearAction(nodeToAnimate, duration: duration)
            break
        }
        return result
    }
    
    func bezierAction(nodeToAnimate: SKNode, duration: Double, bezier: Bezier) -> SKAction? {
        return linearAction(nodeToAnimate, duration: duration)
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