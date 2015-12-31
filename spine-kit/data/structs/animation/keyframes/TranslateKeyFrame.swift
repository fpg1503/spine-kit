//
//  TimelineEntry.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 12/17/15.
//  Copyright © 2015 Thiago Medeiros dos Santos. All rights reserved.
//

import Foundation

struct TranslateKeyFrame {
    var time: Double
    var x: Double?
    var y: Double?
    var curve: Curve?
}

extension TranslateKeyFrame: JSONDecodable {
    
    static func decode(json: JSON?) -> TranslateKeyFrame? {
        
        let time = asSafeDouble(json, key: "time")
        let x = asDouble(json, key: "x")
        let y = asDouble(json, key: "y")
        
        return TranslateKeyFrame(time: time, x: x, y: y, curve: Curve.decode(json))
    }
}
