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
    
    func buildSpine(name: String, skinName: String = "default") -> SKNode {
        let result = SKSpriteNode()
        
        if let spine = self.loadSpine(name), let atlas = AtlasBuilder().load(spine) {
            
            for slot in spine.slots {
                
                let skin = spine.skins.filter({ (skin) -> Bool in
                    return skin.name == skinName
                }).first
                
                if let skin = skin {
                    let texture = atlas.textureNamed(slot.name)
                    let node = SKSpriteNode(texture: texture)
                    
                    let pairKey = PairKey(key1: slot.name, key2: slot.attachment)
                    print("\(pairKey)")
                    
                    if let attachment = skin.entries[pairKey] {
                        print("\(attachment)")
                        node.position = CGPoint(x: attachment.x, y: attachment.y)
                        //TODO: set sizes and etc
                        result.addChild(node)
                    }
                }
            }
        }
        //TODO: should we throw an exception if we can't load the atlas or spine file?
        
        return result
    }
    
    func loadSpine(name: String) -> SpineModel? {
        if let json = FileHelper.loadTextFile(name, type: "json") {
            return SpineParse().parse(name, data: json)
        }
        return nil
    }
}