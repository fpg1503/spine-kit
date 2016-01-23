//
//  AttachmentKeyFrame+SKAction.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 1/12/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//

import SpriteKit

extension AttachmentKeyFrame: SKActionKeyFrame {
    
    func linearAction<Context>(context: Context, duration: Double) -> SKAction? {
    
        let attachmentName = self.name
        
        return SKAction.runBlock({ () -> Void in
                if let slotNode = context as? SKSlotNode, let attachmentName = attachmentName {
                    slotNode.showAttachment(attachmentName)
                }
            })
    }
    
    func animationData() -> (time: Double, curve: Curve) {
        return (self.time,  Curve.Stepped)
    }
}