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
    
    private var maxZOrder: CGFloat = 0
    
    private let rootNodeName: String = "root"
    
    func build(name: String, skinName: String = "default") -> SKSpineNode? {
        
        var root: SKSpineNode? = nil

        let json = FileHelper.loadTextFile(name, type: "json")
        let spine = SpineParse().parse(name, data: json)
        let atlas = SKTextureAtlas(named: name)
        let currentSkin = findSkinByName(spine?.skins, name: spine?.defaultSkin)
        
        if let spine = spine, let bones = spine.bones, let slots = spine.slots, let animations = spine.animations, let skin = currentSkin {
            
            let bonesDict = buildBonesDict(bones)
            let zOrderIndexes = buildSlotZIndexDict(spine.slots)
            let slotsDict = buildSlotDict(slots, skin: skin, atlas: atlas, slotZIndexes: zOrderIndexes)
            let animationController = AnimationController(animations: animations, bonesDict: bonesDict, slotsDict: slotsDict, rootNode: bonesDict[self.rootNodeName])
            
            root = buildSpineRootNode(animationController, slots: slots, bonesDict:bonesDict, slotsDict: slotsDict)
            root?.setupPose()
            
            self.setupZOrderForRoot(root, zOrderIndexes: zOrderIndexes)
        }
        
        return root
    }
    
    private func buildSpineRootNode(animationController: AnimationController, slots: [Slot], bonesDict: [String: SKBoneNode], slotsDict: [String: SKSlotNode]) -> SKSpineNode? {
        
        let spineNode: SKSpineNode? = SKSpineNode(animationController: animationController)
        
        if let rootNode = bonesDict[self.rootNodeName] {
            
            spineNode?.addChild(rootNode)
            
            for slot in slots {

                if let bone = slot.bone {
                    let bone = bonesDict[bone]
                    
                    if let slotNode = slotsDict[slot.name] {
                        bone?.addSlot(slotNode)
                    }
                }
            }
        }
        
        return spineNode
    }
    
    
    private func buildBonesDict(bones: [Bone]) -> [String: SKBoneNode] {

        var boneDict: [String: SKBoneNode] = [:]
        
        if let rootBoneNode = bones.first {
            
            if rootBoneNode.name == self.rootNodeName {
                boneDict[self.rootNodeName] = SKBoneNode(bone: rootBoneNode)
                
                for bone in bones {

                    if let parentName = bone.parent {
                        
                        let parent = boneDict[parentName]
                        let boneNode = SKBoneNode(bone: bone)
                        
                        boneDict[bone.name] = boneNode
                        parent?.addChild(boneNode)
                    }
                }
            } else {
                print("Root node must be the first element in bones list")
            }
        }
        
        return boneDict
    }
    
    private func buildSlotDict(slots: [Slot], skin: Skin, atlas: SKTextureAtlas, slotZIndexes: [String: Double]) -> [String: SKSlotNode] {
        
        var slotNodes:  [String: SKSlotNode] = [:]
        
        for slot in slots {
            
            if let attachmentsOfSlot = skin.attachments[slot.name], let slotZIndex = slotZIndexes[slot.name] {
                
                let slotNode = SKSlotNode(slot: slot, zIndex: slotZIndex)
                for (attachmentName, attachment) in attachmentsOfSlot {
                    slotNode.addAttachmentWithTexture(attachmentName, attachment: attachment, texture: atlas.textureNamed(attachmentName))
                }
                
                slotNodes[slot.name] = slotNode
            }
        }
        return slotNodes
    }

    private func buildSlotZIndexDict(slots: [Slot]?) -> [String: Double] {
        
        var result: [String: Double] = [:]
        if let slots = slots {
            for (index, slot) in slots.enumerate() {
                result[slot.name] = Double(index)
            }
        }
        return result
    }
    
    //Avoid z fighting and improve Draw Calls
    private func setupZOrderForRoot(root: SKSpineNode?, zOrderIndexes: [String: Double]) {
        root?.zPosition = self.maxZOrder
        
        if let maxZOrder = zOrderIndexes.values.maxElement() {
            self.maxZOrder += CGFloat(maxZOrder) + 1
        }
    }
    
    private func findSkinByName(skins: [Skin]?, name: String?) -> Skin? {
        let skins = skins?.filter{ (skin) in skin.name == name }
        return skins?.count > 0 ? skins?.first : nil
    }
}