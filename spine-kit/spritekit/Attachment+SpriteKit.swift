//
//  Attachment+SpriteKit.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 1/12/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//

import SpriteKit

extension Attachment {
    
    func toSKNode(contextName: String, texture:SKTexture, zIndex: Int) -> SKNode {
        
        let attachmentNode = SKSpriteNode(texture: texture, size: CGSize(width: CGFloat(self.width), height: CGFloat(self.height)))
        
        attachmentNode.xScale = CGFloat(self.scaleX)
        attachmentNode.yScale = CGFloat(self.scaleY)
        attachmentNode.position = CGPoint(x: CGFloat(self.x), y: CGFloat(self.y))
        attachmentNode.zRotation = CGFloat(CGFloat(self.rotation) * CGFloat(M_PI) / 180.0)
        attachmentNode.zPosition = CGFloat(zIndex)
        
        return attachmentNode
    }
    
}