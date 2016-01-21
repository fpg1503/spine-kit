//
//  TimelineBuilder.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 1/21/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//

import SpriteKit

class TimelineBuilder {
    
    func buildTimelinesSKActionGroup(timelineSequences: [SKAction]?...) -> SKAction? {
        
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
    
    func buildSKActionsTimeline<T: SKActionKeyFrame>(nodeToAnimate: SKNode, keyframes: [T]) -> [SKAction]? {
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