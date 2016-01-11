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
    
    func buildSpine(name: String, skinName: String = "default", completion: (SKNode) -> Void) {

        let json = FileHelper.loadTextFile(name, type: "json")

        let spine = SpineParse().parse(name, data: json)
        
        let atlas = AtlasBuilder().buildFromResources(name)
        
        let slotZIndexes = createSlotZIndexDict(spine?.slots)
        
        let skin = findSkinByName(spine?.skins, name: spine?.defaultSkin)
        
        let (root, bonesMap) = createBonesTree(spine?.bones)
        
        if let slots = spine?.slots, let skin = skin, let atlas = atlas {
            
            for slot in slots {
            
                let order = slotZIndexes[slot.name] ?? 0
                
                if let bone = slot.bone, let attachmentName = slot.attachment {
                    let bone = bonesMap[bone]
                    if let slotMap = skin.attachments[slot.name] {
                        if let attachment = slotMap[attachmentName]{
                            let attachmentNode = setupAttachment(attachment, name: attachmentName, atlas: atlas, zIndex: order)
                            bone?.addChild(attachmentNode)
                        }
                    }
                }
            }
        }
    
        completion(root)
    }
    
    func createBonesTree(bones: [Bone]?) -> (SKNode, [String: SKNode]) {
        let root = SKNode()
        
        var boneMap: [String: SKNode] = [:]
        boneMap["root"] = root
        
        if let bones = bones {
            for bone in bones {
                
                if let parentName = bone.parent{
                    
                    let parent = boneMap[parentName]
                    
                    let boneNode = setupBone(bone, parent: parent)
                    
                    boneMap[bone.name] = boneNode
                    parent?.addChild(boneNode)
                    
                }
            }
        }
        return (root, boneMap)
    }
    
    func setupBone(bone: Bone, parent: SKNode?) -> SKNode {
        let boneNode = SKNode()
        // TODO check what bone lenght means
        boneNode.name = bone.name
        boneNode.position = CGPoint(x: CGFloat(bone.x), y: CGFloat(bone.y))

        if bone.inheritRotation {
            if let parentRotation = parent?.zRotation {
                boneNode.zRotation = (boneNode.zRotation + parentRotation)
            }
        } else {
            boneNode.zRotation = CGFloat(CGFloat(bone.rotation) * CGFloat(M_PI) / 180.0)
        }
        
        if bone.inheritScale {
            
            if let parentXScale = parent?.xScale, let parentYScale = parent?.yScale {
                boneNode.runAction(SKAction.scaleXTo(CGFloat(parentXScale + CGFloat(bone.scaleX)), duration: 0.0))
                boneNode.runAction(SKAction.scaleYTo(CGFloat(parentYScale + CGFloat(bone.scaleY)), duration: 0.0))
            }
            
        } else {
            boneNode.runAction(SKAction.scaleXTo(CGFloat(bone.scaleX), duration: 0.0))
            boneNode.runAction(SKAction.scaleYTo(CGFloat(bone.scaleY), duration: 0.0))
        }
        return boneNode
    }
    
    func setupAttachment(attachment: Attachment, name: String, atlas:SKTextureAtlas, zIndex: Int) -> SKNode {
        
        let element = SKSpriteNode(texture: atlas.textureNamed(name), size: CGSize(width: CGFloat(attachment.width), height: CGFloat(attachment.height)))
        
        element.runAction(SKAction.scaleXTo(CGFloat(attachment.scaleX), duration: 0.0))
        element.runAction(SKAction.scaleYTo(CGFloat(attachment.scaleY), duration: 0.0))
        
        element.position = CGPoint(x: CGFloat(attachment.x), y: CGFloat(attachment.y))
        element.zRotation = CGFloat(CGFloat(attachment.rotation) * CGFloat(M_PI) / 180.0)
        element.zPosition = CGFloat(zIndex)
        
        return element
    }
    
    func createSlotZIndexDict(slots: [Slot]?) -> [String: Int] {
        
        var result: [String: Int] = [:]
        if let slots = slots {
            for (index, slot) in slots.enumerate() {
                result[slot.name] = index
            }
        }
        return result
    }
    
    func findSkinByName(skins: [Skin]?, name: String?) -> Skin? {
        let skins = skins?.filter{ (skin) in skin.name == name }
        return skins?.count > 0 ? skins?.first : nil
    }
}