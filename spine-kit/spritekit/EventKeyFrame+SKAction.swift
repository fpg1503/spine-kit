//
//  EventKeYframe+SKAction.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 1/23/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//
import SpriteKit

extension EventKeyFrame: SKActionKeyFrame {
    
    func linearAction<Context>(context: Context, duration: Double) -> SKAction? {
        return nil
    }
    func animationData() -> (time: Double, curve: Curve) {
        return (self.time,  Curve.Stepped)
    }
}