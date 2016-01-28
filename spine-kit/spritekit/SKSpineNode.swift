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
    private var skinController: SkinController?
    private var drawOrderController: DrawOrderController?
    
    private var bonesDict: [String: SKBoneNode] = [:]
    private var slotsDict: [String: SKSlotNode] = [:]
    
    init(animationController: AnimationController, skinController: SkinController, drawOrderController: DrawOrderController, bonesDict: [String: SKBoneNode], slotsDict: [String: SKSlotNode]) {
        super.init()
        self.animationController = animationController
        self.drawOrderController = drawOrderController
        self.skinController = skinController
        self.slotsDict = slotsDict
        self.bonesDict = bonesDict
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func play(name: String, times: Int? = nil, merge: Bool? = false, completion: AnimationCallback? = nil) {
        animationController?.animate(name, bonesDict: self.bonesDict, slotsDict: self.slotsDict, times: times, merge: merge, completion: completion)
    }
    
    func pause() {
        super.paused = true
    }

    func resume() {
        super.paused = false
    }

    func stop() {
        animationController?.stop(bonesDict: self.bonesDict, slotsDict: self.slotsDict)
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
        return self.bonesDict[name] ?? nil
    }
    
    func findSlotNode(name: String) -> SKNode? {
        return self.slotsDict[name] ?? nil
    }
    
    func setupPose() {
        animationController?.setupPose(self.bonesDict)
    }
    
    deinit {
        self.stop()
    }
}