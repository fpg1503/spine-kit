//
//  Slot+SKNode.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 1/17/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//

import SpriteKit

class SKSlotNode: SKSpriteNode {
    
    private var slot: Slot?
    private var region: [String: (attachment: Attachment, texture: SKTexture)] = [:]
    private var currentAttachmentName: String?
    private var initialZIndex: Double?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func addAttachmentWithTexture(name: String, attachment: Attachment, texture: SKTexture) {
        region[name] = (attachment, texture)
    }
    
    init(slot: Slot, zIndex: Double) {
        super.init(texture: SKTexture(), color: UIColor.clearColor(), size: CGSize.zero)

        self.name = slot.name
        self.slot = slot
        self.initialZIndex = zIndex
    }

    func setupPose() {
        
        let node = SKNode()
        node.name = self.name
        
        if let slotAttachmentName = slot?.attachment, let (attachment, _) = region[slotAttachmentName]  {
            
            self.showAttachment(slotAttachmentName)
            
            self.position = CGPoint(x: CGFloat(attachment.x), y: CGFloat(attachment.y))
            self.xScale = CGFloat(attachment.scaleX)
            self.yScale = CGFloat(attachment.scaleY)
            self.zRotation = CGFloat(attachment.rotation)
            self.zPosition = CGFloat(self.initialZIndex ?? 0)
            self.size = CGSize(width: CGFloat(attachment.width), height: CGFloat(attachment.height))
        }
    }
    
    func showAttachment(attachmentName: String) {

        if self.currentAttachmentName != attachmentName {
            if let (_, texture) = region[attachmentName] {
                self.texture = texture
                self.currentAttachmentName = attachmentName
            }
        }
    }
}
