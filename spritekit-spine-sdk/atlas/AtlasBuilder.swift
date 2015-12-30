//
//  AtlasLoader.swift
//  spritekit-spine-sdk
//
//  Created by Thiago Medeiros dos Santos on 12/18/15.
//  Copyright © 2015 Thiago Medeiros dos Santos. All rights reserved.
//

import Foundation
import SpriteKit


struct AtlasBuilder {
    
    func load(skeleton: Skeleton?) -> SKTextureAtlas? {
        
        var result: SKTextureAtlas? = nil
        
        if let skeleton = skeleton {
           result = SKTextureAtlas(named: skeleton.name)
        }
        return result
    }
}