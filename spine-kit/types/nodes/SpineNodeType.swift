//
//  SpineNodeType.swift
//  spine-kit
//
//  Created by Francesco Perrotti-Garcia on 2/5/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//

import CoreGraphics

protocol SpineNodeType: NodeType {
    typealias BoneNode: BoneNodeType
    typealias SlotNode: SlotNodeType
    
    init(animationController: AnimationController, skinController: SkinController, drawOrderController: DrawOrderController, bonesDict: [String: BoneNode], slotsDict: [String: SlotNode], canChangeSkin: Bool)
    
    func play(name: String, times: Int?, merge: Bool?, completion: AnimationCallback?)
    
    func pause()
    
    func resume()
    
    func stop()
    
    func changeSkin(name: String) -> Bool
    func registerToEvent(eventName: String, functionId: String?, function: SpineKitEventFunction)
    
    func unregisterToEvent(eventName: String, functionId: String?) -> Bool
    func removeEventFunctions(eventName: String) -> Bool
    func findBoneNode(name: String) -> BoneNode?
    func findSlotNode(name: String) -> SlotNode?
    func setupPose()

}