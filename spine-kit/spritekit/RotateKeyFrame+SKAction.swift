//
//  RotateKeyFrame+SKAction.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 1/12/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//

import SpriteKit

extension RotateKeyFrame: SKActionKeyFrame {
    
    func linearAction(nodeToAnimate: SKNode, timeOffset: Double) -> SKAction? {

        var result: SKAction? = nil

        if let angle = self.angle, bone = nodeToAnimate as? SKBoneNode {
            
            let absoluteAngle: Double = bone.rotation() + angle
            result = SKAction.rotateToAngle(CGFloat(absoluteAngle.degreesToRadians), duration: self.time - timeOffset, shortestUnitArc: true)
        }
        return result
    }
    
    func bezierAction(nodeToAnimate: SKNode, timeOffset: Double, bezier: Bezier) -> SKAction? {
        return linearAction(nodeToAnimate, timeOffset: timeOffset)
    }

    func animationData() -> (time: Double, curve: Curve) {
        return (self.time, self.curve)
    }
}