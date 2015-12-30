//
//  Bone.swift
//  spritekit-spine-sdk
//
//  Created by Thiago Medeiros dos Santos on 12/16/15.
//  Copyright © 2015 Thiago Medeiros dos Santos. All rights reserved.
//

import Foundation

struct Bone {
    let name: String
    let parent: String?
    let length: Int
    let x: Double
    let y: Double
    let scaleX: Double
    let scaleY: Double
    let rotation: Double
    let inheritRotation: Bool
    let inheritScale: Bool
}

extension Bone: JSONDecodable {
    
    static func decode(json: JSON?) -> Bone? {
        
        let name = asSafeString(json, key: "name")
        let parent = asString(json, key: "parent")

        let length = asSafeInt(json, key:"length", defaultValue: 0)
        
        let x = asSafeDouble(json, key:"x", defaultValue: 0)
        let y = asSafeDouble(json, key:"y", defaultValue: 0)
        
        let scaleX = asSafeDouble(json, key:"scaleX", defaultValue: 1)
        let scaleY = asSafeDouble(json, key:"scaleY", defaultValue: 1)
        
        let rotation = asSafeDouble(json, key:"rotation", defaultValue: 0)
        
        let inheritRotation = asSafeBool(json, key: "inheritRotation", defaultValue: false)
        let inheritScale = asSafeBool(json, key: "inheritScale", defaultValue: false)
        
        return Bone(name: name, parent: parent, length: length, x: x, y: y, scaleX: scaleX, scaleY: scaleY, rotation: rotation, inheritRotation: inheritRotation, inheritScale: inheritScale)
    }
}
