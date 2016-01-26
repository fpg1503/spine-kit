//
//  ColorTransitionKeyFrame+ SKAction.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 1/12/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//

import SpriteKit

extension ColorTransitionKeyFrame: SKActionKeyFrame {
    
    func basicAction<Context>(context: Context, duration: Double) -> SKAction? {
        
        return SKAction.colorizeWithColor(self.color ?? UIColor.clearColor(), colorBlendFactor: 1, duration: duration)
        
    }

    func bezierAction<Context>(context: Context, duration: Double, bezier: Bezier) -> SKAction? {
        
        var result: SKAction? = nil
        
        if let color = self.color {
            
            var deltaRGBA: (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat)? = nil
            let finalColorRGBA = color.getRGBA()
            
            result = SKAction.customActionWithDuration(duration, actionBlock: { (node, elapsedTime) -> Void in
            
                if let spriteNode = context as? SKSpriteNode {
                
                    if deltaRGBA == nil {
                        
                        let currentColorRGBA = spriteNode.color.getRGBA()
                        
                        deltaRGBA = (
                            r: (finalColorRGBA.r - currentColorRGBA.r),
                            g: (finalColorRGBA.g - currentColorRGBA.g),
                            b: (finalColorRGBA.b - currentColorRGBA.b),
                            a: (finalColorRGBA.a - currentColorRGBA.a)
                        )
                    }
                
                    if let deltaRGBA = deltaRGBA {
                        
                        let bezierResult = bezier.solve((x: 0, y: 0), pointB: (x: 0, 1), duration: duration, elapsedTime: Double(elapsedTime)).y

                        let currentColorRGBA = spriteNode.color.getRGBA()
                        
                        let r = self.calcNewBezierColor(currentColorRGBA.r, deltaColorComponent: deltaRGBA.r, bezierResult: CGFloat(bezierResult))
                        let g = self.calcNewBezierColor(currentColorRGBA.g, deltaColorComponent: deltaRGBA.g, bezierResult: CGFloat(bezierResult))
                        let b = self.calcNewBezierColor(currentColorRGBA.b, deltaColorComponent: deltaRGBA.b, bezierResult: CGFloat(bezierResult))
                        let a = self.calcNewBezierColor(currentColorRGBA.a, deltaColorComponent: deltaRGBA.a, bezierResult: CGFloat(bezierResult))
                        
                        spriteNode.color = UIColor(red: r, green: g, blue: b, alpha: a)
                    }
                }
            })
        }
        return result
    }
    
    func curveToApply() -> Curve {
        return self.curve
    }
    
    func animationTime() -> Double {
        return self.time
    }
    
    private func calcNewBezierColor(currentColorComponent: CGFloat, deltaColorComponent: CGFloat, bezierResult: CGFloat) -> CGFloat {
        let newColor = currentColorComponent + deltaColorComponent * bezierResult
        return newColor > 1 ? 1 : newColor
    }
    

}