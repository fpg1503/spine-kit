//
//  EventKeYframe+SKAction.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 1/23/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//
import SpriteKit

extension EventKeyFrame: SKActionKeyFrame {
    
    func basicAction<Context>(context: Context, duration: Double) -> SKAction? {

        var result: SKAction? = nil
        
        if let eventHandler = context as? EventHandler {
            result = SKAction.runBlock({ () -> Void in
                eventHandler.fire(self.name, text: self.string, decimalNumber: self.double, integerNumber: self.int)
            })
        }
        return result
    }
    
    func animationTime() -> Double {
        return self.time
    }
}