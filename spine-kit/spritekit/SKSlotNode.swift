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

    private var currentAttachmentName: String? = ""
    
    private(set) var drawOrder: Double?
    
    private var drawOrderModifications: Int = 0
    
    init(slot: Slot) {
        super.init(texture: SKTexture(), color: UIColor.clearColor(), size: CGSize.zero)
        
        self.name = slot.name
        self.slot = slot
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func addAttachmentWithTexture(name: String, attachment: Attachment, texture: SKTexture) {
        region[name] = (attachment, texture)
    }

    func setDrawOrder(drawOrder: Double) {
        self.drawOrder = drawOrder
        self.zPosition = CGFloat(drawOrder + Double(drawOrderModifications))
    }
    
    func addDrawOrderModification(offset: Int) {
        self.drawOrderModifications += offset
        self.zPosition += CGFloat(offset)
    }
    
    func revertDrawOrderModifications() {
        self.zPosition -= CGFloat(self.drawOrderModifications)
        drawOrderModifications = 0
    }
    
    func setupPose() {
        let node = SKNode()
        node.name = self.name
        self.showAttachment(slot?.attachment ?? "")
    }
    
    func showAttachment(attachmentName: String) {

        if self.currentAttachmentName != attachmentName {
            
            if let (attachment, texture) = region[attachmentName] {
                
                self.texture = texture
                self.position = CGPoint(x: CGFloat(attachment.x), y: CGFloat(attachment.y))
                self.zRotation = CGFloat(attachment.rotation.degreesToRadians)
                self.zPosition = CGFloat(self.drawOrder ?? 0)
                self.size = CGSize(width: CGFloat(attachment.width), height: CGFloat(attachment.height))
               
                self.runAction(SKAction.scaleXBy(CGFloat(attachment.scaleX), y: CGFloat(attachment.scaleY), duration: 0))

                self.currentAttachmentName = attachmentName
            }
       }
    }
}
