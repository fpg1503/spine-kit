//
//  SkinController.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 1/27/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//
import SpriteKit

class SkinController<SlotNode: SlotNodeType> {
    
    private let atlas: SlotNode.TextureAtlas
    private let skinsDict: [String: Skin] = [:]
    
    init(skins: [Skin], atlas: SlotNode.TextureAtlas) {
        self.atlas = atlas
        skins.forEach { skin in self.skinsDict[skin.name] = skin }
    }
    
    func changeSkin(name: String, slotsDict: [String: SlotNode]) {
        if let skin = self.skinsDict[name] {
            
            slotsDict.forEach { (slotName, slot) in
                if let attachmentsOfSlot = skin.attachments[slotName] {
                    
                    for (attachmentName, attachment) in attachmentsOfSlot {
                        slot.addAttachmentWithTexture(attachmentName, attachment: attachment, texture: atlas.textureNamed(attachment.name))
                        slot.setupPose()
                    }
                }
            }
        }
    }
    
    func skinExists(name: String?) -> Bool {
        var result: Bool = true
        if let name = name {
            result = self.skinsDict[name] != nil
        }
        return result
    }
    
    func findSkinByName(name: String) -> Skin? {
        return self.skinsDict[name]
    }
}
