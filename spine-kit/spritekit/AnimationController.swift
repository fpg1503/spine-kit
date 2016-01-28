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

    private var timelineBuilder: TimelineBuilder? = nil
    
    private var rootNode: SKBoneNode? = nil
    
    private var playing = false
    
    private(set) var eventHandler: EventHandler = EventHandler()
    
    init(rootNode: SKBoneNode?, animations: [Animation]?) {

        self.rootNode = rootNode
        
        if let animations = animations {
            animations.forEach{ animation in self.animationsDict[animation.name] = animation }
        }
    }

    func stop(bonesDict bonesDict: [String: SKBoneNode]?, slotsDict: [String: SKSlotNode]?) {
        bonesDict?.forEach { (_, bone) in bone.removeAllActions() }
        slotsDict?.forEach { (_, slot) in slot.removeAllActions() }
        self.rootNode?.setupPose()
        self.playing = false
    }
    
    func setupPose(bonesDict: [String: SKBoneNode]?) {
        bonesDict?.forEach { (_, bone) in bone.setupPose() }
    }
    
    func animate(animationName: String, bonesDict: [String: SKBoneNode]?, slotsDict: [String: SKSlotNode]?, times: Int?, merge: Bool? = false, completion: AnimationCallback? = nil) {
        
        let animation: Animation? = self.animationsDict[animationName]

        if  let animation = animation, let merge = merge {
        
            if self.playing && !merge {
                self.stop(bonesDict: bonesDict, slotsDict: slotsDict)
            }

            self.timelineBuilder = self.createTimelineBuilder(animation)
            
            self.addActionsToBones(animation, bonesDict: bonesDict, times: times)
            self.addActionsToSlots(animation, slotsDict: slotsDict, times: times)
            self.addEventsToRootNode(animation, times: times)
            self.addDrawOrderToRootNode(animation, slotsDict: slotsDict, times: times)
            self.addCompletionTimeline(times: times, completion: completion)
            
            self.playing = true
        }
    }
    
    private func addCompletionTimeline(times times: Int?, completion: AnimationCallback?) {
        
        if let block = completion, let timelineBuilder = self.timelineBuilder {

            let completionTimeline = timelineBuilder.buildTimelineSKActions([
                    SKAction.waitForDuration(timelineBuilder.maxDuration),
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
    
    private func addEventsToRootNode(animation: Animation, times: Int?) {
        
        if let timelineBuilder = self.timelineBuilder where !animation.eventsTimeline.isEmpty {
        
            let eventActions: [SKAction]? = timelineBuilder.buildSKActionsTimeline(self.eventHandler, keyframes: animation.eventsTimeline)
            let timeline = timelineBuilder.buildTimelineSKActions(eventActions, times: times)
        
            if let  action = timeline.action {
                self.rootNode?.runAction(action)
            }
        }
    }
    
    private func addDrawOrderToRootNode(animation: Animation, slotsDict: [String: SKSlotNode]?, times: Int?) {
        
        if let timelineBuilder = self.timelineBuilder, let slotsDict = slotsDict where !animation.drawOrderTimeline.isEmpty {
            
            let drawOrderActions: [SKAction]? = timelineBuilder.buildSKActionsTimeline(slotsDict, keyframes: animation.drawOrderTimeline)
            let timeline = timelineBuilder.buildTimelineSKActions(drawOrderActions, times: times)
            
            if let  action = timeline.action {
                self.rootNode?.runAction(action)
            }
        }
    }
    
    private func addActionsToBones(animation: Animation, bonesDict: [String: SKBoneNode]?, times: Int?) {
        
        for boneTimeline in animation.boneTimelines {
            
            if let boneName = boneTimeline.name, let bone = bonesDict?[boneName], let timelineBuilder = self.timelineBuilder {
                
                let translateActions: [SKAction]? = timelineBuilder.buildSKActionsTimeline(bone, keyframes: boneTimeline.translate)
                let scaleActions: [SKAction]? = timelineBuilder.buildSKActionsTimeline(bone, keyframes: boneTimeline.scale)
                let rotateActions: [SKAction]? = timelineBuilder.buildSKActionsTimeline(bone, keyframes: boneTimeline.rotate)
                
                let group = timelineBuilder.buildTimelinesSKActionGroup(translateActions, scaleActions, rotateActions, times: times)
                
                if let action = group.action {
                    bone.runAction(action)
                }
            }
        }
    }
    
    private func addActionsToSlots(animation: Animation, slotsDict: [String: SKSlotNode]?, times: Int?) {
        
        for slotTimeline in animation.slotTimelines {
            
            if let slotName = slotTimeline.name, let slot = slotsDict?[slotName], let timelineBuilder = self.timelineBuilder {
                
                let colorActions: [SKAction]? = timelineBuilder.buildSKActionsTimeline(slot, keyframes: slotTimeline.color)
                let attachmentActions: [SKAction]? = timelineBuilder.buildSKActionsTimeline(slot, keyframes: slotTimeline.attachment)

                let group = timelineBuilder.buildTimelinesSKActionGroup(colorActions, attachmentActions, times: times)
                
                if let action = group.action {
                    slot.runAction(action)
                }
            }
        }
    }
    
    private func createTimelineBuilder(animation: Animation) -> TimelineBuilder {
        
        var keyframes: [SKActionKeyFrame] = []
        animation.slotTimelines.forEach { timeline in
            timeline.attachment.forEach { keyframe in keyframes.append(keyframe)}
            timeline.color.forEach { keyframe in keyframes.append(keyframe)}
        }
        
        animation.boneTimelines.forEach { timeline in
            timeline.translate.forEach { keyframe in keyframes.append(keyframe)}
            timeline.rotate.forEach { keyframe in keyframes.append(keyframe)}
            timeline.scale.forEach { keyframe in keyframes.append(keyframe)}
        }
        
        animation.eventsTimeline.forEach { keyframe in keyframes.append(keyframe)}
        animation.drawOrderTimeline.forEach { keyframe in keyframes.append(keyframe)}
        
        return TimelineBuilder(keyframes: keyframes)
    }
}
