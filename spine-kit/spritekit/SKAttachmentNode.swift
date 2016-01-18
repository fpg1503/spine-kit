//
//  Attachment+SpriteKit.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 1/12/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//

import SpriteKit

class SKAttachmentNode: SKSpriteNode {
    
    private var attachment: Attachment?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(attachment: Attachment, name: String, texture: SKTexture) {
        
        super.init(texture: texture, color: UIColor.clearColor(), size: CGSize(width: CGFloat(attachment.width), height: CGFloat(attachment.height)))
        self.name = name
        self.attachment = attachment
    }
    
    func setupPose() {
        
        if let attachment = self.attachment {
            
            self.xScale = CGFloat(attachment.scaleX)
            self.yScale = CGFloat(attachment.scaleY)
            self.position = CGPoint(x: CGFloat(attachment.x), y: CGFloat(attachment.y))
            self.zRotation = attachment.rotation.degreesToRadians
        }
    }
}