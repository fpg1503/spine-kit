//
//  KeyFrame+SKAction.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 1/12/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//
import SpriteKit

protocol SKActionKeyFrame {
    
    func toSKAction(timeOffset: Double, curve: Curve) -> SKAction?
    
    func animationData() -> (time: Double, curve: Curve)
    
}

