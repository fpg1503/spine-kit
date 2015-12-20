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
    
    func load(spine: SpineModel?) -> SKTextureAtlas? {
        if let spine = spine {
            return SKTextureAtlas(named: spine.name)
        }
        
        return nil
    }
    
}