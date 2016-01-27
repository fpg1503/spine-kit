//
//  DrawOrderController.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 1/27/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//

import SpriteKit

class DrawOrderController {
    
    private var slotsDict: [String: SKSlotNode]

    init(slotsDict: [String: SKSlotNode]) {
        self.slotsDict = slotsDict
    }
    
    func applyOffsets(offsets: [DrawOrderOffset]) {

        if offsets.isEmpty {
            
            //Save pose and apply again (Don't use initial index)
            self.slotsDict.values.forEach { slotOfDict in slotOfDict.zPosition = CGFloat(slotOfDict.initialZIndex ?? 0) }
            
        } else {
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
    }
}