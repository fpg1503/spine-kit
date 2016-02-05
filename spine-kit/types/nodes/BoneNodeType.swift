//
//  BoneNodeType.swift
//  spine-kit
//
//  Created by Francesco Perrotti-Garcia on 2/5/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//

import CoreGraphics

protocol BoneNodeType: NodeType {
    
    init(bone: Bone)
    
    func addSlot(slotNode: SKSlotNode)
    func originCGPoint() -> CGPoint
    func originCGScale() -> (xScale: CGFloat, yScale: CGFloat)
    func rotation() -> Double
    func setupPose()
}