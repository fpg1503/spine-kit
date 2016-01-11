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
    
    func buildFromResources(name: String) -> SKTextureAtlas? {
        return SKTextureAtlas(named: name)
    }
    
    //TODO build from remote
    
    //TODO build creating atlas in runtime
}