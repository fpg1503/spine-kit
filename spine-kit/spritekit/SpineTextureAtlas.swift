//
//  SpineTextureAtlas.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 1/25/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//
import SpriteKit

class SpineTextureAtlas: SKTextureAtlas {
   
    override var textureNames: [String] { get {  return [] } }
    
    init(descriptor: String, texture: SKTexture) {
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textureNamed(name: String) -> SKTexture {
        return SKTexture()
    }
    
    override class func preloadTextureAtlases(textureAtlases: [SKTextureAtlas], withCompletionHandler completionHandler: () -> Void) {
    }
    
    override class func preloadTextureAtlasesNamed(atlasNames: [String], withCompletionHandler completionHandler: (NSError?, [SKTextureAtlas]) -> Void) {
    }
    
    override func preloadWithCompletionHandler(completionHandler: () -> Void) {
    }
}