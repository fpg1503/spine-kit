//
//  ScaleKeyFrame.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 12/30/15.
//  Copyright © 2015 Thiago Medeiros dos Santos. All rights reserved.
//

struct ScaleKeyFrame {
    var time: Double
    var x: Double?
    var y: Double?
    var curve: Curve?
}

extension ScaleKeyFrame: JSONDecodable {
    
    static func decode(json: JSON?) -> ScaleKeyFrame? {
        
        let time = asSafeDouble(json, key: "time")
        let x = asDouble(json, key: "x")
        let y = asDouble(json, key: "y")
        
        return ScaleKeyFrame(time: time, x: x, y: y, curve: Curve.decode(json))
    }
}
