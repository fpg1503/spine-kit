//
//  SpineBuilder.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 12/18/15.
//  Copyright © 2015 Thiago Medeiros dos Santos. All rights reserved.
//

import Foundation

import SpriteKit

class SpineBuilder {
    
    let rootNodeName: String = "root"
    
    func build(name: String, skinName: String = "default") -> SKSpineRootNode? {

        let json = FileHelper.loadTextFile(name, type: "json")

        let spine = SpineParse().parse(name, data: json)
        
        let atlas = SKTextureAtlas(named: name)
        
        var root: SKSpineRootNode? = nil
        
        if let spine = spine {
            
            let skin = findSkinByName(spine.skins, name: spine.defaultSkin)
            let bonesDict = buildBonesTree(spine.bones)
            let slotZIndexes = buildSlotZIndexDict(spine.slots)
            
            if let slots = spine.slots, let skin = skin {
                root = buildSpineRootNode(bonesDict, slots: slots, skin: skin, atlas: atlas, slotZIndexes: slotZIndexes)
                root?.setup(spine, bonesDict:bonesDict)
            }
        }
        
        return root
    }
    
    private func buildSpineRootNode(bonesDict: [String: SKNode], slots: [Slot], skin: Skin, atlas: SKTextureAtlas, slotZIndexes: [String: Int]) -> SKSpineRootNode? {
        
        var result: SKSpineRootNode? = nil
        
        for slot in slots {
            
            let order = slotZIndexes[slot.name] ?? 0
            
            if let bone = slot.bone, let attachmentName = slot.attachment {
                
                let bone = bonesDict[bone]
                
                if let slotMap = skin.attachments[slot.name] {
                    
                    if let attachment = slotMap[attachmentName], let bone = bone {

                        let texture = atlas.textureNamed(attachmentName)
                        let attachmentNode = attachment.toSKNode(attachmentName, texture: texture, zIndex: order)
                        
                        bone.addChild(attachmentNode)
                    }
                }
            }
        }
        
        if let root = bonesDict[self.rootNodeName] as? SKSpineRootNode {
            result = root
        }
        
        return result
    }
    
    private func buildBonesTree(bones: [Bone]?) -> [String: SKNode] {

        let root = SKSpineRootNode()
        let rootNodeName = self.rootNodeName
        
        var boneMap: [String: SKNode] = [:]
        boneMap[rootNodeName] = root
        
        if let bones = bones {

            for bone in bones {

                if let parentName = bone.parent{
                    
                    let parent = boneMap[parentName]
                    let boneNode = bone.toSKNode(parent)
                    
                    boneMap[bone.name] = boneNode
                    parent?.addChild(boneNode)
                }
            }
        }
        return boneMap
    }
    
    private func buildSlotZIndexDict(slots: [Slot]?) -> [String: Int] {
        
        var result: [String: Int] = [:]
        if let slots = slots {
            for (index, slot) in slots.enumerate() {
                result[slot.name] = index
            }
        }
        return result
    }
    
    private func findSkinByName(skins: [Skin]?, name: String?) -> Skin? {
        let skins = skins?.filter{ (skin) in skin.name == name }
        return skins?.count > 0 ? skins?.first : nil
    }
}