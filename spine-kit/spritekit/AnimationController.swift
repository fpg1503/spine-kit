//
//  AnimationController.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 1/12/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//
import SpriteKit

class AnimationController {
    
    private let animationsDict: [String: Animation] = [:]
    
    private  var bonesDict: [String: SKBoneNode] = [:]
    
    private var slotsDict: [String: SKSlotNode] = [:]
    
    private var rootNode: SKBoneNode? = nil
    
    private var playing = false
    
    private(set) var eventHandler: EventHandler = EventHandler()
    
    init(animations: [Animation]?, bonesDict: [String: SKBoneNode]?, slotsDict: [String: SKSlotNode]?) {

        if let bonesDict = bonesDict {
            self.bonesDict = bonesDict
            self.rootNode = self.bonesDict[SpineBuilder.rootNodeName]
        }
        
        if let slotsDict = slotsDict {
            self.slotsDict = slotsDict
        }
        
        if let animations = animations {
            animations.forEach{ animation in self.animationsDict[animation.name] = animation }
       }
    }
    
    func findAnimatedNode(name: String) -> SKNode? {
        return (self.bonesDict[name] ?? self.slotsDict[name]) ?? nil
    }
    
    func stop() {
        self.bonesDict.forEach { (_, bone) in bone.removeAllActions() }
        self.slotsDict.forEach { (_, slot) in slot.removeAllActions() }
        self.rootNode?.setupPose()
        self.playing = false
    }
    
    func play(animationName: String, times: Int?) {
        
        let animation: Animation? = self.animationsDict[animationName]

        if  let animation = animation {
        
            if self.playing {
                self.stop()
            }
            
            self.addActionsToBones(animation, times: times)
            self.addActionsToSlots(animation, times: times)
            self.addEventsToEventNode(animation, times: times)
            self.playing = true
        }
    }
    
    private func addEventsToEventNode(animation: Animation, times: Int?) {
        
        if !animation.eventsTimeline.isEmpty {
            let timelineBuilder = TimelineBuilder()
            let eventActions: [SKAction]? = timelineBuilder.buildSKActionsTimeline(self.eventHandler, keyframes: animation.eventsTimeline)
            
            if let action = timelineBuilder.buildTimelineSKActions(eventActions, times: times) {
                self.rootNode?.runAction(action)
            }
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
    }
    
    deinit {
        self.stop()
    }
}
