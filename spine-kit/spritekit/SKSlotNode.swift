//
//  Slot+SKNode.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 1/17/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//

import SpriteKit

class SKSlotNode: SKNode {
    
    private var slot: Slot?
    private var attachmentsIndex: [String: SKAttachmentNode] = [:]
    private var currentAttachmentName: String?
    private var initialZIndex: Double?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    init(slot: Slot, zIndex: Double, region: [SKAttachmentNode]) {
        super.init()
        
        self.name = slot.name
        self.slot = slot
        self.initialZIndex = zIndex
        
        for attachment in region {
            
            attachment.hidden = true
            if let attachmentName = attachment.name {
                self.attachmentsIndex[attachmentName] = attachment
            }
            self.addChild(attachment)
        }
        
        if let slotAttachment = self.slot?.attachment {
            self.currentAttachmentName = slotAttachment
        }
    }
    
    func setupPose() {
        
        let node = SKNode()
        node.name = self.name

        var zIndex = self.initialZIndex ?? 0
        
        //If 1 is the step between slots 0.9 is a safe piece to share between attachments
        let zIndexIncrement = 0.9/Double(attachmentsIndex.count)
        
        for attachment in attachmentsIndex.values {
            
            attachment.zPosition = CGFloat(zIndex)
            attachment.hidden = true
            attachment.setupPose()
            zIndex += zIndexIncrement
            
        }

        if let slotAttachmentName = slot?.attachment {
            attachmentsIndex[slotAttachmentName]?.hidden = false
        }
    }
    
    func showAttachment(attachmentName: String) {
        if let currentAttachmentName = self.currentAttachmentName {
            attachmentsIndex[currentAttachmentName]?.hidden = false
            attachmentsIndex[attachmentName]?.hidden = true
        }
    }
}
