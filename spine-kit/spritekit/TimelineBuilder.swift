//
//  TimelineBuilder.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 1/21/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//

import SpriteKit

class TimelineBuilder {

    func buildTimelineSKActions(sequence: [SKAction]?, times: Int?) -> (duration: Double, action: SKAction?) {
        
        var action: SKAction? = nil
        var duration: Double = 0
        
        if let sequence = sequence {
            
            let isDurationTimeZero = (sequence.first?.duration ==  0 && sequence.count == 1)
            let sequenceAction = SKAction.sequence(sequence)
            
            if isDurationTimeZero {
                action = sequenceAction
            } else {
                action = SKAction.repeatAction(sequenceAction, count: times ?? Int.max)
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
    
    func buildSKActionsTimeline<T: SKActionKeyFrame, Data: AnyObject>(data: Data, keyframes: [T]) -> [SKAction]? {
        
        var actions: [SKAction] = []
        var previousElement: SKActionKeyFrame?
        var duration: Double = 0
        
        previousElement = keyframes.first
        
        if var previousElement = previousElement {

            if let action = previousElement.toSKAction(data, duration: 0, curve: previousElement.curveToApply()) {
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
    
    
    
}