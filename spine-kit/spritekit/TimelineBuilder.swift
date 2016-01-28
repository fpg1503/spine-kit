//
//  TimelineBuilder.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 1/21/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//

import SpriteKit

class TimelineBuilder {
    
    private(set) var maxDuration: Double = 0
    
    init(finalKeyframes keyframes: [SKActionKeyFrame]) {
        self.setupMaxDuration(keyframes)
    }
    
    func buildTimelineSKActions(sequence: [SKAction]?, times: Int?) -> (duration: Double, action: SKAction?) {
        
        var action: SKAction? = nil
        var duration: Double = 0
        
        if let sequence = sequence {
            
            let isDurationTimeZero = (sequence.first?.duration ==  0 && sequence.count == 1)
            
            let sequenceAction = SKAction.sequence(sequence)
            
            if isDurationTimeZero {
                action = sequenceAction
            } else {
                action = self.buildRepeatAction(sequenceAction, times: times)
            }
            
            duration = sequenceAction.duration
        }
        return (duration: duration, action: action)
    }
    
    func buildTimelinesSKActionGroup(timelineSequences: [SKAction]?..., times: Int?) -> (duration: Double, action: SKAction?) {
        
        var result: SKAction? = nil
        var sequences: [SKAction] = []
        var maxDuration: Double = 0
        
        timelineSequences.forEach { sequence in
            
            if let sequence = sequence where !sequence.isEmpty {
                
                let timeline = self.buildTimelineSKActions(sequence, times: times)
                
                if let action =  timeline.action {

                    if timeline.duration > maxDuration {
                        maxDuration = timeline.duration
                    }
                    sequences.append(action)
                }
            }
        }
        
        if !sequences.isEmpty {
            result = SKAction.group(sequences)
        }
        
        return (duration: maxDuration, action: result)
    }
    
    func buildSKActionsTimeline<T: SKActionKeyFrame, Data>(data: Data, keyframes: [T]) -> [SKAction]? {
        
        var actions: [SKAction] = []
        var previousElement: SKActionKeyFrame?
        var duration: Double = 0
        
        previousElement = keyframes.first
        
        if var previousElement = previousElement {

            if let action = previousElement.toSKAction(data, duration: previousElement.animationTime(), curve: previousElement.curveToApply()) {
                actions.append(action)
            }

            keyframes.dropFirst().forEach  { keyframe in
                
                duration = keyframe.animationTime() - previousElement.animationTime()
                
                if let action = keyframe.toSKAction(data, duration: duration, curve: previousElement.curveToApply()) {
                    actions.append(action)
                    previousElement = keyframe
                }
            }
            
        }
        return actions.isEmpty ? nil : actions
    }
    
    private func setupMaxDuration(keyFrames: [SKActionKeyFrame]) {
        
        keyFrames.forEach { keyframe in
            
            let keyFrameDuration: Double = keyframe.animationTime() ?? 0
            
            if self.maxDuration < keyFrameDuration {
                self.maxDuration = keyFrameDuration
            }
        }
    }
    
    private func buildRepeatAction(sequenceToRepeat: SKAction, times: Int?) -> SKAction? {

        var action: SKAction? = nil
        
        if sequenceToRepeat.duration < self.maxDuration {

            let durationOffset =  self.maxDuration - sequenceToRepeat.duration
            action = SKAction.repeatAction(SKAction.sequence([sequenceToRepeat, SKAction.waitForDuration(durationOffset)]), count: times ?? Int.max)
            action?.speed = 0.2
        } else {
            
            action = SKAction.repeatAction(sequenceToRepeat, count: times ?? Int.max)
        }
        return action
    }
}