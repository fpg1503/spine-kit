//
//  ColorTransitionKeyFrame+ SKAction.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 1/12/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//

import SpriteKit

extension ColorTransitionKeyFrame: SKActionKeyFrame {
    
    func linearAction(nodeToAnimate: SKNode, duration: Double) -> SKAction? {
        return SKAction.colorizeWithColor(self.color ?? UIColor.clearColor(), colorBlendFactor: 1, duration: duration)
    }
    
    func animationData() -> (time: Double, curve: Curve) {
        return (self.time, self.curve)
    }
}