//
//  SlotNodeType.swift
//  spine-kit
//
//  Created by Francesco Perrotti-Garcia on 2/5/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//

import Foundation

protocol SlotNodeType: NodeType {
    typealias TextureAtlas: TextureAtlasType //TODO: Review this

    var drawOrder: Double? { get }
    
    init(slot: Slot)
    
    func addAttachmentWithTexture(name: String, attachment: Attachment, texture: TextureAtlas.Texture)
    
    func setDrawOrder(drawOrder: Double)
    
    func addDrawOrderModification(offset: Int)
    func revertDrawOrderModifications()
    
    func setupPose()
    func showAttachment(attachmentName: String)
}
