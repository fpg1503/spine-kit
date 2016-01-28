//
//  DrawOrderController.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 1/27/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//

import SpriteKit


class DrawOrderController {
    
    private static var maxZPosition: CGFloat = 0
    
    func setupDrawOrder(slots: [Slot]?, slotsDict: [String: SKSlotNode], root: SKSpineNode?) {

        let drawOrderIndex = self.buildDrawOrderIndex(slots)
        slotsDict.forEach { (slotName, slotNode) in slotNode.setDrawOrder(drawOrderIndex[slotName] ?? 0) }
        
        if let zPosition = drawOrderIndex.values.maxElement() {
            DrawOrderController.maxZPosition += CGFloat(zPosition) + 1
        }
        
        root?.zPosition = DrawOrderController.maxZPosition
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
}