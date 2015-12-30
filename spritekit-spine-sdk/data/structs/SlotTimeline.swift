//
//  SlotsTimeline.swift
//  spritekit-spine-sdk
//
//  Created by Thiago Medeiros dos Santos on 12/30/15.
//  Copyright © 2015 Thiago Medeiros dos Santos. All rights reserved.
//

import Foundation

struct SlotTimeline {
    var name: String
    let attachment: [AttachmentKeyFrame]
    let color: [ColorTransitionKeyFrame]
}

extension SlotTimeline: JSONDecodable {
    
    static func decode(json: JSON?) -> SlotTimeline? {
        
        return nil
    }
}
