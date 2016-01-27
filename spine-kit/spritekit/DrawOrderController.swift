//
//  DrawOrderController.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 1/27/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//
import SpriteKit

class DrawOrderController {
    
    private var maxZOrder: CGFloat = 0
    
    private var slotsDict: [String: SKSlotNode] = [:]

    private var indexMap: [String: Double]

    init(indexMap: [String: Double], slotsDict: [String: SKSlotNode]) {
        self.slotsDict = slotsDict
        self.indexMap = indexMap
    }
    
    func applyOffsets(offsets: [DrawOrderOffset]) {

        offsets.forEach { offset in
            // TODO change order
        }
    }
}