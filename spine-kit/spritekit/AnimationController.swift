//
//  AnimationController.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 1/12/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//
import SpriteKit

typealias AnimationCallback = () -> Void

class AnimationController {
    
    private let animationsDict: [String: Animation] = [:]
    
    private  var bonesDict: [String: SKBoneNode] = [:]
    
    private var slotsDict: [String: SKSlotNode] = [:]
    
    private var rootNode: SKBoneNode? = nil
    
    private var playing = false
    
    private(set) var eventHandler: EventHandler = EventHandler()
    
    init(animations: [Animation]?, bonesDict: [String: SKBoneNode]?, slotsDict: [String: SKSlotNode]?, rootNode: SKBoneNode?) {

        if let bonesDict = bonesDict {
            self.bonesDict = bonesDict
         
        }

        if let slotsDict = slotsDict {
            self.slotsDict = slotsDict
        }
        
        if let animations = animations {
            animations.forEach{ animation in self.animationsDict[animation.name] = animation }
        }
        
        self.rootNode = rootNode
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
    
    func play(animationName: String, times: Int?, merge: Bool? = false, completion: AnimationCallback? = nil) {
        
        let animation: Animation? = self.animationsDict[animationName]

        if  let animation = animation, let merge = merge {
        
            if self.playing && !merge {
                self.stop()
            }
            
            self.addCompletionTimeline(
                self.addActionsToBones(animation, times: times),
                self.addActionsToSlots(animation, times: times),
                self.addEventsToEventNode(animation, times: times),
                times: times,
                completion: completion)
            
            self.playing = true
        }
    }
    
    private func addCompletionTimeline(durations: Double..., times: Int?, completion: AnimationCallback?) {
        
        if let block = completion, let duration = durations.maxElement() {

            let completionTimeline = TimelineBuilder().buildTimelineSKActions([
                    SKAction.waitForDuration(duration),
                    SKAction.runBlock({
                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                            block()
                        }
                    })
                ], times: times)
            
            if let completionAction = completionTimeline.action {
                self.rootNode?.runAction(completionAction)
            }
        }
    }
    
    private func addEventsToEventNode(animation: Animation, times: Int?) -> Double {
        var duration: Double = 0
        
        if !animation.eventsTimeline.isEmpty {
        
            let timelineBuilder = TimelineBuilder()
            let eventActions: [SKAction]? = timelineBuilder.buildSKActionsTimeline(self.eventHandler, keyframes: animation.eventsTimeline)
            let timeline = timelineBuilder.buildTimelineSKActions(eventActions, times: times)
        
            if let  action = timeline.action {
                self.rootNode?.runAction(action)
            }
            
            duration = timeline.duration
        }
        return duration
    }
    
    private func addActionsToBones(animation: Animation, times: Int?) -> Double {
        var duration: Double = 0
        
        for boneTimeline in animation.boneTimelines {
            
            if let boneName = boneTimeline.name, let bone = self.bonesDict[boneName] {
                
                let timelineBuilder = TimelineBuilder()
                let translateActions: [SKAction]? = timelineBuilder.buildSKActionsTimeline(bone, keyframes: boneTimeline.translate)
                let scaleActions: [SKAction]? = timelineBuilder.buildSKActionsTimeline(bone, keyframes: boneTimeline.scale)
                let rotateActions: [SKAction]? = timelineBuilder.buildSKActionsTimeline(bone, keyframes: boneTimeline.rotate)
                
                let group = timelineBuilder.buildTimelinesSKActionGroup(translateActions, scaleActions, rotateActions, times: times)
                
                if let action = group.action {
                    bone.runAction(action)
                    duration = group.duration
                }
            }
        }
        return duration
    }
    
    private func addActionsToSlots(animation: Animation, times: Int?) -> Double {
        var duration: Double = 0
        
        for slotTimeline in animation.slotTimelines {
            
            if let slotName = slotTimeline.name, let slot = self.slotsDict[slotName] {
                
                let timelineBuilder = TimelineBuilder()
                let colorActions: [SKAction]? = timelineBuilder.buildSKActionsTimeline(slot, keyframes: slotTimeline.color)
                let attachmentActions: [SKAction]? = timelineBuilder.buildSKActionsTimeline(slot, keyframes: slotTimeline.attachment)

                let group = timelineBuilder.buildTimelinesSKActionGroup(colorActions, attachmentActions, times: times)
                
                if let action = group.action {
                    slot.runAction(action)
                    duration = group.duration
                }
            }
        }
        return duration
    }
    
    deinit {
        self.stop()
    }
}
