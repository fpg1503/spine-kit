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
          
                    var translateActions: [SKAction] = []
                    var lastFrameTime: Double = 0

                    boneTimeline.translate.forEach  { keyFrame in
                        if let action = keyFrame.toSKAction(lastFrameTime, curve: keyFrame.curve) {
                            translateActions.append(action)
                            lastFrameTime = keyFrame.time
                        }
                    }
                    
                    var scaleActions: [SKAction] = []
                    lastFrameTime = 0
                    boneTimeline.scale.forEach  { keyFrame in
                        if let action = keyFrame.toSKAction(lastFrameTime, curve: keyFrame.curve) {
                            scaleActions.append(action)
                                lastFrameTime = keyFrame.time
                        }
                    }
                    
                    var rotateActions: [SKAction] = []
                    lastFrameTime = 0
                    boneTimeline.rotate.forEach { keyFrame in
                        if let action = keyFrame.toSKAction(lastFrameTime, curve: keyFrame.curve) {
                            rotateActions.append(action)
                            lastFrameTime = keyFrame.time
                        }
                    }
                    
                    if let bone = self.bonesDict[boneName] {
                        if rotateActions.count > 0 {
                            bone.runAction(SKAction.repeatActionForever(SKAction.sequence(rotateActions)))
                        }
                        
                        if scaleActions.count > 0 {
                            bone.runAction(SKAction.repeatActionForever(SKAction.sequence(scaleActions)))
                        }
                        
                        if translateActions.count > 0 {
                            bone.runAction(SKAction.repeatActionForever(SKAction.sequence(translateActions)))
                        }
                    }
                }
            }
        }
    }
    
}
