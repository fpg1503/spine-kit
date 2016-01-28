//
//  DrawOrderController.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 1/27/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//

import SpriteKit

// Design considerations:
//
// 1- Possible double resposability. Consider separate between animation and regular draw order.
// 2- Think how to remove slotsDict from here just. Will be helpfull maintain this state in just one class.
//

class DrawOrderController {
    
    private static var maxZPosition: CGFloat = 0
    
    private var animationInitialPose: [String: CGFloat] = [:]
    
    private var drawOrderIndex: [String: Double] = [:]

    private var slotsDict: [String: SKSlotNode]

    init(slots: [Slot]?, slotsDict: [String: SKSlotNode]) {
        self.slotsDict = slotsDict
        self.drawOrderIndex = self.buildDrawOrderIndex(slots)
    }
    
    func setupSlotsDrawOrder() {
        slotsDict.forEach { (slotName, slotNode) in
            slotNode.zPosition = CGFloat(self.drawOrderIndex[slotName] ?? 0)
        }
    }
    
    func setupRootDrawOrder(root: SKSpineNode?) {
        root?.zPosition = DrawOrderController.maxZPosition
        
        if let zPosition = self.drawOrderIndex.values.maxElement() {
            DrawOrderController.maxZPosition += CGFloat(zPosition) + 1
        }
    }
    
    private func buildDrawOrderIndex(slots: [Slot]?) -> [String: Double] {
        
        var result: [String: Double] = [:]
        if let slots = slots {
            for (index, slot) in slots.enumerate() {
                result[slot.name] = Double(index)
            }
        }
        return result
    }

    func applyAnimationOffsets(offsets: [DrawOrderOffset]) {
        
        self.createAnimationInitialPoseVectorIfNeeded()
        
        if offsets.isEmpty {
            
            self.setupAnimationInitialPose()
            
        } else {
            
            self.setupAnimationOffset(offsets)
        }
    }
    
    private func setupAnimationOffset(offsets: [DrawOrderOffset]) {
        
        offsets.forEach { offset in
            
            if let slotToMove = self.slotsDict[offset.slot]  {
                
                let beginIndex = slotToMove.zPosition
                let endIndex = CGFloat(slotToMove.zPosition) + CGFloat(offset.offset)
                
                self.slotsDict.forEach { (_, slot) in
                    
                    //shift zPositions between begin index and end index
                    if slot.zPosition >= beginIndex && slot.zPosition <= endIndex {
                        slot.zPosition += (beginIndex < endIndex ? -1 : 1)
                    }
                }
                
                slotToMove.zPosition += CGFloat(offset.offset) + (beginIndex < endIndex ? 1 : -1)
            }
        }
    }
    
    private func setupAnimationInitialPose() {
        
        self.slotsDict.forEach { (key, value) in

            if let zIndex = self.animationInitialPose[key] {
                value.zPosition = zIndex
            }
        }
    }
    
    private func createAnimationInitialPoseVectorIfNeeded() {

        if self.animationInitialPose.isEmpty || self.animationInitialPose.count != slotsDict.count {
            
            self.slotsDict.forEach{(_, value) in
                
                if let nodeName = value.name {
                    self.animationInitialPose[nodeName] = value.zPosition
                }
            }
        }
    }
}