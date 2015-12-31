//
//  SpineBuilder.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 12/18/15.
//  Copyright © 2015 Thiago Medeiros dos Santos. All rights reserved.
//

import Foundation

import SpriteKit

class SpineBuilder {
    
    func buildSpine(name: String, skinName: String = "default", completion: (SKNode) -> Void) {
        completion(SKSpriteNode())
    }
}