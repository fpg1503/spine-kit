//
//  DrawOrderController.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 1/27/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//

import SpriteKit

class DrawOrderController {
    
    private var pose: [String: CGFloat] = [:]
    private var slotsDict: [String: SKSlotNode]

    init(slotsDict: [String: SKSlotNode]) {
        self.slotsDict = slotsDict
    }
    
    func applyOffsets(offsets: [DrawOrderOffset]) {

        self.createPoseVectorIfNeeded()
        
        if offsets.isEmpty {
            
          self.setupPose()
            
        } else {
            
           self.setupWithOffsets(offsets)
        }
    }
    
    private func setupWithOffsets(offsets: [DrawOrderOffset]) {
        offsets.forEach { offset in
            
            if let slot = self.slotsDict[offset.slot]  {
                
                let beginIndex = slot.zPosition
                let endIndex = CGFloat(slot.zPosition) + CGFloat(offset.offset)
                
                self.slotsDict.values.forEach { slotOfDict in
                    
                    if slotOfDict.zPosition >= beginIndex && slotOfDict.zPosition <= endIndex {
                        slotOfDict.zPosition += (beginIndex < endIndex ? -1 : 1)
                    }
                }
                slot.zPosition += CGFloat(offset.offset) + (beginIndex < endIndex ? 1 : -1)
            }
        }
    }
    
    private func setupPose() {
        self.slotsDict.forEach { (key, value) in
            if let zIndex = self.pose[key] {
                value.zPosition = zIndex
            }
        }
    }
    
    private func createPoseVectorIfNeeded() {

        if self.pose.isEmpty || self.pose.count != slotsDict.count {
            self.slotsDict.forEach{(_, value) in
                if let nodeName = value.name {
                    self.pose[nodeName] = value.zPosition
                }
            }
        }

    }
}