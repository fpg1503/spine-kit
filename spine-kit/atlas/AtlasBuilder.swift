//
//  AtlasLoader.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 12/18/15.
//  Copyright © 2015 Thiago Medeiros dos Santos. All rights reserved.
//

import Foundation
import SpriteKit


struct AtlasBuilder {
    
    func load(spineModel: SpineModel?) -> SKTextureAtlas? {
        
        var result: SKTextureAtlas? = nil
        
        if let spineName = spineModel?.name {
           result = SKTextureAtlas(named: spineName)
        }
        return result
    }
}