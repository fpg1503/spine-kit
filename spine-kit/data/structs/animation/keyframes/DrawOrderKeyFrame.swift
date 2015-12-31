//
//  DrawOrderKeyFrame.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 12/30/15.
//  Copyright © 2015 Thiago Medeiros dos Santos. All rights reserved.
//

import Foundation

struct DrawOrderKeyFrame {
    let time: Double
    let offsets: [DrawOrderOffset]
}


extension DrawOrderKeyFrame: JSONDecodable {
    
    static func decode(json: JSON?) -> DrawOrderKeyFrame? {
        
        let time = asSafeDouble(json, key: "time")
        var offsets: [DrawOrderOffset] = []

        let offsetsJSON = asSafeJSONArray(json, key: "offsets")
        for offsetJSON in offsetsJSON {
            if let offset = DrawOrderOffset.decode(offsetJSON) {
                offsets.append(offset)
            }
        }
        return DrawOrderKeyFrame(time: time, offsets: offsets)
    }
}
