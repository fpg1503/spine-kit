//
//  RotateKeyFrame.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 12/30/15.
//  Copyright © 2015 Thiago Medeiros dos Santos. All rights reserved.
//

import Foundation

struct RotateKeyFrame {
    var time: Double
    var angle: Double?
    var curve: Curve?
}

extension RotateKeyFrame: JSONDecodable {
    
    static func decode(json: JSON?) -> RotateKeyFrame? {
        
        let time = asSafeDouble(json, key: "time")
        let angle = asDouble(json, key: "angle")
        
        return RotateKeyFrame(time: time, angle: angle, curve: Curve.decode(json))
    }
}
