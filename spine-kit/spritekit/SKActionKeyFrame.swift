//
//  KeyFrame+SKAction.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 1/12/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//
import SpriteKit

protocol SKActionKeyFrame {
    
    func toSKAction<Context>(context: Context, timeOffset: Double, curve: Curve) -> SKAction?
    
    func animationData() -> (time: Double, curve: Curve)
    
    func linearAction<Context>(context: Context, duration: Double) -> SKAction?
 
    func steppedAction<Context>(context: Context, duration: Double) -> SKAction?
    
    func bezierAction<Context>(context: Context, duration: Double, bezier: Bezier) -> SKAction?
}

extension SKActionKeyFrame {
    
    func toSKAction<Context>(context: Context, timeOffset: Double, curve: Curve) -> SKAction? {
        let duration = animationData().time - timeOffset

        var result: SKAction? = nil
        switch curve {
            
        case .Stepped:
            result = steppedAction(context, duration: duration)
            break
            
        case .Bezier:
            
            if let bezier = self.buildBezier() where duration != 0 {
                result = bezierAction(context, duration: duration, bezier: bezier)
            } else {
                result = linearAction(context, duration: duration)
            }
            
            break
            
        default:
            
            result = linearAction(context, duration: duration)
            break
        }
        return result
    }
    
    func bezierAction<Context>(context: Context, duration: Double, bezier: Bezier) -> SKAction? {
        return linearAction(context, duration: duration)
    }

    func steppedAction<Context>(context: Context, duration: Double) -> SKAction? {

        var result: SKAction? = nil
        
        if let linearAction = self.linearAction(context, duration: duration) {
            
            if duration > 0 {
            
                linearAction.duration = 0
                result = SKAction.sequence([SKAction.waitForDuration(duration), linearAction])
                
            } else {
                
                result = linearAction
            }
        }
        
        return result
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