//
//  TranslateKeyFrame+SKAction.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 1/12/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//

import SpriteKit

extension TranslateKeyFrame {
    
    func toSKAction() -> SKAction? {
        var result: SKAction? = nil
        if let x = self.x, let y = self.y {
            result = SKAction.moveTo(CGPoint(x: CGFloat(x), y: CGFloat(y)), duration: self.time)
        }
        return result
    }
}