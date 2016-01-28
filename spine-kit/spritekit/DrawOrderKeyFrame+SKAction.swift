//
//  DrawOrderKeyFrame.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 1/27/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//
import SpriteKit

extension DrawOrderKeyFrame: SKActionKeyFrame {
    
    func basicAction<Context>(context: Context, duration: Double) -> SKAction? {
        
        var result: SKAction? = nil
        
        if let slotsDict = context as? [String: SKSlotNode] {
            
            result = SKAction.runBlock({ () -> Void in
                
                    if self.offsets.isEmpty {
                        
                        slotsDict.forEach { (_, slot) in slot.revertDrawOrderModifications() }
                        
                    } else {
                        
                        self.setupAnimationOffset(self.offsets, slotsDict: slotsDict)
                    }
                }
            )
        }
        return result
    }
    
    private func setupAnimationOffset(offsets: [DrawOrderOffset], slotsDict: [String: SKSlotNode]) {
        
        offsets.forEach { offset in
            
            if let slotToMove = slotsDict[offset.slot], let _ = slotToMove.drawOrder  {
                
                let beginIndex = slotToMove.zPosition
                let endIndex = CGFloat(slotToMove.zPosition) + CGFloat(offset.offset)
                
                slotsDict.forEach { (_, slot) in
                    
                    //shift zPositions between begin index and end index
                    if let _ = slot.drawOrder where slot.zPosition >= beginIndex && slot.zPosition <= endIndex {
                        let offset = (beginIndex < endIndex ? -1 : 1)
                        slot.addDrawOrderModification(offset)
                    }
                }
                
                let offset = offset.offset + (beginIndex < endIndex ? 1 : -1)
                slotToMove.addDrawOrderModification(offset)
            }
        }
    }
    
    func animationTime() -> Double {
        return self.time
    }
}