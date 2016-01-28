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
    
    func build(name: String, skin skinName: String? = nil) -> SKSpineNode? {
        
        var root: SKSpineNode? = nil

        let json = FileHelper.loadTextFile(name, type: "json")
        let spine = SpineParse().parse(name, data: json)
        let atlas = SKTextureAtlas(named: name)
        let drawOrderController = DrawOrderController()

        if let spine = spine, let bones = spine.bones, let slots = spine.slots, let skins = spine.skins, let animations = spine.animations {
            
            let skinController = SkinController(skins: skins, atlas: atlas)
            let bonesDict = buildBonesDict(bones)
            let slotsDict = buildSlotDict(slots, skinController: skinController, skinName: skinName, atlas: atlas)
            
            let animationController = AnimationController(rootNode: bonesDict[self.rootNodeName], animations: animations)
            
            //In this version you must provide a initial skin if you want to be able to change skins
            let canChangeSkin = skinController.skinExists(skinName)
            
            root = buildSpineRootNode(
                animationController: animationController,
                skinController: skinController,
                drawOrderController: drawOrderController,
                spine: spine,
                bonesDict:bonesDict,
                slotsDict: slotsDict,
                canChangeSkin: canChangeSkin)
            
            drawOrderController.setupDrawOrder(spine.slots, slotsDict: slotsDict, root: root)
            
            root?.setupPose()
        }
        
        return root
    }
    
    private func buildSpineRootNode(animationController animationController: AnimationController, skinController: SkinController, drawOrderController: DrawOrderController, spine: SpineModel, bonesDict: [String: SKBoneNode], slotsDict: [String: SKSlotNode], canChangeSkin: Bool) -> SKSpineNode? {
        
        let spineNode = SKSpineNode(
            animationController: animationController,
            skinController: skinController,
            drawOrderController: drawOrderController,
            bonesDict: bonesDict, slotsDict: slotsDict,
            canChangeSkin: canChangeSkin)
        
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
    
    private func buildSlotDict(slots: [Slot], skinController: SkinController, skinName: String?, atlas: SKTextureAtlas) -> [String: SKSlotNode] {
        
        let defaultSkinName = "default"
        var slotNodes:  [String: SKSlotNode] = [:]
        var skinDefault: Skin?
        
        if let skin = skinController.findSkinByName(defaultSkinName) {
            skinDefault = skin
        }

        for slot in slots {
            let slotNode = SKSlotNode(slot: slot)

            if let skinDefault = skinDefault {
                self.addAttachmentsToSlotNode(attachments: skinDefault.attachments[slot.name], slotNode: slotNode, atlas: atlas)
            }
            slotNodes[slot.name] = slotNode
        }
        
        if let skinName = skinName {
            skinController.changeSkin(skinName, slotsDict: slotNodes)
        }
        
        return slotNodes
    }
    
    private func addAttachmentsToSlotNode(attachments attachmentsOfSlot: [String: Attachment]?, slotNode: SKSlotNode, atlas: SKTextureAtlas) -> SKSlotNode {
        if let attachments = attachmentsOfSlot {
            for (attachmentName, attachment) in attachments {
                slotNode.addAttachmentWithTexture(attachmentName, attachment: attachment, texture: atlas.textureNamed(attachmentName))
            }
        }
        return slotNode
    }
}