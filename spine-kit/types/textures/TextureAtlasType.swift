//
//  TextureAtlasType.swift
//  spine-kit
//
//  Created by Francesco Perrotti-Garcia on 2/5/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//

import Foundation

protocol TextureAtlasType {
    typealias Texture: TextureType
    
    func textureNamed(name: String) -> Texture
}