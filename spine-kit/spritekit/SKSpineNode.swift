//
//  SKSpineNode.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 1/11/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//

import SpriteKit



class SKSpineNode: SKNode, SpineNodeType {
    
    typealias BoneType = SKBoneNode
    typealias SlotType = SKSlotNode
    
    private var animationController: AnimationController?
    private var skinController: SkinController<SlotType>?
    private var drawOrderController: DrawOrderController?
    
    private var canChangeSkin: Bool = false
    private var bonesDict: [String: SKBoneNode] = [:]
    private var slotsDict: [String: SKSlotNode] = [:]
    
    required init(animationController: AnimationController, skinController: SkinController<SlotType>, drawOrderController: DrawOrderController, bonesDict: [String: SKBoneNode], slotsDict: [String: SKSlotNode], canChangeSkin: Bool) {
        super.init()
        self.animationController = animationController
        self.drawOrderController = drawOrderController
        self.skinController = skinController
        self.slotsDict = slotsDict
        self.bonesDict = bonesDict
        self.canChangeSkin = canChangeSkin
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
    
    func changeSkin(name: String) -> Bool {

        if self.canChangeSkin {
            skinController?.changeSkin(name, slotsDict: self.slotsDict)
        } else {
            print("Warning: If you want to use skin you must create the spine node with a initial skin")
        }
        return canChangeSkin
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
    
    func findBoneNode(name: String) -> SKBoneNode? {
        return self.bonesDict[name] ?? nil
    }
    
    func findSlotNode(name: String) -> SKSlotNode? {
        return self.slotsDict[name] ?? nil
    }
    
    func setupPose() {
        animationController?.setupPose(self.bonesDict)
    }
    
    deinit {
        self.stop()
    }
}