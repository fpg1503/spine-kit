//
//  ScaleKeyFrame+SKAction.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 1/12/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//

import SpriteKit

extension ScaleKeyFrame {
    
    func toSKAction() -> SKAction? {
        var result: SKAction? = nil
        if let x = self.x, let y = self.y {
            result = SKAction.group([SKAction.scaleXTo(CGFloat(x), duration: self.time), SKAction.scaleXTo(CGFloat(y), duration: self.time)])
        }
        return result
    }
}