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
    
    private let rootNodeName: String = "root"
    
    func build(name: String, skinName: String = "default") -> SKSpineNode? {
        
        var root: SKSpineNode? = nil

        let json = FileHelper.loadTextFile(name, type: "json")
        let spine = SpineParse().parse(name, data: json)
        let atlas = SKTextureAtlas(named: name)
        let drawOrderController = DrawOrderController()

        let skinController = SkinController(skins: spine?.skins)
        
        let currentSkin = skinController.findSkinByName(spine?.defaultSkin)
        
        if let spine = spine, let bones = spine.bones, let slots = spine.slots, let animations = spine.animations, let skin = currentSkin {
            
            let bonesDict = buildBonesDict(bones)
            let slotsDict = buildSlotDict(slots, skin: skin, atlas: atlas)

            let animationController = AnimationController(rootNode: bonesDict[self.rootNodeName], animations: animations)
            
            root = buildSpineRootNode(
                animationController: animationController,
                skinController: skinController,
                drawOrderController: drawOrderController,
                spine: spine,
                bonesDict:bonesDict,
                slotsDict: slotsDict)
            
            drawOrderController.setupDrawOrder(spine.slots, slotsDict: slotsDict, root: root)
            
            root?.setupPose()
        }
        
        return root
    }
    
    private func buildSpineRootNode(animationController animationController: AnimationController, skinController: SkinController, drawOrderController: DrawOrderController, spine: SpineModel, bonesDict: [String: SKBoneNode], slotsDict: [String: SKSlotNode]) -> SKSpineNode? {
        
        let spineNode = SKSpineNode(
            animationController: animationController,
            skinController: skinController,
            drawOrderController: drawOrderController,
            bonesDict: bonesDict, slotsDict: slotsDict)
        
        if let rootNode = bonesDict[self.rootNodeName], slots = spine.slots {
            
            spineNode.addChild(rootNode)
            
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
    
    private func buildSlotDict(slots: [Slot], skin: Skin, atlas: SKTextureAtlas) -> [String: SKSlotNode] {
        
        var slotNodes:  [String: SKSlotNode] = [:]
        
        for slot in slots {
            
            if let attachmentsOfSlot = skin.attachments[slot.name] {
                
                let slotNode = SKSlotNode(slot: slot)
                for (attachmentName, attachment) in attachmentsOfSlot {
                    slotNode.addAttachmentWithTexture(attachmentName, attachment: attachment, texture: atlas.textureNamed(attachmentName))
                }
                
                slotNodes[slot.name] = slotNode
            }
        }
        return slotNodes
    }
}