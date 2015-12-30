//
//  Animation.swift
//  spritekit-spine-sdk
//
//  Created by Thiago Medeiros dos Santos on 12/16/15.
//  Copyright © 2015 Thiago Medeiros dos Santos. All rights reserved.
//

import Foundation

struct Attachment {
    var name: String
    var x: Double
    var y: Double
    var scaleX: Double
    var scaleY: Double
    var rotation: Double
    var width: Int
    var height: Int
}

extension Attachment: JSONDecodable {
 
    static func decode(json: JSON?) -> Attachment? {
        
        let name = asSafeString(json, key: "name")
        
        let x = asSafeDouble(json, key:"x", defaultValue: 0)
        let y = asSafeDouble(json, key:"y", defaultValue: 0)

        let scaleX = asSafeDouble(json, key:"scaleX", defaultValue: 1)
        let scaleY = asSafeDouble(json, key:"scaleY", defaultValue: 1)

        let rotation = asSafeDouble(json, key:"rotation", defaultValue: 0)

        let width = asSafeInt(json, key:"width", defaultValue: 0)
        let height = asSafeInt(json, key:"height", defaultValue: 0)

        return Attachment(name: name, x: x, y: y, scaleX: scaleX, scaleY: scaleY, rotation: rotation, width: width, height: height)
    }
}
