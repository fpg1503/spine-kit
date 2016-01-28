//
//  DrawOrderKeyFrame.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 1/27/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//
import SpriteKit

extension DrawOrderKeyFrame: SKActionKeyFrame {
    
    func basicAction<Context>(context: Context, duration: Double) -> SKAction? {
        
        var result: SKAction? = nil
        
        if let drawOrderController = context as? DrawOrderController {
            result = SKAction.runBlock({ () -> Void in
                drawOrderController.applyAnimationOffsets(self.offsets)
            })
        }
        return result
    }
    
    func animationTime() -> Double {
        return self.time
    }
}