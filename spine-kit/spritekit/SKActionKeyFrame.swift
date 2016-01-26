//
//  KeyFrame+SKAction.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 1/12/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//
import SpriteKit

protocol SKActionKeyFrame {
    
    func toSKAction<Context>(context: Context, duration: Double, curve: Curve) -> SKAction?
    
    func curveToApply() -> Curve
    
    func animationTime() -> Double
    
    func basicAction<Context>(context: Context, duration: Double) -> SKAction?
 
    func steppedAction<Context>(context: Context, duration: Double) -> SKAction?
    
    func bezierAction<Context>(context: Context, duration: Double, bezier: Bezier) -> SKAction?
}

extension SKActionKeyFrame {
    
    func toSKAction<Context>(context: Context, duration: Double, curve: Curve) -> SKAction? {

        var result: SKAction? = nil
        switch curve {
            
        case .Stepped:
            result = steppedAction(context, duration: duration)
            break
            
        case .Bezier:
            
            if let bezier = self.buildBezier(curve) where duration != 0 {
                result = bezierAction(context, duration: duration, bezier: bezier)
            } else {
                result = basicAction(context, duration: duration)
            }
            
            break
            
        default:
            
            result = basicAction(context, duration: duration)
            break
        }
        return result
    }
    
    func bezierAction<Context>(context: Context, duration: Double, bezier: Bezier) -> SKAction? {
        return basicAction(context, duration: duration)
    }

    func steppedAction<Context>(context: Context, duration: Double) -> SKAction? {

        var result: SKAction? = nil
        
        if let linearAction = self.basicAction(context, duration: duration) {
            
            if duration > 0 {
            
                linearAction.duration = 0
                result = SKAction.sequence([SKAction.waitForDuration(duration), linearAction])
                
            } else {
                
                result = linearAction
            }
        }
        
        return result
    }
    
    func curveToApply() -> Curve {
        return Curve.Stepped
    }

    private func buildBezier(curve: Curve) -> Bezier? {
    
        var result: Bezier? = nil
        
        switch curve {
        
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