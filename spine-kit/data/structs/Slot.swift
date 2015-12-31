//
//  Slot.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 12/16/15.
//  Copyright © 2015 Thiago Medeiros dos Santos. All rights reserved.
//

import Foundation
import UIKit

struct Slot {
    var name: String
    var bone: String?
    var color: UIColor?
    var attachment: String?
    var additiveBlending: Bool
}

extension Slot: JSONDecodable {
    
    static func decode(json: JSON?) -> Slot? {
        
        let grayInHex = "#808080FF"
        let name = asSafeString(json, key: "name")
        let bone = asString(json, key: "bone")
        let color = asSafeString(json, key: "color", defaultValue: grayInHex)
        let attachment = asString(json, key: "attachment")
        let additiveBlending = asSafeBool(json, key: "additiveBlending")
        
        return Slot(name: name, bone: bone, color: UIColor(hex: color), attachment: attachment, additiveBlending: additiveBlending)
    }
}
