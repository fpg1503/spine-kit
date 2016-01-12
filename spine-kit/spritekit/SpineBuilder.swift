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
    
    func build(name: String, skinName: String = "default") -> SKNode {

        let json = FileHelper.loadTextFile(name, type: "json")

        let spine = SpineParse().parse(name, data: json)
        
        let atlas = SKTextureAtlas(named: name)
        
        var root = SKSpineRootNode()
        
        if let spine = spine {
            
            let skin = findSkinByName(spine.skins, name: spine.defaultSkin)
            let slotZIndexes = createSlotZIndexDict(spine.slots)
            let (boneRoot, bonesMap) = createBonesTree(spine.bones)
            
            if let slots = spine.slots, let skin = skin {
                root = createSpineRootNode(boneRoot, bonesMap: bonesMap, slots: slots, skin: skin, atlas: atlas, slotZIndexes: slotZIndexes)
            }
        }
        
        return root
    }
    
    private func createSpineRootNode(root: SKSpineRootNode, bonesMap: [String: SKNode], slots: [Slot], skin: Skin, atlas: SKTextureAtlas, slotZIndexes: [String: Int]) -> SKSpineRootNode {
        
        for slot in slots {
            
            let order = slotZIndexes[slot.name] ?? 0
            
            if let bone = slot.bone, let attachmentName = slot.attachment {
                
                let bone = bonesMap[bone]
                
                if let slotMap = skin.attachments[slot.name] {
                    
                    if let attachment = slotMap[attachmentName], let bone = bone {

                        let texture = atlas.textureNamed(attachmentName)
                        let attachmentNode = attachment.toSKNode(attachmentName, texture: texture, zIndex: order)
                        
                        bone.addChild(attachmentNode)
                    }
                }
            }
        }
        return root
    }
    
    private func createBonesTree(bones: [Bone]?) -> (SKSpineRootNode, [String: SKNode]) {

        let root = SKSpineRootNode()
        let rootNodeName = "root"
        
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
        return (root, boneMap)
    }
    
    private func createSlotZIndexDict(slots: [Slot]?) -> [String: Int] {
        
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