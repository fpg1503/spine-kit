//
//  BoneTimeline.swift
//  spritekit-spine-sdk
//
//  Created by Thiago Medeiros dos Santos on 12/30/15.
//  Copyright © 2015 Thiago Medeiros dos Santos. All rights reserved.
//

import Foundation

struct BoneTimeline {
    var name: String?
    let rotate: [TransformationKeyFrame]
    let translate: [TransformationKeyFrame]
    let scale: [TransformationKeyFrame]
}

extension BoneTimeline: JSONDecodable {
    
    static func decode(json: JSON?) -> BoneTimeline? {
        
        return nil
    }
}
