//
//  ColorTransitionKeyFrame+ SKAction.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 1/12/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//

import SpriteKit

extension ColorTransitionKeyFrame: SKActionKeyFrame {
    
    func linearAction(nodeToAnimate: SKNode, timeOffset: Double) -> SKAction? {
        
        return SKAction.customActionWithDuration(self.time - timeOffset, actionBlock: { (node, duration) -> Void in
            
            if let slot = node as? SKSlotNode, let color = self.color {
                
                let position = duration/CGFloat(self.time - timeOffset)
                slot.setColorSettings(color, colorBlendFactor: position)
            }
        })
    }
    
    func animationData() -> (time: Double, curve: Curve) {
        return (self.time, self.curve)
    }
}