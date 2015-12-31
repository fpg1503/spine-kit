//
//  SlotKeyFranme.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 12/30/15.
//  Copyright © 2015 Thiago Medeiros dos Santos. All rights reserved.
//

import Foundation


struct AttachmentKeyFrame {
    var time: Double
    var name: String?
}

extension AttachmentKeyFrame: JSONDecodable {
    
    static func decode(json: JSON?) -> AttachmentKeyFrame? {
        
        let time = asSafeDouble(json, key: "time")
        let name = asString(json, key: "name")

        return AttachmentKeyFrame(time: time, name: name)
    }
}
