//
//  RotateKeyFrame+SKAction.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 1/12/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//

import SpriteKit

extension RotateKeyFrame {
    
    func toSKAction() -> SKAction? {
        var result: SKAction? = nil
        if let angle = self.angle {
            result = SKAction.rotateByAngle(CGFloat(angle.degreesToRadians), duration: self.time)
        }
        return result
    }
}