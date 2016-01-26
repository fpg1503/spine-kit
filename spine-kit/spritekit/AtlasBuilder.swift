//
//  AtlasBuilder.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 1/25/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//

import SpriteKit

class AtlasBuilder {

    func build(name: String) -> SKTextureAtlas? {
        return SKTextureAtlas(named: name)
    }
    
    func buildWithDescriptor(descriptor: String, image: UIImage) -> SKTextureAtlas? {
        
        return SpineTextureAtlas(descriptor: descriptor, texture: SKTexture(image: image))
    }
    
    func buildFromPath(fileName: String, image: UIImage) -> SKTextureAtlas? {
        
        let file = FileHelper.loadTextFile(fileName, type: ".atlas")
        var result: SKTextureAtlas? = nil
        
        if let file = file {
            result = SpineTextureAtlas(descriptor: file, texture: SKTexture(image: image))
        }
        return result
    }
}