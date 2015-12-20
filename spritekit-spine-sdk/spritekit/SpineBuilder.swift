//
//  SpineBuilder.swift
//  spritekit-spine-sdk
//
//  Created by Thiago Medeiros dos Santos on 12/18/15.
//  Copyright © 2015 Thiago Medeiros dos Santos. All rights reserved.
//

import Foundation

import SpriteKit

class SpineBuilder {
    
    func buildSpine(name: String, skinName: String = "default", completion: (SKNode) -> Void) {
        let result = SKSpriteNode()
        if let spine = self.loadSpine(name) {
            let atlas = AtlasBuilder().load(spine)
            atlas?.preloadWithCompletionHandler {
                for (i, slot) in spine.slots.enumerate() {
                    
                    let skin = spine.skins.filter({ (skin) -> Bool in
                        return skin.name == skinName
                    }).first
                    
                    if let skin = skin {
                        let texture = atlas?.textureNamed(slot.name)
                        let node = SKSpriteNode(texture: texture)
                        
                        let pairKey = PairKey(key1: slot.name, key2: slot.attachment)
                        print("\(pairKey)")
                        if let attachment = skin.entries[pairKey] {
                            print("\(attachment)")
                            node.size = CGSize(width: 10.0, height: 10.0)
                            node.position = CGPoint(x: 10.0*CGFloat(i), y: 10.0*CGFloat(i))
                            //                        node.position = CGPoint(x: attachment.x, y: attachment.y)
                            result.addChild(node)
                        }
                    }
                }
                
                completion(result);
            }
        }
    }
    
    func loadSpine(name: String) -> SpineModel? {

        if let json = FileHelper.loadTextFile(name, type: "json") {
            return SpineParse().parse(name, data: json)
        }
        return nil
    }
}