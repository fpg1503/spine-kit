//
//  TimelineBuilder.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 1/21/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//

import SpriteKit

class TimelineBuilder {

    func buildTimelineSKActions(sequence: [SKAction]?, times: Int?) -> SKAction? {
        var result: SKAction? = nil
        if let sequence = sequence {
            
            let isDurationTimeZero = (sequence.first?.duration ==  0 && sequence.count == 1)
            
            if isDurationTimeZero {
                result = SKAction.sequence(sequence)
            } else {
                result = SKAction.repeatAction(SKAction.sequence(sequence), count: times ?? Int.max)
            }
        }
        return result
    }
    
    func buildTimelinesSKActionGroup(timelineSequences: [SKAction]?..., times: Int?) -> SKAction? {
        
        var result: SKAction? = nil
        var sequences: [SKAction] = []
        
        timelineSequences.forEach { sequence in
            
            if let sequence = sequence where !sequence.isEmpty {
                
                if let action =  self.buildTimelineSKActions(sequence, times: times) {
                    sequences.append(action)
                }
            }
        }
        
        if !sequences.isEmpty {
            result = SKAction.group(sequences)
        }
        return result
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