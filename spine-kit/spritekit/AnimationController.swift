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
        return nil
    }
    
    func play(animationName: String) {
        
        let animation: Animation? = self.animationsDict[animationName]
        
        if  let animation = animation {
            self.addActionsToBones(animation)
            self.addActionsToSlots(animation)
        }
    }
    
    private func addActionsToBones(animation: Animation) {
        
        for boneTimeline in animation.boneTimelines {
            
            if let boneName = boneTimeline.name, let bone = self.bonesDict[boneName] {
                
                let translateActions: [SKAction]? = self.buildSKActionsTimeline(bone, keyframes: boneTimeline.translate)
                let scaleActions: [SKAction]? = self.buildSKActionsTimeline(bone, keyframes: boneTimeline.scale)
                let rotateActions: [SKAction]? = self.buildSKActionsTimeline(bone, keyframes: boneTimeline.rotate)
                
                if let group = self.buildTimelinesGroup(translateActions, scaleActions, rotateActions) {
                    bone.runAction(group)
                }
            }
        }
    }
    
    private func addActionsToSlots(animation: Animation) {
        
        for slotTimeline in animation.slotTimelines {
            
            if let slotName = slotTimeline.name, let slot = self.slotsDict[slotName] {
                
                let colorActions: [SKAction]? =  nil //self.buildSKActionsTimeline(slot, keyframes: slotTimeline.color)
                let attachmentActions: [SKAction]? = self.buildSKActionsTimeline(slot, keyframes: slotTimeline.attachment)
                if let group = self.buildTimelinesGroup(colorActions, attachmentActions) {
                    slot.runAction(group)
                }
            }
        }
    }
    
    private func buildTimelinesGroup(timelineSequences: [SKAction]?...) -> SKAction? {

        var result: SKAction? = nil
        var sequences: [SKAction] = []
        
        for sequence in timelineSequences {

            if let sequence = sequence {
                if !sequence.isEmpty {
                    
                    let isDurationTimeZero = (sequence.first?.duration ==  0 && sequence.count == 1)
                    if isDurationTimeZero {
                        sequences.append(SKAction.sequence(sequence))
                    } else {
                        sequences.append(SKAction.repeatActionForever(SKAction.sequence(sequence)))
                    }
                }
            }
        }
        
        if !sequences.isEmpty {
            result = SKAction.group(sequences)
        }
        return result
    }
    
    private func buildSKActionsTimeline<T: SKActionKeyFrame>(nodeToAnimate: SKNode, keyframes: [T]) -> [SKAction]? {
        var lastFrameTime: Double = 0
        var actions: [SKAction] = []
    
        keyframes.forEach  { keyFrame in
            if let action = keyFrame.toSKAction(nodeToAnimate, timeOffset: lastFrameTime, curve: keyFrame.animationData().curve) {
                actions.append(action)
                lastFrameTime = keyFrame.animationData().time
            }
        }
        return actions.isEmpty ? nil : actions
    }
    
}
