//
//  ColorTransitionKeyFrame+ SKAction.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 1/12/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//

import SpriteKit

extension ColorTransitionKeyFrame: SKActionKeyFrame {
    
    func toSKAction(nodeToAnimate: SKNode, timeOffset: Double, curve: Curve) -> SKAction? {
        return nil
    }
    
    func animationData() -> (time: Double, curve: Curve) {
        return (self.time, self.curve)
    }
}