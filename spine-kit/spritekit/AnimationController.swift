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
    var bonesDict: [String: SKNode] = [:]
    
    init(animations: [Animation]?, bonesDict: [String: SKNode]?) {
        if let bonesDict = bonesDict {
            self.bonesDict = bonesDict
        }
        if let animations = animations {
            animations.forEach{ animation in self.animationsDict[animation.name] = animation }
        }
    }
    
    func play(animationName: String) {

        let animation: Animation? = self.animationsDict[animationName]
        
        if let bonesTimelines = animation?.boneTimelines {
            
            for boneTimeline in bonesTimelines {
                
                if let boneName = boneTimeline.name {
          
                    let translateActions: [SKAction]? = self.buildSKActionsTimeline(boneTimeline.translate)
                    let scaleActions: [SKAction]? = self.buildSKActionsTimeline(boneTimeline.scale)
                    let rotateActions: [SKAction]? = self.buildSKActionsTimeline(boneTimeline.rotate)

                    if let bone = self.bonesDict[boneName], let group = self.buildGroup(translateActions, scaleActions, rotateActions) {
                        bone.runAction(group)
                    }
                }
            }
        }
    }
    
    private func buildGroup(timelineSequences: [SKAction]?...) -> SKAction? {

        var result: SKAction? = nil
        var sequences: [SKAction] = []
        
        for sequence in timelineSequences {
            if let sequence = sequence {
                if !sequence.isEmpty {
                    sequences.append(SKAction.repeatActionForever(SKAction.sequence(sequence)))
                }
            }
        }
        
        if !sequences.isEmpty {
            result = SKAction.group(sequences)
        }
        return result
    }
    
    private func buildSKActionsTimeline<T: SKActionKeyFrame>(keyframes: [T]) -> [SKAction]? {
        var lastFrameTime: Double = 0
        var actions: [SKAction] = []
    
        keyframes.forEach  { keyFrame in
            if let action = keyFrame.toSKAction(lastFrameTime, curve: keyFrame.animationData().curve) {
                actions.append(action)
                lastFrameTime = keyFrame.animationData().time
            }
        }
        return actions.isEmpty ? nil : actions
    }
    
}
