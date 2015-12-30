//
//  TimelineEntry.swift
//  spritekit-spine-sdk
//
//  Created by Thiago Medeiros dos Santos on 12/17/15.
//  Copyright © 2015 Thiago Medeiros dos Santos. All rights reserved.
//

import Foundation

struct TransformationKeyFrame {
    var time: Double
    var angle: Double?
    var x: Double?
    var y: Double?
    var curve: Curve?
}

extension TransformationKeyFrame: JSONDecodable {
    
    static func decode(json: JSON?) -> TransformationKeyFrame? {
        
        let time = asSafeDouble(json, key: "time")
        let angle = asDouble(json, key: "angle")
        let x = asDouble(json, key: "x")
        let y = asDouble(json, key: "y")
        
        return TransformationKeyFrame(time: time, angle: angle, x: x, y: y, curve: Curve.decode(json))
    }
}
