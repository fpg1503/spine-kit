//
//  SKSpineNode.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 1/11/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//

import SpriteKit



class SKSpineNode: SKNode {
    
    private var animationController: AnimationController?

    init(animationController: AnimationController?) {
        super.init()
        self.animationController = animationController
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func play(name: String, times: Int? = nil, merge: Bool? = false, completion: AnimationCallback? = nil) {
        if let animationController = self.animationController {
            animationController.play(name, times: times, merge: merge, completion: completion)
        }
    }
    
    func pause() {
        super.paused = true
    }

    func resume() {
        super.paused = false
    }

    func stop() {
        animationController?.stop()
    }
    
    func changeSkin(name: String) {
        //TODO
    }
    
    func addSpineNodeToBone(name: String, node: SKSpineNode) -> Bool {
        //TODO
        return true
    }
    
    func removeSpineNodeFromBone(name: String, node: SKSpineNode) -> Bool {
        //TODO
        return true
    }

    func registerToEvent(eventName: String, functionId: String? = nil, function: SpineKitEventFunction) {
        animationController?.eventHandler.registerToEvent(eventName, functionId: functionId, function: function)
    }

    func unregisterToEvent(eventName: String, functionId: String? = nil) -> Bool {
        return animationController?.eventHandler.unregisterToEvent(eventName, functionId: functionId) ?? false
    }

    func removeEventFunctions(eventName: String) -> Bool {
        return animationController?.eventHandler.removeEventFunctions(eventName) ?? false
    }

    func findBoneNode(name: String) -> SKNode? {
        return animationController?.findBoneNode(name)
    }

    func findSlotNode(name: String) -> SKNode? {
        return animationController?.findSlotNode(name)
    }

    func setupPose() {
        self.children.forEach { child in
            if let boneChild = child as? SKBoneNode {
                boneChild.setupPose()
            }
        }
    }
}