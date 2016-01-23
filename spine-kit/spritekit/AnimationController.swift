//
//  AnimationController.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 1/12/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//
import SpriteKit

class AnimationController {
    
    let animationsDict: [String: Animation] = [:]
    var bonesDict: [String: SKBoneNode] = [:]
    var slotsDict: [String: SKSlotNode] = [:]
    
    init(animations: [Animation]?, bonesDict: [String: SKBoneNode]?, slotsDict: [String: SKSlotNode]?) {

        if let bonesDict = bonesDict {
            self.bonesDict = bonesDict
        }
        
        if let slotsDict = slotsDict {
            self.slotsDict = slotsDict
        }
        
        if let animations = animations {
            animations.forEach{ animation in self.animationsDict[animation.name] = animation }
        }
    }
    
    func findAnimatedNode(name: String) -> SKNode? {
        var result: SKNode? = nil
        
        if let node = self.bonesDict[name] {
            result = node
        } else if let node = self.slotsDict[name] {
            result = node
        }
    
        return result
    }
    
    func play(animationName: String, times: Int?) {
        
        let animation: Animation? = self.animationsDict[animationName]
        
        if  let animation = animation {
            self.addActionsToBones(animation, times: times)
            self.addActionsToSlots(animation, times: times)
        }
    }
    
    private func addActionsToBones(animation: Animation, times: Int?) {
        
        for boneTimeline in animation.boneTimelines {
            
            if let boneName = boneTimeline.name, let bone = self.bonesDict[boneName] {
                
                let timelineBuilder = TimelineBuilder()
                let translateActions: [SKAction]? = timelineBuilder.buildSKActionsTimeline(bone, keyframes: boneTimeline.translate)
                let scaleActions: [SKAction]? = timelineBuilder.buildSKActionsTimeline(bone, keyframes: boneTimeline.scale)
                let rotateActions: [SKAction]? = timelineBuilder.buildSKActionsTimeline(bone, keyframes: boneTimeline.rotate)
                
                if let group = timelineBuilder.buildTimelinesSKActionGroup(translateActions, scaleActions, rotateActions, times: times) {
                    bone.runAction(group)
                }
            }
        }
    }
    
    private func addActionsToSlots(animation: Animation, times: Int?) {
        
        for slotTimeline in animation.slotTimelines {
            
            if let slotName = slotTimeline.name, let slot = self.slotsDict[slotName] {
                
                let timelineBuilder = TimelineBuilder()
                let colorActions: [SKAction]? = timelineBuilder.buildSKActionsTimeline(slot, keyframes: slotTimeline.color)
                let attachmentActions: [SKAction]? = timelineBuilder.buildSKActionsTimeline(slot, keyframes: slotTimeline.attachment)
                
                if let group = timelineBuilder.buildTimelinesSKActionGroup(colorActions, attachmentActions, times: times) {
                    slot.runAction(group)
                }
            }
        }
    }}
