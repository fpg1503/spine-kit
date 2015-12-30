//
//  DrawOrderOffset.swift
//  spritekit-spine-sdk
//
//  Created by Thiago Medeiros dos Santos on 12/30/15.
//  Copyright © 2015 Thiago Medeiros dos Santos. All rights reserved.
//

import Foundation

struct DrawOrderOffset {
    let slot: String
    let offset: Int
}

extension DrawOrderOffset: JSONDecodable {
    
    static func decode(json: JSON?) -> DrawOrderOffset? {
        
        let slot = asSafeString(json, key: "slot")
        let offset = asSafeInt(json, key: "offset")

        return DrawOrderOffset(slot: slot, offset: offset)
    }
}
