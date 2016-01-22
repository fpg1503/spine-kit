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
    
    func bezierAction(nodeToAnimate: SKNode, timeOffset: Double) -> SKAction?
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
        case .Bezier:
            result = bezierAction(nodeToAnimate, timeOffset: timeOffset)
        default:
            result = linearAction(nodeToAnimate, timeOffset: timeOffset)
        }
        return result
    }
    
    func bezierAction(nodeToAnimate: SKNode, timeOffset: Double) -> SKAction? {
        return linearAction(nodeToAnimate, timeOffset: timeOffset)
    }
}